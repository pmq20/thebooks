# -*- encoding : utf-8 -*-
require 'acceptance/acceptance_helper'
feature '未登录用户的行为' do

  scenario '未登录用户的页面有一个锚标记' do
    as_visitor do
      page.should have_selector '#core_not_user_signed_in'
    end
  end
  scenario '未登陆时访问首页能看到登陆链接，打开之后可以用各种账号登陆' do
    as_visitor do
      visit '/'
      page.should have_selector '#core_reglink'
      click_link 'core_reglink'
      Setting.omniauths.each do |name|
        page.should have_selector "#core_oauth_via_#{name}_link"
      end
    end
  end

  Setting.omniauths.each do |name|
  end

end
