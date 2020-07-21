require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない場合、サインインページに移動' do
    #トップページに遷移する
    visit root_path
    #ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path
  end
    
  it 'ログインに成功し、ルートパスに遷移する' do
    #予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    #サインインページに移動する
    visit new_user_session_path
    #ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path
    #すでに保存されているユーザーのemailをpasswordを入力する
    fill_in 'Email', with: @user.email #'user_email'でも可
    fill_in 'Password', with: @user.password #'user_passwordでも可'
    #ログインボタンをクリックする
    find('input[name="commit"]').click #click_on("Log in")でも可
    #ルートページに遷移することを期待する
    expect(current_path).to eq root_path
  end
  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    #予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    #サインインページへ移動する
    visit root_path
    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path
    #誤ったユーザー情報を入力する
    fill_in 'user_email', with: "test"
    fill_in 'user_password', with: "example@test.com"
    #ロッグインボタンをクリックする
    click_on("Log in")
    #サインインページに遷移していることを期待する
    expect(current_path).to eq new_user_session_path
  end
end
