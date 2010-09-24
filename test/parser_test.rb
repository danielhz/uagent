require 'rubygems'
require 'uagent/parser'

describe 'UAgent::Parser' do

  before(:all) do
    @parser = UAgent::Parser.new([:desktop, :mobile])
  end

  it 'get a device indicated in the user agent attribute' do
    env = { 'HTTP_USER_AGENT' => 'Nokia' }
    @parser.call(env).should == :mobile
    env = { 'HTTP_USER_AGENT' => 'Opera Mini' }
    @parser.call(env).should == :mobile
    env = { 'HTTP_USER_AGENT' => 'Firefox' }
    @parser.call(env).should == :desktop
  end

end
