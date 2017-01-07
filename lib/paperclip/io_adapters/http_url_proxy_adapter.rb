module Paperclip
  class HttpUrlProxyAdapter < UriAdapter
    def self.register
      Paperclip.io_adapters.register self do |target|
        String === target && target =~ Paperclip::HttpUrlProxyAdapter::REGEXP
      end
    end

    REGEXP = /\Ahttps?:\/\//

    def initialize(target)
      super(URI(target))
    end

  end
end
