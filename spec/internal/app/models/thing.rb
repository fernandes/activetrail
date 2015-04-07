class Thing < ActiveRecord::Base
  class Index < Trailblazer::Operation
    include CRUD, Pagination, Scope
    model Thing, :create
    
    def fetch(params)
      Thing.all
    end
  end
end
