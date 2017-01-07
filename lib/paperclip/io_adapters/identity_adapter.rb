module Paperclip
  class IdentityAdapter < AbstractAdapter
    def self.register
      Paperclip.io_adapters.register Paperclip::IdentityAdapter.new do |target|
        Paperclip.io_adapters.registered?(target)
      end
    end

    def new(adapter)
      adapter
    end
  end
end

Paperclip::IdentityAdapter.register
