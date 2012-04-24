# coding: utf-8
class AccountController < Devise::RegistrationsController
  def edit
    @user = current_user
  end

  def create
    render text:'目前只能从第三方账号登陆过来，不允许注册用户'
  end

  def destroy
    resource.soft_delete
    sign_out_and_redirect("/login")
    set_flash_message :notice, :destroyed
  end
end
