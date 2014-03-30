require 'paperclip/callbacks'
require 'paperclip/validators'
require 'paperclip/orm_adapters/active_record/glue'
require 'paperclip/orm_adapters/mongoid/glue'

module Paperclip

  # Adds paperclip functionality to the model
  module Glue
    def self.included(base)

      # ORM-independent functionality
      base.extend ClassMethods
      base.send :include, Callbacks
      base.send :include, Validators

      # ORM-specific functionality
      if defined?(::ActiveRecord::Base) && base.is_a?(::ActiveRecord::Base)
        base.send :include, ::Paperclip::ActiveRecord::Glue

      elsif defined?(::Mongoid::Document) && base.include?(::Mongoid::Document)
        base.send :include, ::Paperclip::Mongoid::Glue

      end
    end
  end
end
