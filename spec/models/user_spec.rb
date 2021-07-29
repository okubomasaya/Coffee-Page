require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    describe 'モデルのテスト' do
    it "有効なuserの場合は保存されるか" do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(build(:user)).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "nameが空白の場合になっているかどうかか" do
        # userにnameカラムを空で保存したものを代入
        user = build(:user, name: nil)
        # バリデーションチェックを行う
        user.valid?
      end
      it "emailが空白のになっているかどうか" do
        # emailのバリデーションチェック
        user = build(:user, email: nil)
        user.valid?
      end
      it "passwordが空白になっているかどうかか" do
        # passwordのバリデーションチェック
        user = build(:user, password: nil)
        user.valid?
      end
    end

  describe 'アソシエーションのテスト' do
    context 'Bookモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
  end
end
end
end
