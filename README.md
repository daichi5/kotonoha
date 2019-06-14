# 言葉の共有サービス「Kotonoha」
Kotonohaとは自分が大切にしている言葉を投稿、共有できるサービスです。  
言葉は時に人々を奮い立たせたり、落ち着かせたりする力を持っています。  
このサービスを通じて素敵な言葉に出会えることを願っています。

## **[本番環境(https://kotonoha.link/)](https://kotonoha.link/)**  
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
  - ECS
  - EC2
  - S3
  - RDS (PostgreSQL)
  - ElastiCache (Redis)
  - Route53
  - CloudFront
  - Certificate Manager
  - その他(VPC, IAM, ACM)
- Nginx
- Github  
  - Git flow
- Editor
  - vim
  - VS Code

- Shell Script
<br>
<br>


## クラウドアーキテクチャ

AWSでインフラ構築をする際には次の３つのポイントを意識しています。

- ### 可用性
  →複数のサービスを組み合わせる上で**単一障害点**を減らすように留意しています。  
  具体的には  
  ・実行コンテナを常に複数持っておく（ECSですのでコンテナ停止時に自動起動も行われます）  
  ・ECS停止時にはELB→S3バケットでホスティングしているページへ遷移（failover機能）  
  ・EC2インスタンス（コンテナ）を複数のAZへ配置  
  といった設計を行っています。
  <br>

- ### 堅牢性
  外部からの侵入を防ぐために  
  ・IAMユーザー・ロール権限を最小化（１ユーザー１ポリシーをなるべく守る）  
  ・セキュリティグループ（ファイアウォール）許可ルールの最小化  
  を行っています  
  <br>

- ### 保守性
  複数のサービスを組み合わせて設計していますが、保守コストが低くなるように設計をしています。  
  具体的には  
  ・開発環境、テスト環境、本番環境で一貫してDockerコンテナを使用することにより環境差異を最小化  
  ・Route53、ELBを挟むことでWEB, APサーバとHTTPリクエスト処理の**疎結合**を保ち、 実行コンテナとHTTPリクエストの結合を考える必要を無くす  
  などの設計をしています。
  <br>
  <br>

## Railsアプリケーション機能一覧


- **自動テスト( RSpec)**
  - Capybara
  - FactoryBot
  - Chrome Headless Browser(JSテスト)
- **外部ストレージ活用**
  - ユーザープロフィール画像にActiveStoragを使用
  - 本番環境では**AWS S3バケット**へ保存
- **リアルタイム更新**（レンダリング）
  - Ajaxを活用し、いいねボタン・コメント投稿をリアルタイム更新
- **動的にチャートを描画**
  - Chart.jsとgonを連携させてマイページ内にチャートを動的描画
- **個別投稿のアクセスカウント、ランキング生成**
  - NoSQL(**Redis**)を使用し、RDB(RDS)への負担を軽減
- **アカウント登録のメール認証機能**
  - Devise gemでアカウントのメール認証機能を実装
  - SMTPサーバはgmailを使用
- 検索フォーム（Ransack）
- タグ付け、タグ検索機能(acts-as-taggable)
- パンくずリストの生成(gretel)
- WEBスクレイピング(nokogiri, 記事投稿URLnのタイトル取得に使用)
- テンプレートエンジンの変更(slim)
- ページネーション機能（kaminari)
- ランダムデータの生成(faker, seedデータに使用)
- sass 
- bootstrap (主にグリッドデザインに使用)
- レスポンシブデザイン
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

  - **RDB(RDS)処理の一部をRedisへ移行**
  RDBに対するクエリ削減は行いましたが他にも一部の処理をNoSQLであるRedisに移行しました。
  具体的には個別記事のPV数をRedisで管理し、特に重い処理であった
  人気ランキングの値取得もRedisで行うように変更しました。
  サーバーに関してはAWS ElastiCacheを利用しています。
  この結果、トップページに表示している人気の記事および、人気ランキング、アクセスカウントの
  レンダリング速度が上昇しました。

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
    
