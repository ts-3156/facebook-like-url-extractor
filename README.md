# url extractor like facebook

A ruby script to extract URL content like facebook.

## Ruby Version

Ruby 1.9 or later

## How To Use

    gem install mechanize --no-ri --no-rdoc
    git clone https://github.com/ts-3156/url-extractor-like-facebook.git
    cd url-extractor-like-facebook
    ruby url_extractor.rb http://hivecolor.com

## Result

    {
      "title":"Hive Color",
      "description":"WebサービスのGrowth Hack自分用メモ。「Webサービスの運営のために欠かせない新しい役割「Growth Hacker」とは？」を自分なりにまとめてみた。",
      "images":[
        "httphivecolor.com/img/social_buttons/tweet_button2.png",
        "httphivecolor.com/img/social_buttons/fb_like_button2.png",
        "httphivecolor.com/img/social_buttons/hatena.png",
        "httphivecolor.com/img/profile.png"
      ]
    }

## Author

Teruki Shinohara, [@ts_3156](https://twitter.com/ts_3156)

