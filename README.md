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
