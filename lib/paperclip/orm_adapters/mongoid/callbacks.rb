module Paperclip
module Mongoid

  # Adds Mongoid-specific callback behavior to your model.
  # Mongoid and Active Record have a difference in their destroy
  # as Mongoid does not support transactions.
  module Callbacks

    def self.included(base)
      base.extend(ClassMethods)
    end

    # Define the Mongoid-specific callbacks
    def define_on(klass, name)
      klass.send(:after_destroy) { send(name).send(:flush_deletes) }
    end

    module ClassMethods

      # Extend paperclip's #has_attached_file method using alias_method_chain.
      # Defines the Mongoid callbacks after the original method has completed.
      def has_attached_file_with_mongoid_callbacks(field, options = {})
        has_attached_file_without_mongoid_callbacks(field, options)
        Paperclip::Mongoid::Callbacks.define_on(self, field)
      end
      alias_method_chain :has_attached_file, :mongoid_callbacks
    end
  end
end
end
