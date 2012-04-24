# -*- encoding : utf-8 -*-
require 'acceptance/acceptance_helper'
feature '已登录用户的一些基本账号行为' do
  let(:user){Factory.create(:user)} 
  scenario '已登录用户的页面有一个锚标记' do
    as_user(user) do
      page.should have_selector '#core_user_signed_in'
    end
  end
  scenario '已登录的时候能看到退出链接，并能成功退出' do
    as_user(user) do
      visit '/'
      page.should have_selector '#core_logoutlink'
      click_link 'core_logoutlink'
      page.should have_selector '#core_not_user_signed_in'
    end
  end
end
