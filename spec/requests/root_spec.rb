require 'spec_helper'

RSpec.describe 'Root path', type: :request do
  it 'responds successfully' do
    get '/'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('HOME')
  end
end
