require File.expand_path '../spec_helper.rb', __FILE__

describe 'api' do
  it 'returns 400 if no board passed' do
    get '/play'
    expect(last_response.status).to eq(400)
  end

  it 'returns 400 if invalid board size' do
    get '/play', :board => 'xoxoxox '
    expect(last_response.status).to eq(400)
  end

  it 'returns 400 if no spaces left' do
    get '/play', :board => 'xoxoxoxox'
    expect(last_response.status).to eq(400)
  end

  it 'returns 400 if more os than xs' do
    get '/play', :board => ' oooooooo'
    expect(last_response.status).to eq(400)
  end

  it 'is ok if the game is just beginning' do
    get '/play', :board => '         '
    expect(last_response).to be_ok
  end

  it 'replays the board back with an o' do
    get '/play', :board => " xxo  o  "
    expect(last_response.body).to eq("oxxo  o  ")
  end
end
