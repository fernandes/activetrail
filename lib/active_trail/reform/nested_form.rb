module ActiveTrail
  module Reform
    module NestedForm
      extend ActiveSupport::Concern
 
      included do
        property :id, virtual: true
        property :_destroy, virtual: true
        @reject_field = []
      end
 
      def sync_hash(options)
        if fields._destroy == '1' || reject_fields?
          model.mark_for_destruction
        end
        super(options)
      end
 
      def new_record?
        model.new_record?
      end
 
      def marked_for_destruction?
        model.marked_for_destruction?
      end
 
      def reject_fields?
        self.class.reject_field.any? { |f| fields[f].blank? }
      end
 
      class_methods do
        def reject_if_blank(field)
          @reject_field << field
        end
 
        def reject_field
          @reject_field
        end
      end
 
    end
  end
end
