# -*- encoding : utf-8 -*-
class WebService
  class << self
    # From renren
    def name_okay?(q)
      begin
        okay = false
        resource = RestClient::Resource.new('http://reg.renren.com/AjaxRegisterAuth.do', :open_timeout => 1, :timeout => 1)
        res = resource.post("authType"=>"name","rndval"=>Time.now.to_i.to_s,"t"=>Time.now.to_i.to_s,"value"=>q)
        okay ||= ('OKNAME'==res)
        return okay
      rescue => e
        if 'test'==Rails.env
          raise e
        else
          return true
        end
      end
    end
  end
end
