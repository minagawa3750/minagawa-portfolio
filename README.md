<p align="right">
  <img src="https://img.shields.io/circleci/build/github/minagawa3750/minagawa-portfolio/main" />
  <img src="https://img.shields.io/gem/dv/rails/6.1.7" />
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
### circleCi CI/CD
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
![スクリーンショット 2023-02-02 14 20 11](https://user-images.githubusercontent.com/107171561/216241324-c636f949-5ab3-4140-8a17-7646e1689953.png)

ログインしたユーザーによってヘッダーメニューの表示を変えています。
- 一般ユーザー

![スクリーンショット 2023-02-02 14 21 54](https://user-images.githubusercontent.com/107171561/216241446-a5a09379-e06c-46a2-bfe5-6ec6e2a5f62d.png)

- 管理者ユーザー
  - 管理者ユーザーはスキー場一覧からスキー場の登録、編集、削除ができるようになっています。
  - 管理者ユーザー以外が上記ページへ遷移しようとするとトップページに遷移するようbefore_actionで閲覧制限しています。

![スクリーンショット 2023-02-02 14 20 43](https://user-images.githubusercontent.com/107171561/216241746-1df7c95d-d3d2-4bc3-a78e-18b60e56636e.png)

- ゲストユーザー
  - ゲストユーザーはアカウント編集といいね一覧が表示されません。
  - ゲストユーザーはレビュー投稿ができますが、いいねはできないようになっています。

![スクリーンショット 2023-02-02 14 21 19](https://user-images.githubusercontent.com/107171561/216241975-4ef79028-56af-4b94-b1e8-342d4dd4558e.png)

### いいね機能について
- 平均評価ランキング、検索結果、スキー場特集のスキー場画像をクリックすると詳細ページに遷移します。
![スクリーンショット 2023-02-02 14 47 11](https://user-images.githubusercontent.com/107171561/216242253-370c6a50-cce1-4cdc-b87e-5c26366098a3.png)

![スクリーンショット 2023-02-02 14 49 39](https://user-images.githubusercontent.com/107171561/216242558-727ed56e-217b-4757-bf73-9415e3fef8e6.png)

- 右上のハートをクリックするといいねができます。

![スクリーンショット 2023-02-02 14 54 32](https://user-images.githubusercontent.com/107171561/216243270-46676076-af86-42d7-8181-61916bed31fd.png)

- ゲストユーザー、未ログインユーザーはいいねボタンが表示されません。

![スクリーンショット 2023-02-02 14 58 49](https://user-images.githubusercontent.com/107171561/216243951-08dc1b1f-3808-4347-a6a2-78a9e85278b5.png)

- ヘッダーメニューのいいね一覧をクリックするといいねしたスキー場が登録されています。
![スクリーンショット 2023-02-02 14 55 04](https://user-images.githubusercontent.com/107171561/216243354-3c5c3f68-56db-47c7-839a-dbe2bd115ae6.png)

### レビュー投稿
- スキー場詳細ページからレビューはこちらをクリックします。(未ログインユーザーがクリックするとログイン画面に遷移します。)

![スクリーンショット 2023-02-02 15 00 54](https://user-images.githubusercontent.com/107171561/216244232-78675b24-5ca0-4b35-bb89-25b78eea30c3.png)

- レビュー投稿すると詳細ページに遷移しレビューが投稿されています。
![スクリーンショット 2023-02-02 15 04 15](https://user-images.githubusercontent.com/107171561/216245670-5a9cacb9-9409-4c4f-878e-9b4d6a45fa45.png)

![スクリーンショット 2023-02-02 15 06 17](https://user-images.githubusercontent.com/107171561/216244979-f50ad592-563e-41c3-83bc-5d284a07370f.png)

- タイトルをクリックするとレビュー詳細に遷移します。
- 投稿ユーザーとログインユーザーが一致しているとレビューを編集するとレビューが削除するが表示されます。
- クリックすると編集と削除ができます。

![スクリーンショット 2023-02-02 15 06 32](https://user-images.githubusercontent.com/107171561/216245134-bb21c4cb-c62b-433f-b6d5-fef72e6f64ea.png)
