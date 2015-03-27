RSpec.describe Admin::BooksController, :type => :controller do

  describe "GET index" do
    it do
      book = Book.create
      get :index
      expect(assigns(:books)).to eq([book])
    end
  end
end

