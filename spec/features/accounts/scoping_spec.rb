require "spec_helper"

feature "Account Scoping" do
  let!(:account_a) { FactoryGirl.create(:account) }
  let!(:account_b) { FactoryGirl.create(:account) }

  before do
    Thing.create(name: "Account A's thing")
    Thing.create(name: "Account B's thing")
  end

  scenario "display's only Acccount A's records" do
    sign_in_as(user: account_a.owner, account: account_a)
    visit main_app.things_url(subdomain: account_a.subdomain)
    page.should have_content "Account A's thing"
    page.should_not have_content "Account B's thing"
  end

  scenario "display's only Acccount B's records" do
    sign_in_as(user: account_b.owner, account: account_b)
    visit main_app.things_url(subdomain: account_b.subdomain)
    page.should have_content "Account B's thing"
    page.should_not have_content "Account A's thing"
  end
end
