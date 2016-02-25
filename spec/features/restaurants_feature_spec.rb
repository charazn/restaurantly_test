require 'rails_helper'

RSpec.feature "Restaurants feature", type: :feature, driver: :selenium do

  describe "visit root_path" do
    before { visit '/' }

    it "shows root or home page" do
      expect(page).to have_content("Restaurantly Spots!")
    end
  end

  describe "create a new restaurant" do
    before { visit '/restaurants/new' }

    it "creates a new restaurant and renders show" do
      restaurant_name = "Mc Restaurant"
      fill_in "restaurant_name", with: restaurant_name
      click_button "Create Restaurant"
      expect(page).to have_content(restaurant_name)
    end

    context "no restaurant name provided" do
      it "redirects to root" do
        click_button "Create Restaurant"
        expect(page).to have_content("Create a new Restaurant")
      end
    end
  end

  describe "edit and update a restaurant" do
    before do
      visit '/restaurants/new'
      restaurant_name = "Edit restaurant name"
      fill_in "restaurant_name", with: restaurant_name
      click_button "Create Restaurant"
      expect(page).to have_content(restaurant_name)
      click_link "edit"
      expect(page).to have_content("Edit Restaurant")
    end

    it "edits restaurant and renders show" do
      new_restaurant_name = "New restaurant name"
      fill_in "restaurant_name", with: new_restaurant_name
      click_button "Update Restaurant"
      expect(page).to have_content(new_restaurant_name)
    end

    context "restaurant name not filled in" do
      it "redirects to root" do
        fill_in "restaurant_name", with: nil
        click_button "Update Restaurant"
        expect(page).to have_content("Edit Restaurant")
      end
    end
  end

  describe "destroy a restaurant" do
    restaurant_name = "Some restaurant name"
    before do
      visit '/restaurants/new'
      fill_in "restaurant_name", with: restaurant_name
      click_button "Create Restaurant"
      expect(page).to have_content(restaurant_name)
    end

    it "destroys a restaurant" do
      click_link "destroy"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Restaurantly Spots!")
      expect(page).to have_no_content(restaurant_name)
    end
  end

end
