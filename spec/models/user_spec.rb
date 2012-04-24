# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  it "应该判别姓名的合法性" do
    ok_name='李华顺'
    bad_name='大老鼠'
    stub(WebService).name_okay?(ok_name){true}
    stub(WebService).name_okay?(bad_name){false}
    user = User.new
    user.name = ok_name
    user.valid?
    user.errors['name'].should be_blank
    user.name = bad_name
    user.valid?
    user.errors['name'].should_not be_blank
  end
end
