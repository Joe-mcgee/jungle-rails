require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
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

  scenario do
    visit root_path
    click_link 'Details'
    expect(page).to have_current_path (product_path(id: '1'))

  end

  scenario do
    visit root_path
    find(:css, "img[src*='/uploads/product/image/1/thumb_apparel1.jpg']").click
    expect(page).to have_current_path (product_path(id: '1'))
  end
end
