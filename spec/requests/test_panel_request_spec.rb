require 'rails_helper'

describe 'Requesting a test panel', type: :request do
  context 'with a valid test panel ID' do
    let(:test_panel_id) { 'TP1' }
    
    it 'should respond with an HTTP 200 status' do
      get "/test_panels/#{test_panel_id}"
      expect(response.status).to eq(200)
    end
  end

  context 'with an invalid test panel ID' do
    let(:test_panel_id){ 'FAKE' }
    it 'should respond with an HTTP 400 status' do
      get "/test_panels/#{test_panel_id}"
      expect(response.status).to eq(400) 
    end
  end
end