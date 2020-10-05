require 'rails_helper'

feature 'User authenticates' do
  sign_in = I18n.t('shared.links.sign_in', scope: 'devise')
  email_field = I18n.t('attributes.user.email', scope: 'activerecord')
  password_field = I18n.t('attributes.user.password', scope: 'activerecord')
  login_button = I18n.t('sessions.new.sign_in', scope: 'devise')
  signed_message = I18n.t('sessions.signed_in', scope: 'devise')
  sign_out_button = I18n.t('shared.links.sign_out', scope: 'devise')

  scenario 'successfully' do
    # ARRANGE
    user = create(:user)
    # ACT
    visit root_path
    click_on sign_in
    within 'form' do
      fill_in email_field, with: user.email
      fill_in password_field, with: user.password
      click_on login_button
    end
    # ASSERT
    expect(current_path).to eq(root_path)
    expect(page).to have_content(signed_message)
    expect(page).to have_content(sign_out_button)
  end

  scenario 'failed' do
    # ARRANGE
    user = build(:user)
    # ACT
    visit new_user_session_path
    within 'form' do
      fill_in email_field, with: user.email
      fill_in password_field, with: user.password
      click_on login_button
    end
    # ASSERT
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('E-mail ou senha inválidos')
    expect(page).to have_selector('form')
  end
end
