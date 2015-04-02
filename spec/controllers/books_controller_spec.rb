RSpec.describe Admin::BooksController, :type => :controller do

  describe "GET index" do
    it "assigns books" do
      book1 = Book.create(title: "show")
      book2 = Book.create(title: "hidden")
      get :index
      expect(assigns(:books)).to eq([book1])
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "GET new" do
    it "assigns a Book form object" do
      get :new
      expect(assigns(:form).model).to be_a_new(Book)
    end
    
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "POST create" do
    context "with valid attributes" do
      before(:each) { post :create, {book: {title: "My Book"}} }
      it "assigns a create book" do
        expect(assigns(:book)).to be_a(Book)
      end
      
      it "assigns a form for book" do
        expect(assigns(:form).model).to be_a(Book)
      end
      
      it "book has the specified name" do
        expect(assigns(:book).title).to eq("My Book")
      end
    
      it "redirects to" do
        expect(response).to redirect_to(admin_book_path(1))
      end
      
      it "has status :found" do
        expect(response).to have_http_status(:found)
      end
    end
    
    context "with invalid attributes" do
      # form is the same object as book
      # but here just checking book because is what AA uses
      before(:each) { post :create, {book: {title: "a"}} }
      it "book is the form object" do
        expect(assigns(:book).model).to be_a_new(Book)
      end
      
      it "form is invalid" do
        expect(assigns(:book).valid?).to eq(false)
      end
      
      it "book has the specified name" do
        expect(assigns(:book).title).to eq("a")
      end
    
      it "renders the new template" do
        expect(response).to render_template("active_admin/resource/new")
      end
      
      it "has status :ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET show" do
    before(:each) do
      @book = Book.create(title: 'First Book')
      get :show, id: @book.id
    end
    
    it "assigns book" do
      expect(assigns(:book)).to eq(@book)
    end
    
    it "book has the specified title" do
      expect(assigns(:book).title).to eq(@book.title)
    end
  
    it "renders the new template" do
      expect(response).to render_template("active_admin/resource/show")
    end
    
    it "has status :ok" do
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe "GET edit" do
    before(:each) do
      @book = Book.create(title: "My Book")
      get :edit, id: @book.id
    end

    it "assigns book as the model" do
      expect(assigns(:book)).to eq(@book)
    end
    
    it "form is invalid" do
      expect(assigns(:book).valid?).to eq(true)
    end
    
    it "book has the specified name" do
      expect(assigns(:book).title).to eq(@book.title)
    end
  
    it "renders the new template" do
      expect(response).to render_template("active_admin/resource/edit")
    end
    
    it "has status :ok" do
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe "PUT update" do
    context "with valid attributes" do
      before(:each) do
        @book = Book.create(title: "First Book")
        patch :update, {id: @book.id, book: {title: "My Book"}}
      end
      it "assigns a create book" do
        expect(assigns(:book)).to be_a(Book)
      end
      
      it "assigns a form for book" do
        expect(assigns(:form).model).to be_a(Book)
      end
      
      it "book has the specified name" do
        expect(assigns(:book).title).to eq("My Book")
      end
    
      it "redirects to" do
        expect(response).to redirect_to(admin_book_path(@book.id))
      end
      
      it "has status :found" do
        expect(response).to have_http_status(:found)
      end
    end
    
    context "with invalid attributes" do
      # form is the same object as book
      # but here just checking book because is what AA uses
      before(:each) do
        @book = Book.create(title: "First Book")
        patch :update, {id: @book.id, book: {title: "a"}}
      end
      it "book is the form object" do
        expect(assigns(:book).model).to be_a(Book)
      end
      
      it "form is invalid" do
        expect(assigns(:book).valid?).to eq(false)
      end
      
      it "book has the specified name" do
        expect(assigns(:book).title).to eq("a")
      end
    
      it "renders the new template" do
        expect(response).to render_template("active_admin/resource/edit")
      end
      
      it "has status :ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "DELETE destroy" do
    before(:each) do
      @book = Book.create(title: 'First Book')
      delete :destroy, id: @book.id
    end
    
    it "assigns book" do
      expect(assigns(:book)).to eq(@book)
    end
    
    it "assigns book as destroyed model" do
      expect(assigns(:book).destroyed?).to eq(true)
    end
  
    it "renders the new template" do
      expect(response).to redirect_to(admin_books_path)
    end
    
    it "has status :found" do
      expect(response).to have_http_status(:found)
    end
  end
end

