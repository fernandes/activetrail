require "spec_helper"

RSpec.describe "Book management", :type => :request do
  it "creates a Book and redirects to the Books's page" do
    get "/admin/books"
    expect(response).to render_template('active_admin/resource/index')

    post "/admin/books", :book => {:title => "My Book"}

    expect(response).to redirect_to(admin_book_path(1))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Book was successfully created.")
  end
end
