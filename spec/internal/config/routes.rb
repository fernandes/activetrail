Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  
  # Don't know if in normal situation would need to do this hack
  # but on tests AA was *not* creating this route, so created
  # manually to make test pass. Any other way is welcome!
  scope :admin do
    scope :books do
      get 'baz', controller: "admin/books"
    end
  end
end
