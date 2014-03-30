require 'paperclip/orm_adapters/mongoid/callbacks'
require 'paperclip/orm_adapters/mongoid/fields'

module Paperclip
module Mongoid

  # Adds Mongoid-specific functionality to the model.
  # Do NOT directly include this module in your models.
  # Please include Paperclip::Glue instead.
  module Glue
    def self.included(base)
      base.send :include, Callbacks
      base.send :include, Fields
    end
  end
end
end
