# サービス名：Bulk Upper

### サービス概要

バルクアップしたい人（かっこよく太りたい人）をサポートする筋トレ、食事メニューの記録・情報共有アプリです。

### メインのターゲットユーザー

- 10 代〜30 代くらいの主に男性
- 今よりも増量して、分厚くてかっこいい体になりたい人
- コンタクトスポーツをしていて、あたり負けたくない人

### ユーザーが抱える課題

筋トレをやって、食事にも気を遣っているが、なかなか思い通りにバルクアップできない。
これには以下の点が課題として考えられます。

1. 筋トレメニューや食事メニューの、バリエーションが増えず、マンネリ化してしまっている、筋肉への刺激が足りない
2. 食事から十分なカロリーを摂取できていない。

### 解決方法

(1. の解決方法)
アプリを通じて、筋トレメニューと食事メニューをユーザー同士で相互に共有して、自分の筋トレや食事メニューの参考としてもらいます。
(2. の解決方法)
自分の現在のプロフィール（身長、体重、基礎代謝など）から、バルクアップするための 1 日の目標カロリーを算出し、その目標カロリーが摂取できているかを可視化することで、アンダーカロリーとならないように気をつけてもらいます。

### MVP で実装した機能

- 一般ユーザー
  - 未登録ユーザー
    - ユーザー登録機能
    - トップ画面表示
    - 投稿（筋トレ/食事）表示機能（一覧、詳細)
    - 登録ユーザーのマイページ閲覧機能
  - 登録ユーザー
    - ログイン、ログアウト機能
    - プロフィール機能（アバター画像、名前、メールアドレス、プロフ、身長、体重、年齢、身体活動レベル、目標体重、目標カロリー）
      - 目標カロリーは自動計算
    - 退会機能
    - 投稿機能
      - 筋トレメニュー投稿機能（登録、表示、更新、削除、一覧）
        - 日付、トレーニング時間、部位、種目名、回数、重量、メモ、画像投稿機能
      - 食事メニュー投稿機能（登録、表示、更新、削除、一覧）
        - 日付、食事タイミング（朝昼晩、間食）食事タイプ(自炊、外食、テイクアウト、コンビニ）、メニュー名、メモ機能、画像投稿機能
        - 食事のメニュー名からカロリー判定（API 使用)
    - マイページ機能（プロフィール表示、自分の投稿表示）
      - アバターや自己紹介文、SNS リンクの表示
      - 日付ごとの投稿閲覧機能（筋トレ/食事）

### MVP リリース後に実装したい機能

- ロゴ（OGP）作成
- 未登録ユーザー/登録ユーザー共通
  - about ページ、ポリシー表示
  - 管理者への問い合わせ機能
  - 投稿検索機能
- 登録ユーザー
  - ユーザー名、パスワード再設定機能
  - 投稿の検索機能
  - 投稿へのお気に入り機能（登録、削除、一覧）
  - 筋トレによる消費カロリー計算（※独自ロジック）・表示機能
  - OGP シェアできる機能（twitter、Instagram）
- 管理ユーザー（管理画面）
  - 管理ユーザー登録
  - 管理ユーザーの一覧、詳細、更新、削除、検索
  - 一般ユーザーの一覧、詳細、更新、削除、検索
  - 一般ユーザーの各投稿（筋トレ/食事）一覧、詳細、更新、削除、検索
- Google 各種設定（Analytics 等）

### 考案中の機能（MVP 後のユーザーの反応を見ながら考えたい）

- フォロー機能
- 投稿へのいいね機能（登録、削除）
- 投稿へのコメント機能（登録、更新、削除）
- 総負荷量（= 重量 × 回数 × セット数）計算、表示機能
- 下書き保存機能
- 食事の PFC（タンパク質、脂質、炭水化物）計算機能
- 食事メニューで外食を選択した場合に、その店名とお店情報を位置情報から登録できる機能
  - Google Maps API 使用
- ユーザーのやる気を引き出す機能
  - 必要カロリーに到達しないで登録しようとするとバリデーションで警告表示（登録は可能）
  - モチベーションアップを狙うためのランキング機能。例えば、(目標カロリー達成率 + 筋トレ負荷率)の総和でランキングなど

### なぜこのサービスを作りたいのか？

幼少期から太め体型が少しコンプレックスだったが、高校でラグビー部に入り、体が大きいことが強くてかっこいいんだと価値観が逆転した。
一人でも多くの人にバルクアップしてもらい、理想とするかっこいい体を手に入れて欲しい。
また、ラグビー、アメフト、柔道やレスリングといったコンタクトスポーツを行っている人フィジカル強化に繋げて欲しい。

### スケジュール

企画〜技術調査および
README〜ER 図作成：11/13 〆切
メイン機能実装：11/14 - 1/3
β 版を RUNTEQ 内リリース（MVP）：1/9 〆切
本番リリース：1/22

### 画面遷移図

https://www.figma.com/file/A1adLfLKvarGeydyeTDtmm/%E3%83%88%E3%83%AC%E3%83%9F%E3%83%AB%EF%BC%88%E4%BB%AE%EF%BC%89%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0%3A1&t=DyKOh7KiNN96jYsx-1

### ER 図

（本リリース前に修正予定）
https://drive.google.com/file/d/1SiAnkuBRWCOYWGQt04vqLZxkgK4wD7V4/view?usp=sharing
