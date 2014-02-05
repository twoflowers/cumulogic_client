# Copyright 2014 CumuLogic, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class CumulogicClient::BaseClient
  def initialize(api_url, username, password, use_ssl=nil)
    @api_url  = api_url
    @username = username
    @password = password
    @use_ssl  = use_ssl
    @validationparams = nil
  end

  def call(command, params=nil)
    login() if not @validationparams
    params = Hash.new() if not params
    params[:validationParams] = @validationparams
    request(command, params)
  end
  
  def request(command, params=nil)
    url = "#{@api_url}#{command}"
    puts url
    puts params
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = @use_ssl
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = params.to_json if params
    response = http.request(request)

    if !response.is_a?(Net::HTTPOK)
      if ["431","530","404"].include?(response.code)
        raise ArbumentError, response.message
      end
      raise RuntimeError, "Username and password not accepted" if ["401","403"].include?(response.code)
      raise RuntimeError, "Unknown error: code=#{response.code} message=#{response.message}"
    end

    puts response.body
    return JSON.parse(response.body)

  end

  def login()
    credentials = Array.new(1)
    credentials[0] = {
      "userName" => @username,
      "password" => @password
    }
    login_params = Hash.new
    login_params["validationParams"] = Hash.new
    login_params["inputParams"] = credentials
    loginresponse = request("auth/login", login_params)
    @validationparams = {
      "userID" => loginresponse["response"][0]["userID"],
      "userName" => loginresponse["response"][0]["userName"],
      "userLoginToken" => loginresponse["response"][0]["userLoginToken"]
    }

  end

end
