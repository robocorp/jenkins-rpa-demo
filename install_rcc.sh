apt-get update --fix-missing && \
apt-get install -y wget bzip2 ca-certificates curl bash chromium-browser chromium-chromedriver && \
apt-get install -y fonts-indic fonts-noto fonts-noto-cjk && \
export PATH=$PATH:/usr/lib/chromium-browser/ && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
echo "Chromium Version: " && chromium-browser --product-version && chromedriver --version

curl -o rcc https://downloads.code.robocorp.com/rcc/latest/linux64/rcc
chmod a+x rcc
mv rcc /usr/local/bin/
