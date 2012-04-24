# coding: utf-8
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  Setting.omniauths.each do |provider|
    class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def #{provider}
        if user_signed_in?
          current_user.bind_service(env["omniauth.auth"]) #Add an auth to existing
          redirect_to edit_user_registration_path, :notice => "成功绑定了 #{provider} 帐号。"
        else
          @user = User.find_or_create_for_#{provider}(env["omniauth.auth"])
          if @user.persisted?
            flash[:notice] = "Signed in with #{provider.to_s.titleize} successfully."
            sign_in_and_redirect @user, :event => :authentication, :notice => "登陆成功。"
          else
            redirect_to new_user_registration_url
          end
        end
      end
    RUBY
  end
end
