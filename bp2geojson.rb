require 'find'
require 'exifr'
require 'json'

src_dirs = %w{YOUR FOLDERS PLEASE}
dst_path = 'out.geojson'

count = 0
n_wrong = 0
json = {:type => :FeatureCollection, :features => []}
src_dirs.each {|src_dir|
  Find.find(src_dir) {|path|
    next unless path.downcase.end_with?('jpg')
    count += 1
    e = EXIFR::JPEG.new(path)
    begin
      print [path, e.gps.longitude, e.gps.latitude].join(','), "\n"
      json[:features] << {:type => :Feature,
        :geometry => {:type => :Point, 
          :coordinates => [e.gps.longitude, e.gps.latitude]},
        :properties => {:name => path, 
          :_markerType => :Icon, 
          :_iconUrl => 'http://cyberjapandata.gsi.go.jp/portal/sys/v4/symbols/180.png',
          :_iconSize => [20, 20], :_iconAnchor => [10, 10], 
          :_className => :photo}
      }
    rescue
      print "something wrong with #{path}\n"
      n_wrong += 1
    end
  }
}
print "#{count - n_wrong} of #{count} successful.\n"
File.open(dst_path, 'w') {|w| w.print JSON::dump(json)}
