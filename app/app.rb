module Perjantai
  def self.app
    @instance ||= Rack::Builder.new do
      run Rack::Cascade.new([Perjantai::API::Root, ::Rack::Static.new(
        -> { [404, {}, []] },
        root: File.expand_path('../../public', __FILE__),
        urls: ['/']
      )])
    end.to_app
  end
end
