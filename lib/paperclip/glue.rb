require 'paperclip/callbacks'
require 'paperclip/validators'
require 'paperclip/schema'

module Paperclip
  module Glue
    def self.included(base)
      base.extend ClassMethods
      base.send :include, Callbacks
      base.send :include, Validators
      base.send :include, Schema if defined? ActiveRecord
    end
  end
end
