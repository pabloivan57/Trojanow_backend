module Requests
  module JsonHelpers
    JSON_CONTENT_TYPE = {'Content-Type' => 'application/json'}
    JSON_ACCEPT = {'Accept' => 'application/json'}

    def json
      JSON.parse(response.body)
    end

    def json_headers
      {
        'Accept'       => 'application/json',
        'Content-Type' => 'application/json'
      }
    end
  end

  module RequestMethods
    def json_post(url, params = {}, headers = {})
      post url, params.to_json, headers.merge(JsonHelpers::JSON_CONTENT_TYPE)
    end

    def json_put(url, params = {}, headers = {})
      put url, params.to_json, headers.merge(JsonHelpers::JSON_CONTENT_TYPE)
    end

    def json_delete(url, params, headers = {})
      delete url, params.to_json, headers.merge(JsonHelpers::JSON_CONTENT_TYPE)
    end

    def get(url, params = {}, headers = {})
      super url, params, headers.merge(JsonHelpers::JSON_ACCEPT)
    end

    def post(url, params = {}, headers = {})
      super url, params, headers.merge(JsonHelpers::JSON_ACCEPT)
    end

    def put(url, params = {}, headers = {})
      super url, params, headers.merge(JsonHelpers::JSON_ACCEPT)
    end

    def delete(url, params = {}, headers = {})
      super url, params, headers.merge(JsonHelpers::JSON_ACCEPT)
    end

    def patch(url, params = {}, headers = {})
      super url, params, headers.merge(JsonHelpers::JSON_ACCEPT)
    end

    def auth_header(user)
      { 'Authorization-Token' => user.authentication_token }
    end
  end
end
