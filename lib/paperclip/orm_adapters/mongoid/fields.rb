module Paperclip
module Mongoid

  # Adds Mongoid "fields" to your model when the
  # "#has_attached_file" method is invoked. Note that unlike Active Record,
  # Mongoid/MongoDB does not use a schema or migrations. Database fields
  # are defined directly in the model.
  module Fields

    def self.included(base)
      base.extend(ClassMethods)
    end

    # Define the Mongoid fields for paperclip
    def define_on(klass, name)
      klass.send(:field, :"#{name}_file_name",    :type => String)
      klass.send(:field, :"#{name}_content_type", :type => String)
      klass.send(:field, :"#{name}_file_size",    :type => Integer)
      klass.send(:field, :"#{name}_updated_at",   :type => DateTime)
    end

    module ClassMethods

      # Extend paperclip's #has_attached_file method using alias_method_chain.
      # Defines the Mongoid fields after the original method has completed.
      def has_attached_file_with_mongoid_fields(field, options = {})
        has_attached_file_without_mongoid_fields(field, options)
        Paperclip::Mongoid::Fields.define_on(self, field)
      end
      alias_method_chain :has_attached_file, :mongoid_fields
    end
  end
end
end
