# Hello Strapi (MongoDB Atlas)
Strapi をローカルでテストし、Heroku もしくは GAE にデプロイするサンプルです。

* 事前に MongoDB Atlas でクラスタを作成してください
* デプロイ前にローカル環境から、データのスキーマを作成する必要があります。

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

その後以下のコマンドでホワイトリストを登録してください。
```
./bin/atlas-post-aws-white-list.sh
```

## GAE スタンダード環境へのデプロイ
secret.yaml の中に、データベースの情報を環境変数として記述します。
例えば以下のようになります。

```yaml
env_variables:
  DATABASE_URI: 'mongodb://------:----------------@strapi-shard-00-00-dffnp.mongodb.net:27017,strapi-shard-00-01-dffnp.mongodb.net:27017,strapi-shard-00-02-dffnp.mongodb.net:27017/test?ssl=true&replicaSet=strapi-shard-0&authSource=admin&retryWrites=true&w=majority' 
  DATABASE_NAME: '-------'
```

また、GAEのIPアドレス範囲をホワイトリストとして、MongoDB Atlas に登録する必要があります。
(Network peering を使わない場合）

以下のコマンドで一括で登録できます。

まずは、Atlas から認証情報を取得し
MongoDB Atlas の API 通信をテストしてください。
```
export ATLAS_PUBLIC_KEY=nehciwnx
export ATLAS_PRIVATE_KEY=985uncun-58ce-94jx-0n48-0845ncjdk85nw
export ATLAS_PROJECT_ID=05in48cnc85n89575n985n8r
./bin/atlas-api-test.sh
```

その後以下のコマンドでホワイトリストを登録してください。
```
./bin/atlas-post-gae-white-list.sh
```

以下のコマンドでデプロイできます。

```
npm run gcp-build
npm run gcp-deploy
```

エンドポイント等は以下のコマンドで表示できます。

```
gcloud app describe
```

