require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @user = User.create!(
      first_name: 'Taylor',
      last_name: 'Hulsmans',
      email: 'thulsmans.2994@me.com',
      password: '123456',
      password_confirmation: '123456'
      )

    @category = Category.create! name: 'Apparel'
    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'Login button brings to sign in page' do
    visit root_path
    click_link 'Login'
    expect(page).to have_current_path (new_user_session_path)
  end

  scenario 'adding credentials redirects to root' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button'Log in'
    save_screenshot
    expect(page).to have_current_path (root_path)
    expect(page).to have_text "Logged in as: Taylor"
  end
end
