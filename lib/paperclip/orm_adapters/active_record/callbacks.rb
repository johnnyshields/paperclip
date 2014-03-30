module Paperclip
module ActiveRecord

  # Adds Active Record-specific callback behavior to your model.
  module Callbacks

    def self.included(base)
      base.extend(ClassMethods)
    end

    # Define the Active Record-specific callbacks
    def define_on(klass, name)
      klass.send(:after_commit, :on => :destroy) { send(name).send(:flush_deletes) }
    end

    module ClassMethods

      # Extend paperclip's #has_attached_file method using alias_method_chain.
      # Defines the Active Record callbacks after the original method has completed.
      def has_attached_file_with_ar_callbacks(field, options = {})
        has_attached_file_without_ar_callbacks(field, options)
        Paperclip::ActiveRecord::Callbacks.define_on(self, field)
      end
      alias_method_chain :has_attached_file, :ar_callbacks
    end
  end
end
end
