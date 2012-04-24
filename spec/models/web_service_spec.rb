# -*- encoding : utf-8 -*-
require 'spec_helper'

describe WebService do
  it "姓名服务：应该能正确辨别合法与不合法的姓名" do
    [
      ['大老鼠',false],
      ['李世民',true],
      ['潘旻琦',true],
      ['李云龙',true],
      ['fjdsklfdsk',false],
      ['-----',false]
    ].each do |arr|
      WebService.name_okay?(arr[0]).should eq arr[1]
    end
  end
end
