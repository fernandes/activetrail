module ActiveTrail
  module Controller
    def self.included(base)
      base.class_eval do
        before_action :current_user_merge
      
        def current_user_merge
          if respond_to?(:current_user) && !current_user.nil?
            params[:current_user] = current_user
          end
        end
      end

      if base.instance_methods.include?(:collection)
        Trailblazer::Operation::Controller.instance_eval do
          begin
            # As activeadmin has a collection controller method we remove it
            # so we don't override original method and use `trb_collection`
            # unless respond_to?(:trb_collection)
            alias_method :trb_collection, :collection
            remove_method :collection
          rescue NameError
            # So you're doing a null rescue here, do you like it? NO!
            # But every modification on a AA related class, this class is reloaded
            # and was trying make the alias_method and raise this exception
            # don't know if its a rails issue, or my code issue
            # if someone knows how to fix without this (unpolite) nil rescue
            # please open an issue / PR
          end
        end
        base.include Trailblazer::Operation::Controller
      end
      require 'trailblazer/operation/controller/active_record'
      base.include Trailblazer::Operation::Controller::ActiveRecord # named instance variables.
    end
    
    def collection
      return get_collection_ivar if get_collection_ivar
      trb_collection "#{trailblazer_operation_name}::Index".constantize do |op|
        set_collection_ivar(@collection)
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
