require "spec_helper"

class Foo
  include ActiveAdmin::Filters::ViewHelper
  def except_fields
    except_hidden_fields
  end
end

RSpec.feature "Index page on activetrail controller", :type => :feature do
  scenario "Admin access things index" do
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)

    expect(Foo.new.except_fields).to eq([:q, :page, :current_user])

    visit "/admin/things"

    expect(page).to have_text("Things")
  end
end
