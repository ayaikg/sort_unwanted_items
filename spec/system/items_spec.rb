require 'rails_helper'

RSpec.describe 'Items', type: :system do
  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'アイテムの新規登録ページにアクセス' do
        it '新規登録ページへのアクセスが失敗する' do
          visit new_item_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context 'アイテムの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          visit edit_item_path(item)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context 'アイテムの一覧ページにアクセス' do
        it '一覧ページへのアクセスが失敗する' do
          visit category_items_path(category)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    let(:user) { create(:user) }
    before { login_as(user) }
    let(:category) { create(:category) }
    let(:item) { create(:item, category: category, user: user) }

    describe 'アイテム新規登録' do
      before { login_as(user) }
      context 'フォームの入力値が正常' do
        fit 'アイテムの新規作成が成功する' do
          visit new_item_path
          fill_in 'アイテム名', with: 'test_name'
          select 'ファッション', from: 'カテゴリー'
          expect(page).to have_checked_field '未出品', visible: false
          fill_in '通知日', with: Date.new(2023, 12, 11)
          expect(page).to have_checked_field '処分前', visible: false
          click_button '登録する'
          expect(page).to have_current_path(categories_path)
        end
      end

      context 'タイトルが未入力' do
        it 'アイテムの新規作成が失敗する' do
          visit new_item_path
          fill_in 'アイテム名', with: ''
          select 'ファッション', from: 'カテゴリー'
          expect(page).to have_checked_field '未出品', visible: false
          fill_in '通知日', with: Date.new(2023, 12, 11)
          expect(page).to have_checked_field '処分前', visible: false
          click_button '登録する'
          expect(page).to have_content "アイテム名を入力してください"
          expect(current_path).to eq new_item_path
        end
      end
    end

    describe 'アイテム編集' do
      let!(:item) { create(:item, category: category, user: user) }
      before { visit edit_item_path(item) }

      context 'フォームの入力値が正常' do
        it 'カテゴリーの編集が成功する' do
          fill_in 'アイテム名', with: 'update_name'
          select 'コスメ', from: 'カテゴリー'
          click_button '更新する'
          expect(page).to have_content 'update_name'
          expect(page).to have_content 'コスメ'
          expect(current_path).to eq item_path(item)
        end
      end

      context 'タイトルが未入力' do
        it 'アイテムの編集が失敗する' do
          fill_in 'アイテム名', with: ''
          click_button '更新する'
          expect(page).to have_content "アイテム名を入力してください"
          expect(current_path).to eq edit_item_path(item)
        end
      end

      context '他ユーザーのアイテム編集ページにアクセス' do
        let!(:other_user) { create(:user, email: "other_user@example.com") }
        let!(:other_item) { create(:item, user: other_user) }

        it '編集ページへのアクセスが失敗する' do
          visit edit_item_path(other_item)
          expect(page).to have_content 'Forbidden access.'
          expect(current_path).to eq root_path
        end
      end
    end

    describe 'アイテム削除' do
      let!(:item) { create(:item, category: category, user: user) }

      it 'アイテムの削除が成功する' do
        visit item_path(item)
        click_button '削除'
        expect(page).to have_current_path(categories_path)
      end
    end
  end
end