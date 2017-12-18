require_relative 'lottery'
module Perjantai
  module API
    class Root < Grape::API
      mount Lottery
    end
  end
end
