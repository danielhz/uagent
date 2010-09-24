require 'rubygems'
require 'uagent'

describe 'UAgent::Parser' do

  before(:all) do
  end

  it 'distinguishes between basic user agent sets' do
    parser = UAgent::Parser.new

    ua = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_1_2 like Mac OS X; en-us) " +
      "AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7D11 Safari/528.16"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :mobile

    ua = "Mozilla/5.0 (BlackBerry; U; BlackBerry 9800; en-US) " +
         "AppleWebKit/530.17 (KHTML, like Gecko) Version/6.0.0.62 Mobile Safari/530.17"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :mobile

    ua = "Mozilla/5.0 (Linux; U; Android 2.1-update1; en-us; DROIDX Build/VZW) " +
      "AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17 " +
      "480X854 motorola DROIDX"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :mobile

    ua = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.10) " +
      "Gecko/20100915 Ubuntu/10.04 (lucid) Firefox/3.6.10"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :desktop
  end

  it 'distinguishes user agent subsets' do
    parser = UAgent::Parser.new(:iphone, :blackberry)

    ua = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_1_2 like Mac OS X; en-us) " +
      "AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7D11 Safari/528.16"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :iphone

    ua = "Mozilla/5.0 (BlackBerry; U; BlackBerry 9800; en-US) " +
         "AppleWebKit/530.17 (KHTML, like Gecko) Version/6.0.0.62 Mobile Safari/530.17"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :blackberry

    ua = "Mozilla/5.0 (Linux; U; Android 2.1-update1; en-us; DROIDX Build/VZW) " +
      "AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17 " +
      "480X854 motorola DROIDX"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :mobile

    ua = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.10) " +
      "Gecko/20100915 Ubuntu/10.04 (lucid) Firefox/3.6.10"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :desktop
  end

  it 'allows to change the device database' do
    parser = UAgent::Parser.new(:test)
    parser.set_database({:test => ['Test']})

    ua = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.10) Test"
    env = { 'HTTP_USER_AGENT' => ua }
    parser.call(env).should == :test
  end

end
