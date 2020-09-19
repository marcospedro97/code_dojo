require 'rails_helper'

feature 'User authenticates' do
  scenario 'successfully' do
    user = create(:user)
    visit root_path
    click_on I18n.t('shared.links.sign_in', scope: 'devise')
    within 'form' do
      fill_in I18n.t('user.email', scope: 'devise'), with: user.email
      fill_in I18n.t('user.password', scope: 'devise'), with: user.password
      click_on I18n.t('session.new.sign_in', scope: 'devise')
    end
    expect(current_path).to eq(root_path)
    expect(page).to have_content(I18n.t('session.signed_in', scope: 'devise'))
    expect(page).to have_content(I18n.t('shared.links.sign_out', scope: 'devise'))
    expect(page).to_not have_content(I18n.t('shared.links.sign_in', scope: 'devise'))
  end
end
