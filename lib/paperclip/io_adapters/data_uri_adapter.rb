module Paperclip
  class DataUriAdapter < StringioAdapter
    def self.register
      Paperclip.io_adapters.register self do |target|
        String === target && target =~ Paperclip::DataUriAdapter::REGEXP
      end
    end

    REGEXP = /\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/m

    def initialize(target_uri)
      super(extract_target(target_uri))
    end

    private

    def extract_target(uri)
      data_uri_parts = uri.match(REGEXP) || []
      StringIO.new(Base64.decode64(data_uri_parts[2] || ""))
    end
  end
end
