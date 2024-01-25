require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }
  let(:post) { create(:post, item: item) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context '投稿の新規作成ページにアクセス' do
        it '新規作成ページへのアクセスが失敗する' do
          visit new_post_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq root_path
        end
      end

      context '投稿の編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          visit edit_post_path(post)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq root_path
        end
      end

      context '投稿の一覧ページにアクセス' do
        it '一覧ページへのアクセスが失敗する' do
          visit posts_path
          expect(page).to have_content('今日のランキングTOP10')
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe '新規投稿作成' do
      #一回だとログインできないため
      before { login_as(user) }
      context 'フォームの入力値が正常' do
        it '投稿の新規作成が成功する' do
          visit new_post_path
          expect(page).to have_checked_field item.name
          fill_in '投稿内容', with: 'テスト投稿'
          click_button '登録する'
          expect(page).to have_current_path(posts_path)
        end
      end

      context 'アイテムが未選択' do
        it '投稿の新規作成が失敗する' do
          visit new_post_path
          expect(page).to have_checked_field item.name
          fill_in '投稿内容', with: 'テスト投稿'
          click_button '登録する'
          expect(page).to have_content "itemを入力してください"
          expect(current_path).to eq new_item_path
        end
      end
    end

    describe '投稿編集' do
      let!(:item) { create(:item, user: user) }
      before { visit edit_item_path(item) }

      context 'フォームの入力値が正常' do
        it '投稿の編集が成功する' do
          fill_in '投稿内容', with: 'テスト投稿更新'
          expect(page).to have_checked_field item.name
          click_button '更新する'
          expect(page).to have_content 'テスト投稿更新'
          expect(current_path).to eq post_path(post)
        end
      end

      context '他ユーザーの投稿編集ページにアクセス' do
        let!(:other_user) { create(:user, email: "other_user@example.com") }
        let!(:other_item) { create(:item, user: other_user) }
        let!(other_post) { create(:post, item: other_item)}

        it '編集ページへのアクセスが失敗する' do
          visit edit_post_path(other_post)
          expect(page).to have_content 'こちらのページはアクセスできません'
          expect(current_path).to eq root_path
        end
      end
    end

    describe '投稿削除' do
      let!(:post) { create(:post, user: user) }

      it 'アイテムの削除が成功する' do
        visit post_path(post)
        find(".dropdown").click
        click_button '投稿を削除'
        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_current_path(posts_path)
      end
    end
  end
end