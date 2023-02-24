# Bulk Upper

**https://bulk-upper.com/**

[![Bulk Upperロゴ](https://i.gyazo.com/6a32d1c1c40c69ede503dc73ff054289.png)](https://gyazo.com/6a32d1c1c40c69ede503dc73ff054289)

<br>

# サービス概要

バルクアップしたい人（かっこよく太りたい人）をサポートする筋トレ、食事メニューの記録・情報共有サービスです。

<br>

# ターゲットユーザー

- バルクアップしてかっこいい体を手に入れたい人
- ラグビーなどのコンタクトスポーツで当たり負けない体づくりをしたい人

<br>

# このサービスを制作した背景

私は筋トレが趣味で、バルクアップした体に憧れてジムに通っています！
しかし、一人で筋トレをしていると、**筋トレや食事のメニューがマンネリ化してモチベーションが下がったり、バルクアップに必要なカロリー管理ができていなかったりする**ことで、なかなか思い通りにバルクアップできませんでした。

<br>

<details>
<summary>バルクアップとは</summary>
バルクアップとは単に体重を増やすことではなく、筋肉を発達させて体を大きくしていくことです。バルクアップは、ダイエットや減量の対極にある行為として比較されますが、ダイエットはやりようによっては食事の要素だけでも可能ですが、バルクアップに関してはトレーニングと栄養の両要素がなくては成り立ちません。[参考]https://cp.glico.jp/powerpro/training/entry33/
</details>

<br>

そこで、それらの課題を解決するため、筋トレと食事メニューをユーザー同士で共有でき、更に自分の身長、体重、年齢などの情報から、バルクアップに必要な１日摂取カロリーを自動で計算し、管理できるサービスを開発しました。
マイページで自分の筋トレと食事メニュー（１日の摂取カロリー）を管理するとともに、ユーザー同士で投稿を共有することで、マンネリ化を防ぎます！💪🍽

<br>

# 主な機能

## バルクアップのための必要摂取カロリー自動計算機能

| <img src="https://i.gyazo.com/be5cd402a4bd994c0698f7042b451f77.png"> | <img src="https://i.gyazo.com/94d51c187f423deae0ddd5992e075bae.png">               |
| -------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| **プロフィール登録画面**<br>身長、体重、年齢などを入力します。<br>   | **プロフィール登録後**<br>バルクアップに必要な１日の摂取カロリーを自動計算します。 |

## マイページ機能

| <img src="https://i.gyazo.com/54fef5d166044d230259137f78524422.png">               | <img src="https://i.gyazo.com/7e3736e11920538824f951b1e66a1d29.png">                   |
| ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| **マイページ上部**<br>１日の目標摂取カロリーやフォロー、フォロワーが確認できます。 | **マイページ中部**<br>筋トレカレンダー機能。筋トレ投稿された日に 💪 マークがつきます。 |

| <img src="https://i.gyazo.com/fc958754af92e3af47ea49a83af062bd.png">                                               | <img src="https://i.gyazo.com/c9a7a110105f65d22fa66637825bbef8.png">                                                     |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| **マイページ下部**<br>日ごとの筋トレ・食事投稿一覧機能。自分の投稿した筋トレと食事の投稿を日付ごとに確認できます。 | **マイページ下部**<br>`他のユーザー投稿を参考にする`からフォロー中のユーザーまたは全ユーザの投稿一覧画面へ遷移できます。 |

## 筋トレ投稿機能

| <img src="https://i.gyazo.com/49beefb05f976454c100ca62f705d583.png"> | <img src="https://i.gyazo.com/a48141cd3a8a84e3a074093671222aeb.png"> |
| -------------------------------------------------------------------- | -------------------------------------------------------------------- |
| **筋トレ投稿作成**<br>種目名や重量などを入力して投稿します。         | **筋トレ投稿詳細**<br>写真とともにメニューを記録できます。           |

## 食事投稿機能

| <img src="https://i.gyazo.com/25044f94500549bb46a3c29cf62c2565.png">             | <img src="https://i.gyazo.com/a632933e7567d2e8334a780391c65eff.png"> |
| -------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| **食事投稿作成**<br>食事のタイミングやメニュー名を最低１つ入力して、投稿します。 | **食事投稿詳細**<br>筋トレ同様、写真とともにメニューを記録できます。 |

## 食事カロリー検索機能

| <img src="https://i.gyazo.com/b3a3a9e0d21f59499d4d28060f7693a3.png"> | <img src="https://i.gyazo.com/eee87049ebd9ed0a21c7342fa38f0fe6.png">                                                                     |
| -------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **食事投稿作成上部**<br>カロリー検索したい食事メニューを入力します。 | **食事投稿作成上部**<br>API によりカロリー情報を取得し、表示します。<br>カロリーの判断が難しいメニューはこの機能で参考にしてもらいます。 |

<br>

## その他の機能、静的ページ

- ユーザー登録、ログイン機能、ゲストログイン機能
- パスワードリセット機能
- プロフィール編集、更新機能
- フォロー機能
- 筋トレ・食事一覧機能（フォロー中/全ユーザー）
- 利用規約、プライパシーポリシー
- Google フォームでお問い合わせ機能
- 管理画面

# 使用技術

## 全体の構成

| バックエンド                        | フロントエンド         | インフラ                                         |
| ----------------------------------- | ---------------------- | ------------------------------------------------ |
| Ruby(3.1.2)<br>Ruby on Rails(7.0.4) | TailwindCSS<br>daisyUI | PostgreSQL<br>Heroku<br>AWS(Amazon S3, Route 53) |

| API                                                 | その他                                                                                     |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| DeepL API <br>Nutrition by API-Ninjas API(RapidAPI) | Cloudflare(独自ドメインの SSL 化)<br>Google アナリティクス(GA4)<br>Google サーチコンソール |

<br>

## 主要ライブラリ（gem）

- `sorcery`（ユーザー登録、ログイン/ログアウト、パスワードリセット）
- `kaminari`（ページネーション）
- `simple_calendar`（カレンダー機能）
- `rails-i18n`（i18n 国際化対応）
- `enum_help`（enum 定義の i18n）
- `config`（環境別の定数管理）
- `cancancan`（権限管理）
- `rails_admin`（管理画面の作成）
- `sitemap_generator`（サイトマップの作成）
- `meta-tags`（OGP、メタタグの設定）
- `rspec-rails`（テストフレームワーク）
- `rubocop`（Lint ツール）
  なお、画像アップロードには`Active Storage`を使用

<br>

# ER 図

[![ER図](https://i.gyazo.com/a6bfeff3c350fc021225fcb8b185ab0a.png)](https://gyazo.com/a6bfeff3c350fc021225fcb8b185ab0a)
