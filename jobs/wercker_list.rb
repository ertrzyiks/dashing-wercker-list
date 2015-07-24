require "net/http"
require "json"

projects = [
  { :name => 'Example1', :user => 'YOUR_USER', :application => 'YOUR_APPLICATION1', :branch => 'master' },
  { :name => 'Example2', :user => 'YOUR_USER', :application => 'YOUR_APPLICATION2', :branch => 'master' }
]

API_ADDRESS= "https://app.wercker.com/api/v3"

def make_request(method, token)
    url = "#{API_ADDRESS}#{method}"
    uri = URI.parse(API_ADDRESS)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{token}"

    response = http.request(request)
    response_object = JSON.parse(response.body)

    response_object
end

def get_unknown_build
    data = {}
    data["result"] = "unknown"
    data["status"] = "unknown"
    data
end

def get_last_build(project, token)
    method = "/applications/#{project[:user]}/#{project[:application]}/builds?branch=#{project[:branch]}&limit=1"
    response = make_request(method, token);

    return get_unknown_build() if response.length == 0

    response.first
end

def get_status(project, token)
    last_build = get_last_build(project, token)

    {
        :class_name => "result-#{last_build["result"]} status-#{last_build["status"]}",
        :project => project,
        :build => last_build
    }
end

SCHEDULER.every '30s', :first_in => 0  do
  items = projects.map{ |p| get_status(p, ENV['WERCKER_AUTH_TOKEN']) }
  send_event('wercker-list', { :items => items })
end
