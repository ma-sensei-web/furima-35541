require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '出品機能' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '出品ができる時' do
      it '必須項目が全てあれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '出品ができない時' do
      it '商品画像を1枚つけることが必須であること' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end

      it '商品名が必須であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品の説明が必須であること' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it 'カテゴリーのidに0が選択されている場合は出品できないこと' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it '商品の状態についての情報が必須であること' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it '商品の状態のidに0が選択されている場合は出品できないこと' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it '配送料の負担についての情報が必須であること' do
        @item.charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it '配送料の負担のidに0が選択されている場合は出品できないこと' do
        @item.charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it '発送元の地域についての情報が必須であること' do
        @item.area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it '発送元の地域のidに0が選択されている場合は出品できないこと' do
        @item.area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it '発送までの日数についての情報が必須であること' do
        @item.scheduled_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it '発送までの日数のidに0が選択されている場合は出品できないこと' do
        @item.scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it '販売価格についての情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end

      it '販売価格は、¥300~¥9,999,999の間のみ保存可能であること' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格の設定は¥300〜9,999,999です')
      end

      it '販売価格は、¥300円より小さい値段の場合出品できないこと' do
        @item.price = 10
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格の設定は¥300〜9,999,999です')
      end

      it '販売価格は、¥9,999,999円より大きい値段の場合出品できないこと' do
        @item.price = 12_345_678
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格の設定は¥300〜9,999,999です')
      end

      it '販売価格が半角英数字混合では出品できないこと' do
        @item.price = '100aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字で入力してください')
      end

      it '販売価格が半角英字のみでは出品できないこと' do
        @item.price = 'qweasd'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字で入力してください')
      end

      it '販売価格が全角文字では出品できないこと' do
        @item.price = 'あい上オ'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字で入力してください')
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字で入力してください')
      end

      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
