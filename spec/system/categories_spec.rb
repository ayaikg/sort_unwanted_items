require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'カテゴリーの新規登録ページにアクセス' do
        it '新規登録ページへのアクセスが失敗する' do
          visit new_category_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context 'カテゴリーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          visit edit_category_path(category)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context 'カテゴリーの一覧ページにアクセス' do
        it '一覧ページへのアクセスが失敗する' do
          visit categories_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe 'カテゴリー新規登録' do
      # 一回だとログインできないため
      before { login_as(user) }

      context 'フォームの入力値が正常' do
        it 'カテゴリーの新規作成が成功する' do
          visit categories_path
          click_link 'カテゴリー作成'
          fill_in 'カテゴリー', with: 'test_title'
          click_button '作成'
          expect(page).to have_content 'test_title'
          expect(current_path).to eq categories_path
        end
      end

      context 'タイトルが未入力' do
        it 'カテゴリーの新規作成が失敗する' do
          visit categories_path
          click_link 'カテゴリー作成'
          fill_in 'カテゴリー', with: ''
          click_button '作成'
          expect(page).to have_content "カテゴリーを入力してください"
          expect(current_path).to eq categories_path
        end
      end

      context '登録済のタイトルを入力' do
        it 'カテゴリーの新規作成が失敗する' do
          visit categories_path
          click_on 'カテゴリー作成'
          fill_in 'カテゴリー', with: 'ファッション'
          click_button '作成'
          expect(page).to have_content 'カテゴリーはすでに存在します'
          expect(current_path).to eq categories_path
        end
      end
    end

    describe 'カテゴリー編集' do
      before { login_as(user) }
      let!(:category) { create(:category, user: user) }
      let(:other_category) { create(:category, user: user) }
      before { visit categories_path }

      context 'フォームの入力値が正常' do
        it 'カテゴリーの編集が成功する' do
          click_on '編集'
          fill_in 'カテゴリー', with: 'updated_title'
          click_button '作成'
          expect(page).to have_content 'updated_title'
          expect(current_path).to eq categories_path
        end
      end

      context 'タイトルが未入力' do
        it 'カテゴリーの編集が失敗する' do
          click_on '編集'
          fill_in 'カテゴリー', with: ''
          click_button '作成'
          expect(page).to have_content "カテゴリーを入力してください"
          expect(current_path).to eq categories_path
        end
      end

      context '登録済のタイトルを入力' do
        it 'カテゴリーの編集が失敗する' do
          click_on '編集'
          fill_in 'カテゴリー', with: other_category.title
          click_button '作成'
          expect(page).to have_content "カテゴリーはすでに存在します"
          expect(current_path).to eq categories_path
        end
      end

      context '他ユーザーのカテゴリー編集ページにアクセス' do
        let!(:other_user) { create(:user, email: "other_user@example.com") }
        let!(:other_category) { create(:category, user: other_user) }

        it '編集ページへのアクセスが失敗する' do
          visit edit_category_path(other_category)
          expect(page).to have_content 'Forbidden access.'
          expect(current_path).to eq root_path
        end
      end
    end

    describe 'カテゴリー削除' do
      before { login_as(user) }
      let!(:category) { create(:category, user: user) }

      it 'カテゴリーの削除が成功する' do
        visit categories_path
        click_button '削除'
        expect(current_path).to eq categories_path
        expect(page).not_to have_content category.title
      end
    end
  end
end