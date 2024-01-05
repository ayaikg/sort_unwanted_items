require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
          visit user_path(user)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe 'ユーザー編集' do
      before { login_as(user) }
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit edit_user_path(user)
          fill_in 'ニックネーム', with: 'アップデートくん'
          fill_in '自己紹介', with: 'ユーザー編集成功'
          click_button '更新'
          expect(page).to have_content('マイページを更新しました')
          expect(current_path).to eq user_path(user)
        end
      end

      context 'ニックネームが未入力' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          fill_in 'ニックネーム', with: ''
          fill_in '自己紹介', with: 'password'
          click_button '更新'
          expect(page).to have_content('マイページの更新に失敗しました')
          expect(page).to have_content("ニックネームを入力してください")
          expect(current_path).to eq edit_user_path(user)
        end
      end

      context '他ユーザーの編集ページにアクセス' do
        let!(:other_user) { create(:user, email: "other_user@example.com") }
        it '編集ページへのアクセスが失敗する' do
          visit edit_user_path(other_user)
          expect(page).to have_content 'こちらのページはアクセスできません'
          expect(current_path).to eq user_path(user)
        end
      end
    end

    describe 'マイページ' do
      let(:item) { create(:item, user: user) }
      context '投稿を作成' do
        it 'ユーザーが作成した投稿が表示される' do
          create(:post, item_id: item.id, content: "自己紹介", user: user)
          visit user_path(user)
          expect(page).to have_content(item.name)
          expect(page).to have_content('自己紹介')
          expect(page).to have_link('シェア')
        end
      end
    end
  end
end