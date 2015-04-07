class Thing < ActiveRecord::Base
  has_many :comments, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :comments, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }  

  class Create < Trailblazer::Operation
    include CRUD, Pagination, Scope
    model Thing, :create
    
    contract do
      include Reform::Form::ModelReflections

      property :title
      collection :comments, populate_if_empty: Comment do
        include ActiveTrail::Reform::NestedForm
        property :title
        reject_if_blank :title
      end

      validates :title, presence: true, length: { minimum: 2 }
    end

    def process(params)
      validate(params[:thing]) do |f|
        f.save
      end
    end
  end
  
  class Update < Create
    action :update
    def process(params)
      validate(params[:thing]) do |f|
        # f.save raises RuntimeError: Can't modify frozen hash
        # so workarounded using f.sync and @model.save!
        f.sync
        @model.save!
      end
    end
  end

  class Index < Create
    def fetch(params)
      Thing.all
    end
  end
  
  class Show < Update
    def process(params)
      self
    end
  end
end
