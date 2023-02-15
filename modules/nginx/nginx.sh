#! /bin/bash
amazon-linux-extras install -y nginx1
service nginx start
rm /usr/share/nginx/html/index.html
echo "<html><head></head><body><h2 style=\"text-align: center;\">Welcome to Grandpa's Whiskey-$(hostname)</h2></body></html>" | tee /usr/share/nginx/html/index.html
