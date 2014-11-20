require 'spec_helper'
describe 'sox' do

  context 'with defaults for all parameters' do
    it { should contain_class('sox') }
  end
end
