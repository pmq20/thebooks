# -*- encoding : utf-8 -*-
module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.

  # Will run the given code as the user passed in
  def as_user(user=nil, &block)
    current_user = user || Factory.create(:user)
    if request.present?
      sign_in(current_user)
    else
      login_as(current_user, :scope => :user)
    end
    block.call if block.present?
    return self
  end


  def as_visitor(user=nil, &block)
    current_user = user || Factory.stub(:user)
    if request.present?
      sign_out(current_user)
    else
      logout(:user)
    end
    block.call if block.present?
    return self
  end

end

RSpec.configuration.include HelperMethods, :type => :acceptance
