require 'paperclip/orm_adapters/active_record/callbacks'
require 'paperclip/orm_adapters/active_record/schema'

module Paperclip
module ActiveRecord

  # Adds Active Record-specific functionality to the model.
  module Glue
    def self.included(base)
      base.send :include, Callbacks
      base.send :include, Schema
    end
  end
end
end
