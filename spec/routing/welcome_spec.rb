require 'spec_helper'

describe 'welcome routing' do

  it 'routes to the default home page' do
    expect(get: '/').to route_to(
      controller: 'welcome',
      action: 'index'
    )
  end
end
