# ながのCAKE（DMMWEBCAMPの応用課題）

## 概要
長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイト開発です。


## 案件の背景
元々近隣住民が顧客だったが、昨年始めたInstagramから人気となり全国から注文が来るようになったため、<br>
管理機能を含んだ通販サイトを開設しようと思い至った。


## 通販について
* 通販では注文に応じて製作する受注生産型。
* 1日に受注量に制限は設けない。
* 送料は1配送につき全国一律800円
* 友人や家族へのプレゼントは住所を複数登録することで発送可能。
* 支払いはクレジットカードまたは銀行振込から選択可能。

顧客側の機能
* 商品閲覧は会員登録なしでも可能。
* 注文する場合は会員登録が可能で、会員登録・ログイン・ログアウト・退会が可能。
* 商品カートに入れることで1度に複数の商品を購入することが可能。
* 商品の発送先は自宅以外にも複数登録が可能。
* 注文ステータスにより、注文から発送済みまで確認が可能。

管理者側の機能
* 商品・ジャンル・顧客情報の編集が可能。
* 従業員は注文ステータスで、入金確認から発送済みまで管理が可能。
* パティシエは製作ステータスで、着手から製作完了まで管理可能。

## 機能
* ログイン機能 device
* ページネーション実装 kaminari 1.2.1
* レイアウトbootstrap 4.5
