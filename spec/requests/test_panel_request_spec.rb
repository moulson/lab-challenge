require 'rails_helper'

describe 'Requesting a test panel', type: :request do
  context 'with a valid test panel ID' do
    let(:test_panel_id) { 'TP2' }
    
    it 'should respond with an HTTP 200 status' do
      get "/test_panels/#{test_panel_id}"
      expect(response.status).to eq(200)
    end

    it 'should match the first test case' do
      get "/test_panels/#{test_panel_id}"
      expected_json = {
        "data": {
          "type": "test_panels",
          "id": "TP2",
          "attributes": {
            "price": 2100,
            "sample_tube_types": ["purple", "yellow"],
            "sample_volume_requirement": 220
          },
          "relationships": {
            "test": {
              "data": [
                { "id": "B12", "type": "test"},
                { "id": "HBA1C", "type": "test"}
              ]
            }
          }
        }
      }.to_json
      expect(response.body).to eq(expected_json)
    end


  end

  context 'with an invalid test panel ID' do
    let(:test_panel_id){ 'FAKE' }
    it 'should respond with an HTTP 400 status' do
      get "/test_panels/#{test_panel_id}"
      expect(response.status).to eq(400) 
    end

    it 'should give an error message' do
      get "/test_panels/#{test_panel_id}"
      expected_json = {
        data:{
          error: "test panel with id '#{test_panel_id}' not found"
        }
      }.to_json
      expect(response.body).to eq(expected_json)
    end
  end

  context 'with a valid test panel ID and includes tests' do
    let(:test_panel_id){'TP2'}
    let(:included){'test'}

    it 'should respond with an HTTP 200 status' do
      get "/test_panels/#{test_panel_id}?included=#{included}"
      expect(response.status).to eq(200)
    end

    it 'should match the second test case' do
      get "/test_panels/#{test_panel_id}?included=#{included}"
      expected_json = {
        "data": {
           "type": "test_panels",
           "id": "TP2",
           "attributes": {
             "price": 2100,
             "sample_tube_types": ["purple", "yellow"],
             "sample_volume_requirement": 220
           },
           "relationships": {
             "test": {
               "data": [
                 { "id": "B12", "type": "test"},
                 { "id": "HBA1C", "type": "test"}
               ]
             }
           }
         },
         "included": [
           {
             "type": "test",
             "id": "B12",
             "attributes": {
               "name": "Vitamin B12",
               "sample_volume_requirement": 180,
               "sample_tube_type": "yellow"
             }
           },
           {
             "type": "test",
             "id": "HBA1C",
             "attributes": {
               "name": "HbA1C",
               "sample_volume_requirement": 40,
               "sample_tube_type": "purple"
             }
           }
         ]
        }.to_json
        expect(response.body).to eq(expected_json)
    end

    context 'with a valid test panel ID and an invalid includes' do
      let(:test_panel_id){'TP2'}
      let(:included){'invalid'}

      it 'should respond with an HTTP 200 status' do
        get "/test_panels/#{test_panel_id}?included=#{included}"
        expect(response.status).to eq(200)
      end

      it 'should ignore the includes parameter' do
        #if it ignores, it should be the same output as the first test case
        get "/test_panels/#{test_panel_id}?included=#{included}"
        expected_json = {
          "data": {
            "type": "test_panels",
            "id": "TP2",
            "attributes": {
              "price": 2100,
              "sample_tube_types": ["purple", "yellow"],
              "sample_volume_requirement": 220
            },
            "relationships": {
              "test": {
                "data": [
                  { "id": "B12", "type": "test"},
                  { "id": "HBA1C", "type": "test"}
                ]
              }
            }
          }
        }.to_json
        expect(response.body).to eq(expected_json)
      end
    end
  end
end