#!/bin/bash

# OpenH264 download: https://github.com/cisco/openh264/releases/tag/v2.3.1
openh264_url="http://ciscobinary.openh264.org/libopenh264-2.3.1-mac-arm64.dylib.bz2"
curl -L $openh264_url -o libopenh264.dylib.bz2
bunzip2 libopenh264.dylib.bz2

# Move libopenh264.dylib to /usr/local/lib
sudo mv libopenh264.dylib /usr/local/lib/

# Setting env (bash or zsh)
if [ -f "$HOME/.bash_profile" ]; then
    echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bash_profile
    source ~/.bash_profile
elif [ -f "$HOME/.zshrc" ]; then
    echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.zshrc
    source ~/.zshrc
else
    echo "Neither .bash_profile nor .zshrc was found."
fi

# Install required tools and dependencies
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing dependencies..."
xcode-select --install
brew install nasm yasm pkg-config

# Build and setup FFmpeg
if [ ! -d "ffmpeg" ]; then
    git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
fi
cd ffmpeg
./configure --prefix=/usr/local --enable-gpl --enable-libopenh264 --extra-ldflags=-L/usr/local/lib
make
sudo make install
cd ..

# It seems that dylib must be named libopenh264.7.dylib
sudo mv /usr/local/lib/libopenh264.dylib /usr/local/lib/libopenh264.7.dylib

echo "OpenH264 setup complete!"
echo "Try running this command to make sure it was set up correctly!"
echo "========================"
echo "ffmpeg -codecs | grep h264"
