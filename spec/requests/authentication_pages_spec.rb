require 'spec_helper'

describe "AuthenticationPages" do

  subject { page } # Carybara provide, the test's profile

  describe "signin page" do
    before { visit signin_path }

    it { should have_title('Sign in') }
    it { should have_content('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', 
                                 text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }

        it { should_not have_selector('div.alert.alert-error') } 
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) } # FactoryGirl为测试实例构造对象

      before do # 填写表单
        fill_in "Email",    with: user.email.downcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed with sign out" do
        before { click_link "Sign out" }

        it { should have_link 'Sign in' }
      end
    end
  end
end
