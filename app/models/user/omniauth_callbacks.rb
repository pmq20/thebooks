# coding: utf-8
class User
  module OmniauthCallbacks
    Setting.omniauths.each do |provider|
      define_method "find_or_create_for_#{provider}" do |response|
        uid = response["uid"]
        data = response["info"]
        if user = User.where("authorizations.provider" => provider , "authorizations.uid" => uid).first
          user
        elsif user = User.find_by_email(data["email"])
          user.bind_service(response)
          user
        else
          user = User.new_from_provider_data(provider, uid, data)
          if user.save(:validate => false)
            user.authorizations << Authorization.new(:provider => provider, :uid => uid )
            return user
          else
            Rails.logger.error("User.create_from_hash 失败，#{user.errors.inspect}")
            return nil
          end
        end
      end
    end

    def new_from_provider_data(provider, uid, data)
      User.new do |user|
        user.email = data["email"]
        user.email ||= "#{uid}@#{provider}.user.com"
        user.name = data['name']
        user.nickname = data["nickname"]
        user.password = Devise.friendly_token[0, 20]
        user.location = data["location"]
        user.tagline = data["description"]
      end
    end
  end
end
