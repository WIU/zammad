require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '7.4.1708'

  config.before(:each) do
    stub_command('/usr/bin/test /etc/alternatives/mta -ef /usr/sbin/sendmail.postfix').and_return(true)
  end
end

ChefSpec::Coverage.start!
