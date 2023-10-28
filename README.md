# setup-mac-ffmpeg-with-openh264-ciscobinary

Setup [FFmpeg](https://github.com/FFmpeg/FFmpeg) support [OpenH264 (Cisco binary)](https://github.com/cisco/openh264) for macOS.

## Usage

Install

```sh
bash setup-mac-openh264.sh

# After the command is complete, you will need to execute the following additional commands
sudo cp /usr/local/lib/libopenh264.dylib /usr/local/lib/libopenh264.7.dylib
```

Uninstall `ffmpeg`

```sh
sudo bash uninstall.sh
```