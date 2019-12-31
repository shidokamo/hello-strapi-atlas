# Hello Strapi (MongoDB Atlas)
Strapi をローカルでテストし、Heroku にデプロイするサンプルです。

## ローカルでのテスト
```
DATABASE_URI=XXXXXXXX npm run develop
```
XXXXXXX の部分は、MongoDB Atlas のクラスタから取得してください。

## Heroku へのデプロイ
```
heroku create
heroku config:set DATABASE_URI=XXXXXXX
heroku config:set DATABASE_NAME=strapi
git push heroku master
```

## MongoDB Atlas の API 通信
Heroku の App の IP アドレスを Atlas のホワイトリストに登録する必要がありますが、
Heroku の固定 IP は Enterprise アカウントではないと取得できないため、
AWS の IP アドレス範囲全てをホワイトリスト登録します。

まずは、Atlas から認証情報を取得し
MongoDB Atlas の API 通信をテストしてください。
```
export ATLAS_PUBLIC_KEY=nehciwnx
export ATLAS_PRIVATE_KEY=985uncun-58ce-94jx-0n48-0845ncjdk85nw
export ATLAS_PROJECT_ID=05in48cnc85n89575n985n8r
./bin/atlas-api-test.sh
```


