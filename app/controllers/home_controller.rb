# require 'net/http'

class HomeController < ApplicationController
  def index
  end
  
  def search
        url = URI.parse('http://api.ser.ideas.iii.org.tw:80/api/user/get_token')
        req = Net::HTTP::Post.new(url.to_s)
        req.set_form_data({"secret_key" => "5923c0fed76c1ab933f6b7f18b4f266e", "id" => "74c9ff7bd7306d81f5ce2a543dc35d95"})
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        @rex = JSON.parse(res.body)
        data = JSON.parse(res.body)
        @token = data['result']['token']



        url = URI.parse('http://api.ser.ideas.iii.org.tw:80/api/keyword_search/ptt')
        req = Net::HTTP::Post.new(url.to_s)
        req.set_form_data({
            "token" => @token,
            "keyword" => "\"#{params[:keyword]}\"",
            "sort" => "time_desc", #time_desc / push
            "type" => "title", #title / all
            "start_date" => "2000-01-01",
            "end_date" => "2015-08-01"
        })
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        @pttResults = JSON.parse(res.body)



        url = URI.parse('http://api.ser.ideas.iii.org.tw:80/api/keyword_search/facebook')
        req = Net::HTTP::Post.new(url.to_s)
        req.set_form_data({
            "token" => @token,
            "keyword" => "\"#{params[:keyword]}\"",
            "sort" => "likes", #time_desc / likes / shares / comments
            "type" => "title", #title / all
            "start_date" => "2000-01-01",
            "end_date" => "2015-08-01"
        })
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        @fbResults = JSON.parse(res.body)


        url = URI.parse('http://api.ser.ideas.iii.org.tw:80/api/keyword_search/forum')
        req = Net::HTTP::Post.new(url.to_s)
        req.set_form_data({
            "token" => @token,
            "keyword" => "\"#{params[:keyword]}\"",
            "sort" => "reply", #time_desc
            "type" => "title", #title / all
            "start_date" => "2000-01-01",
            "end_date" => "2015-08-01"
        })
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        @forumResults = JSON.parse(res.body)




        url = URI.parse('http://api.ser.ideas.iii.org.tw:80/api/keyword_search/news')
        req = Net::HTTP::Post.new(url.to_s)
        req.set_form_data({
            "token" => @token,
            "keyword" => "\"#{params[:keyword]}\"",
            "sort" => "time_desc", #time_desc
            "type" => "title", #title / all
            "start_date" => "2000-01-01",
            "end_date" => "2015-08-01"
        })
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        @newsResults = JSON.parse(res.body)

  end

  def detail
  end
end
