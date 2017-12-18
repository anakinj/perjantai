module Perjantai
  module API
    class Lottery < Grape::API
      format :json
      resource :lottery do
        params do
          requires :name, type: String
        end

        post do
          body(id: ::Perjantai::Commands::CreateLottery.new(declared(params)).execute!)
          status 201
        end

        get do
          body ::Perjantai::Materializer.create(::Perjantai::Models::Lottery, params[:id]).to_h
        end
      end
    end
  end
end
