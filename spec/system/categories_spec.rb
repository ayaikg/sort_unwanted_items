require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'カテゴリーの一覧ページにアクセス' do
        it '一覧ページへのアクセスが失敗する' do
          visit categories_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      login_as(user)
      parent_category = create(:category, title: "ファッション")
      create(:category, title: "トップス", ancestry: parent_category.id.to_s)
    end

    describe 'ページの遷移確認' do
      # 一回だとログインできないため
      before { login_as(user) }

      context 'カテゴリー一覧表示が正常' do
        it 'デフォルトカテゴリーが全て表示されている' do
          visit categories_path
          expect(page).to have_content 'ファッション'
        end
      end
    end
  end
end