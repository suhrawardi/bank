require 'spec_helper'

describe 'transfers routing' do

  it "routes to the user's new transfer page" do
    expect(get: '/users/1/transfers/new').to route_to(
      controller: 'transfers',
      action: 'new',
      user_id: '1'
    )
  end

  it "routes to the user's create transfer page" do
    expect(post: '/users/1/transfers').to route_to(
      controller: 'transfers',
      action: 'create',
      user_id: '1'
    )
  end
end

