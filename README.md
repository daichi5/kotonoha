# 言葉の共有サービス「Kotonoha」
Kotonohaとは自分が大切にしている言葉を投稿、共有できるサービスです。  
言葉は時に人々を奮い立たせたり、落ち着かせたりする力を持っています。  
このサービスを通じて素敵な言葉に出会えることを願っています。

## **[本番環境(http://3.113.104.117/)](http://3.113.104.117/)**  
↑ ※GitHubではtarget=_blankに対応していないため同一タブで開かれます、ご容赦下さい、、
<br>
<br>

## 開発構成図
![構成図](https://cacoo.com/diagrams/ET8RhdVr011MCI4Y-FD776.png)
(構成図は **[Cacoo](https://app.cacoo.com/)** を使用して作成)

## 使用技術一覧

- Ruby on Rails
- Docker
- CircleCI
- AWS
  - S3
  - RDM (PostgreSQL)
  - EC2
  - CodeDeploy
  - System Manager (parameter store) 
  - VPC
  - IAM
  - CLI
- Nginx
- Github  
  - Git flow
- Editor
  - vim
  - VS Code

- Shell Script
<br>
<br>


## Railsアプリケーション機能一覧


- 自動テスト( RSpec)
  - Capybara
  - FactoryBot
  - Chrome Headless Browser
- ActiveStorage
  - ユーザープロフィール画像に使用
  - 本番環境ではAWS S3バケットへ保存
- Ajax
  - いいねボタン、コメント作成のリアルタイム更新
- Chart.js（マイページ内の投稿記事、いいね記事 構成割合の描画）
- gon (Chart.jsにデータを渡す際に使用)
- nokogiri（記事引用元URLのタイトルスクレイピングに使用）
- slim　(Viewテンプレートエンジン)
- ransack (検索フォーム)
- kaminari (ページネーション)
- sass 
- acts-as-taggable (記事タグ付け機能)
- faker (Seedデータのランダムデータ作成)
- gretel (パンくずリストの生成)
- bootstrap (主にグリッドデザインに使用)
- rack-mini-profiler(表示速度測定を目的に開発環境にて使用)
<br>
<br>


## 開発に際して気をつけたポイント

- ### 表示の高速化
  Herokuを使用して本番環境にアップした時にどうしても表示速度が  
  かなり遅くなってしまいWEBサービスとして致命的だと感じていたので  
  以下のような高速化を行いました

  - **rack-mini-profilerの使用**  
  まずは表示速度とクエリ発行状況を把握するために  
  rack-miniprofiler gemを使用しました。  
  低速である原因の特定、改善前と改善後の比較に活用しました。
  <br>
  <br>

  - **SQLクエリの削減・高速化**  
  rack-mini-profiler gemを使用した結果  
  トップページのクエリ発行数が40越えとなっていたので  
  まずはクエリ数削減に取り組みました。  
  ActiveRecordを使用して発生したいわゆる**N+1問題**が原因でした。  
  joinsメソッド、puckメソッドなどを利用して事前にキャッシュ、カラムを絞ることで  
  クエリ発行数は80%前後削減されました
  <br>
  <br>


  - **HerokuからEC2へ移行**  
  Heroku環境が遅いという話は聞いていたので  
  勉強も兼ねてAWS EC2へ移行しました。  
  Herokuはアクセスが無いとスリープ状態に入ってしまうのでそれが原因かと思います.


  現状でも高速とは言えないとは思いますが上記対策の結果、  
  表示速度は２倍以上となりました。
  <br>
  <br>

- ### CI/CDパイプライン構築による開発効率アップ
  自分自身がサービス開発に集中できるように自動化できる部分は全て自動化を行いました。  

  テストに関してはRSpecを使用し、Headlessブラウザを用いたjavascriptの  
  自動テストまでカバーしました。  
  また、CircleCIとAWS Codedeployを用いて  
  Githubへのプッシュが行われた時に自動テストを走らせ  
  masterブランチとstagingブランチへのマージが行われた際には  
  それぞれの環境へ自動デプロイされるように構築しています。

  <br>

- ### 基礎的な環境構築を経験する
  このアプリケーションの構成はDocker + AWS (EC2, RDS, S3)  
  というコンテナ技術、クラウドサービスを利用していますが  
  基礎的な知識を身に着けるために他の環境も利用しました。  

  具体的には
  - **仮想マシンでの開発(Vagrant + VirtualBox)**
  - **VPSの構築（さくらサーバ）**
  - **LAMP環境での開発 (フレームワーク/ORMを使用せずPHP + MySQLで開発)**

  などに取り組みました。
<br>
<br>

## 今後の課題
  - **コードの可読性、保守性向上**  
  エンジニアとしての業務経験が無いので基礎的な  
  「コーディングの作法」という部分が欠落していると自覚しています。  
  Rubyでは Gemレポジトリ を見てプロがどのようなコードを書いているか  
  参考にしたりしています。

  - **セキュリティ**  
  RailsにはSQLインジェションやCSRF対策が施されているので  
  基本的なセキュリティは問題ないと思いますが  
  今回AWSを初めて使用しましたのでインフラやDBのやりとりに  
  関して不安を覚えています。(IAMユーザー・ロールの設定など)   
  ですので今後はインフラ構築面でのベストプラクティスを勉強する予定です
  
  - **ReactJSでの開発**  
  現在、Ruby on Rails単体でアプリケーションを構成することは少なく  
  フロントにReactやVueJSを使用してRailsはバックフロントで  
  APIとして利用することが多い、とのことでした。  
  ですので現在Reactでの開発に取り組んでいます。
<br>
<br>

## サービスの狙い、マネタイズに関してなど

今回は転職用のポートフォリオとしてサービス開発をしたのですが  
ビジネス視点からサービスの狙いも記述しておきます。  

  - ### サービスの狙い  
    私自身が「名言や格言」というものが好きだったという理由もありますが  
    このようなサービスを作った理由は他にもあります。  
    - **事前の反応が良かった**  
    プロダクトを作る前には事前調査、ニーズの把握というものが重要ですよね。  
    以前に名言を発信するアカウントをTwitterで運用していたのですが  
    いいねやRTの反応が良好でしたので今回のサービスを考えました。
    <br>
    <br>

    
    - **運営コストが低い**  
    著名人、偉人の名言を共有するということでコンテンツを生成するコストが低いので  
    軽く運営するには向いていると判断しました。  
    （ちなみに引用するだけなら著作権の問題はクリアできます）
    <br>
    <br>


  - ### マネタイズ
    もしマネタイズをするなら、という仮定であれば  
    **引用元の著書への誘導**でのマネタイズが基本になると思っています。  
    手段としてはアフィリエイトや純広告（コラボ記事等）  
    引用元設定ができるようにしてあるのはマネタイズすることを  
    想定しているためです。
    
