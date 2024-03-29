require "spec_helper"
feature "User sign in" do
  extend SubdomainHelpers
  let!(:account) { create(:account) }
  let(:sign_in_url) { "http://#{account.subdomain}.example.com/sign_in"}
  let(:root_url) { "http://#{account.subdomain}.example.com/"}
  within_account_subdomain do
    scenario "signs in as an account owner succesfully" do
      visit root_url
      page.current_url.should == sign_in_url
      fill_in "Email", with: account.owner.email
      fill_in "Password", with: "password"
      click_button "Sign in"
      page.should have_content("You are now signed in.")
      page.current_url.should == root_url
    end

    scenario "attempts sign in with an invalid password and fails" do
      visit root_url
      page.current_url.should == sign_in_url
      fill_in "Email", with: account.owner.email
      fill_in "Password", with: "not_password"
      click_button "Sign in"
      page.should have_content("Invalid email or password.")
      page.current_url.should == sign_in_url
    end

    scenario "attempts sign in with an invalid email and fails" do
      visit root_url
      page.current_url.should == sign_in_url
      fill_in "Email", with: "not_existing@email.com"
      fill_in "Password", with: "password"
      click_button "Sign in"
      page.should have_content("Invalid email or password.")
      page.current_url.should == sign_in_url
    end

    scenario "cannot sign in if not a part of this subdomain" do
      other_account = create(:account)
      visit subscribem.root_url(subdomain: account.subdomain)
      page.current_url.should == sign_in_url
      page.should have_content "Please sign in."
      fill_in "Email", with: other_account.owner.email
      fill_in "Password", with: 'password'
      click_button "Sign in"
      page.should have_content "Invalid email or password."
      page.current_url.should == sign_in_url
    end
  end
end
