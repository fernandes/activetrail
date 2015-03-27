module ActiveTrail
  module Controller
    def self.included(base)
      if base.instance_methods.include?(:collection)
        Trailblazer::Operation::Controller.instance_eval do
          # As activeadmin has a collection controller method we remove it
          # so we don't override original method and use `trb_collection`
          alias_method :trb_collection, :collection
          remove_method :collection
        end
        base.include Trailblazer::Operation::Controller
      end
      require 'trailblazer/operation/controller/active_record'
      base.include Trailblazer::Operation::Controller::ActiveRecord # named instance variables.
    end

    def scoped_collection
      trb_collection "#{trailblazer_operation_name}::Index".constantize do |op|
        return @collection
      end
    end

    def find_collection
      trb_collection "#{trailblazer_operation_name}::Index".constantize do |op|
        return @collection
      end
    end
    
    def find_resource
      if params.has_key?(:id)
        run "#{trailblazer_operation_name}::Show".constantize do |op|
          return op.model
        end
      else
        form "#{trailblazer_operation_name}::Create".constantize do |op|
          return op.contract
        end
      end
    end

    def build_new_resource
      if params[:action] == 'create'
        run "#{trailblazer_operation_name}::Create".constantize do |op|
          return op.model
        end.else do |op|
          return op.contract
        end
      else
        form "#{trailblazer_operation_name}::Create".constantize do |op|
          return @contract
        end
      end
    end

    def create_resource(object)
      run_create_callbacks object do
        return object
      end
    end

    def update(options={}, &block)
      object = resource
      run "#{trailblazer_operation_name}::Update".constantize do |op|
        options[:location] ||= smart_resource_url
        respond_with(op.model, options)
      end.else do |op|
        instance_variable_set("@#{trailblazer_model_name}".to_sym, op.contract)
        respond_with(op, options)
      end
    end
    
    private
    def trailblazer_operation_name
      resource_class.to_s
    end
    
    def trailblazer_model_name
      resource_class.model_name.element
    end
  end
end
