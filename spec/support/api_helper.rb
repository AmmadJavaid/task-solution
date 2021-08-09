module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end

module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body)
    end
  end
  module AuthHelpers
    def auth_headers(user)
      Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization']
    end
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :api # apply to all spec for apis folder
  config.include Rails.application.routes.url_helpers, type: :api
  config.include Request::JsonHelpers, type: :request
  config.include Request::AuthHelpers, type: :request
end
