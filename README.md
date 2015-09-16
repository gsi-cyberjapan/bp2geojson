# bp2geojson
[proof of concept] Bunch of photos to GeoJSON, in Ruby

## What is this?
bp2geojson.rb takes a list of directories and search for JPEG files from them.

When it sees a JPEG file, it try to collect GPS location data from it.

Finally, it outputs the all collected location data as a GeoJSON file.

Just a proof of concept.

## See also
- exifr https://github.com/remvee/exifr
