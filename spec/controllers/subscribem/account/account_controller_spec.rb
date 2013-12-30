require 'spec_helper'

module Subscribem
  describe Account::AccountsController do
    context "creates the account's schema" do
      let!(:account) { stub_model(Subscribem::Account) }

      before do
        Subscribem::Account.should_receive(:create_with_owner).
        and_return(account)
        account.stub valid?: true
        controller.stub(:force_authentication!)
      end
      specify do
        account.should_receive(:create_schema)
        post :create, account: { name: "First account" },
          use_route: :subscribem
      end
    end
  end
end
