ffmpeg -y -i ($args[0]) -vf "[in]scale=iw*min(160/iw\,90/ih):ih*min(160/iw\,90/ih)[scaled]; [scaled]pad=160:90:(160-iw*min(160/iw\,90/ih))/2:(90-ih*min(160/iw\,90/ih))/2[padded]; [padded]setsar=1:1[out]" -c:v libx264 -c:a copy "shrink.mp4"
ffmpeg -i shrink.mp4 -f rawvideo -pix_fmt rgb24 output.rgb
# convert data into bytemask
Add-Type -TypeDefinition (gc -Raw converter.cs) -ErrorAction SilentlyContinue
[RgbToBitmask]::Convert("output.rgb", "output.bitmask")
rm shrink.mp4
rm output.rgb
