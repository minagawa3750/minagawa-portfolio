<p align="right">
  <img src="https://img.shields.io/circleci/build/github/minagawa3750/minagawa-portfolio/main" />
</p>

# SKI.com 
## 1.SKI.comとは
スキー場の情報を気軽に閲覧でき、興味があるスキー場にはいいねをつけて保存ができます。  
レビュー投稿をしたり、見たりすることでユーザー同士の情報共有や情報の信頼性向上につながります。  
他にもレビューの平均評価ランキングや、初心者の方や旅行におすすめなどのスキー場特集や、  
YOUTUBE動画、Q&Aなど初心者の方はもちろん経験者の方まで気軽にスキー場情報を閲覧できるサービスです。  

## 2.サービスを作成した目的
スノーボードは私の趣味です。小学生からスキーを始め、高校生からはスノーボードを始めました。  
冬の定番スポーツではありますが、道具の知識やテクニックなど一通り覚えるのは難しいです。  
私も初心者の方と旅行しレクチャーしたことがありますが、1日だけではよく目にするような軽やかに滑走できる技術は身につきません。  
道具やスキーウェアもでそれほど身近で手にするものではないので、どんなものを揃えれば良いかピンとこないと思います。  
スキー場の情報サイトも見かけますが、最大傾斜や天気などの情報は掲載されているもののそのスキー場のアピールポイントが明確でなかったり
初心者に必要な道具などの情報が掲載されてなかったり、サイト自体が経験者向けに作られているなと個人的に感じておりました。  
見やすい情報で気軽に口コミができるサービスをスキーでも作りたい、旅行感覚でもっと気軽にスキー・スノボを楽しんでもらいたいと思い本サービスを作成しました。

## 3.使用技術
- Ruby 2.7.6
- Ruby on Rails 6.1.7
- MySQL 8.0
- Nginx
- Unicorn
- AWS
  - EC2
  - S3
- Docker/Docker-compose
- CircleCi CI/CD
- RSpec
- Google Maps API

### AWS構成図
![スクリーンショット 2023-02-02 13 51 25](https://user-images.githubusercontent.com/107171561/216240256-fa174f09-d781-43d7-90d7-7f004ca843b4.png)
### CircleCi CI/CD
- Githubへpush後、RSpecとRuboCopが自動で実行されます。
- mainブランチへのpush後は上記テストが成功した場合、EC2への自動デプロイが実行されます。

## 4.機能一覧
- アカウント登録、ログイン機能、ゲストログイン機能(devise)
  - プロフィール画像登録(ActiveStorage)
- スキー場登録機能
  - スキー場画像登録(ActiveStorage)
  - スキー場位置情報機能(geocoder)
- レビュー投稿機能
  - 平均評価ランキング
- いいね機能
- ページネーション機能(kaminari)
- 検索機能(ransack)
  - スキー場特集

### SKI.com ER図
![スクリーンショット 2023-02-02 13 46 25](https://user-images.githubusercontent.com/107171561/216240753-212e0bcf-3686-4f85-bc0a-1c6ecbddc0ad.png)

## 5.テスト
- RSpec
  - 単体テスト(models)
  - 統合テスト(system)
  
## 6.デモ画面
### トップ画面

<img width="1440" alt="スクリーンショット 2023-02-02 23 23 06" src="https://user-images.githubusercontent.com/107171561/216351237-e84813b7-8969-4521-bf93-668601c56121.png">

ログインしたユーザーによってヘッダーメニューの表示を変えています。
- 一般ユーザー
<img width="1440" alt="スクリーンショット 2023-02-02 23 24 24" src="https://user-images.githubusercontent.com/107171561/216351327-a40815b6-004d-4470-a7d3-3d6751a8fbff.png">

- 管理者ユーザー
  - 管理者ユーザーはスキー場一覧からスキー場の登録、編集、削除ができるようになっています。
  - 管理者ユーザー以外が上記ページへ遷移しようとするとトップページに遷移するようbefore_actionで閲覧制限しています。
  
<img width="1440" alt="スクリーンショット 2023-02-02 23 22 41" src="https://user-images.githubusercontent.com/107171561/216351412-4cee61ad-3949-41a9-b914-173b06336ad1.png">

- ゲストユーザー
  - ゲストユーザーはアカウント編集といいね一覧が表示されません。
  - ゲストユーザーはレビュー投稿ができますが、いいねはできないようになっています。
  
<img width="1440" alt="スクリーンショット 2023-02-02 23 23 30" src="https://user-images.githubusercontent.com/107171561/216351546-392ce577-6fee-43cd-b9a9-4dcd861daa00.png">

### いいね機能
- 平均評価ランキング、検索結果、スキー場特集内のスキー場画像をクリックすると詳細ページに遷移します。

<img width="1440" alt="スクリーンショット 2023-02-02 22 50 03" src="https://user-images.githubusercontent.com/107171561/216345879-dfa08b66-529e-47b5-b061-805d2a26516a.png">

<img width="1440" alt="スクリーンショット 2023-02-02 22 51 28" src="https://user-images.githubusercontent.com/107171561/216345949-ff675619-7551-49c9-b4a5-d23e5a742b03.png">

- 右上のハートをクリックするといいねができます。

<img width="1440" alt="スクリーンショット 2023-02-02 23 15 51" src="https://user-images.githubusercontent.com/107171561/216348827-05099a63-75fe-4dc0-a02f-576e95dc8e9a.png">

- ゲストユーザー、未ログインユーザーはいいねボタンが表示されません。

<img width="1440" alt="スクリーンショット 2023-02-02 23 32 57" src="https://user-images.githubusercontent.com/107171561/216353223-44855309-b750-48af-ba5c-f135eaadc5ec.png">

- ヘッダーメニューのいいね一覧をクリックするといいねしたスキー場が登録されています。
<img width="1440" alt="スクリーンショット 2023-02-02 22 52 21" src="https://user-images.githubusercontent.com/107171561/216346047-2548b44c-26b2-4f0e-b077-d3faba759685.png">

### レビュー投稿
- スキー場詳細ページからレビュー投稿はこちらをクリックします。(未ログインユーザーがクリックするとログイン画面に遷移します。)

<img width="1440" alt="スクリーンショット 2023-02-02 22 52 53" src="https://user-images.githubusercontent.com/107171561/216346152-100032a9-1ac5-4477-857e-7d1a1fc676be.png">

<img width="1440" alt="スクリーンショット 2023-02-02 22 54 38" src="https://user-images.githubusercontent.com/107171561/216346245-ac8e1ae7-77a2-4c9c-a0ab-452898e32656.png">

- レビュー投稿すると詳細ページに遷移しレビューが投稿されています。
- タイトルをクリックするとレビュー詳細に遷移します。

<img width="1429" alt="スクリーンショット 2023-02-02 22 55 01" src="https://user-images.githubusercontent.com/107171561/216346320-d4ff941d-8f6a-413a-bc3a-71d48aad71a1.png">

- 投稿ユーザーとログインユーザーが一致しているとレビューを編集するとレビューが削除するが表示されます。
- クリックすると編集と削除ができます。
<img width="1440" alt="スクリーンショット 2023-02-02 22 55 25" src="https://user-images.githubusercontent.com/107171561/216346381-ebb84759-1037-4ce5-8f7a-3e55e85313c9.png">
