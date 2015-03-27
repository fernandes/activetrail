class Book < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD
    model Book, :create

    contract do
      include Reform::Form::ModelReflections
      property :title

      validates :title, presence: true, length: { minimum: 2 }
    end

    def process(params)
      validate(params[:book]) do |f|
        f.save
      end
    end
  end

  class Update < Create
    action :update
    def process(params)
      validate(params[:book]) do |f|
        f.save
      end
    end
  end
  
  class Index < Create
    include Pagination, Scope
  end
  
  class Show < Update
    def process(params)
      self
    end
  end
end
