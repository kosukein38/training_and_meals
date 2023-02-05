# サービス名：Bulk Upper

https://bulk-upper.com/

## サービス概要

バルクアップしたい人（かっこよく太りたい人）をサポートする筋トレ、食事メニューの記録・情報共有アプリです。

私自身、筋トレが趣味で、食事にも気を遣っているますが、なかなか思い通りにバルクアップできずにもどかしく思っていました。
これには以下の点が課題として考えられます。

1. 筋トレメニューや食事メニューの、バリエーションが増えず、マンネリ化してしまっている、筋肉への刺激が足りない
2. 食事から十分なカロリーを摂取できていない。

この２つの課題を克服するため、本サービスを通じて、まずは、自分の現在のプロフィール（身長、体重、基礎代謝など）から、バルクアップに必要な１日の必要カロリーを算出します。
そして、筋トレ内容と食事内容を投稿で管理しながら、ユーザー同士で内容を共有することで、自分のメニューにも取り入れてもらいます。
日々のマンネリ化を防ぎ、筋トレと食事の両面からバルクアップを応援します。

<details>
<summary>バルクアップとは</summary>
参考 https://cp.glico.jp/powerpro/training/entry33/
バルクアップとは単に体重を増やすことではなく、筋肉を発達させて体を大きくしていくことです。
しばしばバルクアップは、ダイエットや減量の対極にある行為として比較されますが、ダイエットはやりようによっては食事の要素だけでも可能ですが、バルクアップに関してはトレーニングと栄養の両要素がなくては成り立ちません。
</details>

## 主な機能

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
        - 食事のメニュー名からカロリー検索機能（API 使用)
    - マイページ機能（プロフィール表示、自分の投稿表示）
      - アバターや自己紹介文、SNS リンクの表示機能
      - 日付ごとの投稿閲覧機能（筋トレ/食事）
      - 筋トレカレンダー機能
    - フォロー機能
- 管理ユーザー
  - 管理画面

## 使用技術

| バックエンド                                    | フロントエンド                     | インフラ・その他                                        |
| :---------------------------------------------- | :--------------------------------- | :------------------------------------------------------ |
| Ruby(3.1.2)<br>Ruby on Rails(7.0.4)<br><br><br> | TailwindCSS<br>daisyUI<br><br><br> | PostgreSQL<br>Heroku<br>AWS(Amazon S3,<br>Route 53)<br> |

## 画面遷移図

https://www.figma.com/file/A1adLfLKvarGeydyeTDtmm/%E3%83%88%E3%83%AC%E3%83%9F%E3%83%AB%EF%BC%88%E4%BB%AE%EF%BC%89%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0%3A1&t=DyKOh7KiNN96jYsx-1

## ER 図

https://drive.google.com/file/d/1ivZ3oR7lTilcipTgnspvqACQtIDXTyiB/view?usp=sharing
