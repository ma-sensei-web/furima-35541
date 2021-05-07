# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ------------------------- |
| nickname        | string | null: false               |
| email           | string | null: false, unique: true |
| password        | string | null: false               |
| first_name      | string | null: false               |
| last_name       | string | null: false               |
| first_name_kana | string | null: false               |
| last_name_kana  | string | null: false               |
| birthday_year   | string | null: false               |
| birthday_month  | string | null: false               |
| birthday_day    | string | null: false               |

### Association

- has_many :items
- has_many :purchase, through: items
- has_many :purchase

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                     |
| explanation      | text       | null: false                    |
| category         | string     | null: false                    |
| status           | string     | null: false                    |
| delivery_charges | string     | null: false                    |
| delivery_area    | string     | null: false                    |
| delivery_days    | string     | null: false                    |
| price            | integer    | null: false                    |
| user_id          | references | null: false, foreign_key: true |

### Association

- has_one :purchase

## purchase テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user_id     | references | null: false, foreign_key: true |
| items_id    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :items
- has_one :items
- has_many :address

## address テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | integer    | null: false                    |
| prefectures     | string     | null: false                    |
| municipality    | string     | null: false                    |
| house_number    | integer    | null: false                    |
| bilding_name    | string     | null: false                    |
| phone           | integer    | null: true                     |
| purchase_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase