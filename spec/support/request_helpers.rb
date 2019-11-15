module Requests
  module JsonHelpers
    def response_json
      JSON.parse(response.body)
    end
  end

  # All kinds of goodies going on here. Here's the doc for revoke_jwt:
  # https://github.com/waiting-for-dev/devise-jwt/blob/master/lib/devise/jwt/revocation_strategies/blacklist.rb
  module JwtHelpers
    def blacklist_user(user)
      jwt_token = jwt_headers['Authorization'].split(' ').last
      token_payload = jwt_token.split('.')[1]
      base64_decoded = Base64.decode64 token_payload
      json_parsed = JSON.parse(base64_decoded)
      JWTBlacklist.revoke_jwt json_parsed, user
    end
  end
end