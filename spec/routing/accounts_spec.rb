require 'spec_helper'

describe 'accounts routing' do

  it "routes to the user's accounts page" do
    expect(get: '/users/1/accounts').to route_to(
      controller: 'accounts',
      action: 'index',
      user_id: '1'
    )
  end
end

