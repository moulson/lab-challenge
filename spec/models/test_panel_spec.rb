require 'rails_helper'

describe TestPanel, type: :model do
  it 'should store the data in a DATA constant' do
    expect(TestPanel::DATA.length > 0).to eq true
  end
end

describe TestPanelsController, type: :controller do
  describe '#show' do
    it 'should give an error if no id matches' do
      get :show, params:{id: 'fakeid'}
      expected_json = {
        data:{
          error: "test panel with id 'fakeid' not found"
        }
      }.to_json
      expect(response.body).to eq(expected_json)
    end

    it 'ignores include parameter if it does not equal test' do
      
    end

    it 'passes the first test case' do
      #The test case is NO INCLUDE and test panel TP2
      get :show, params:{id: 'TP2'}

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

    it 'passes the second test case' do
      #The test case is TP2 and include = test
      get :show, params:{id: 'TP2', included: 'test'}

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

    it 'ignores the included param if it does not equal test' do
      get :show, params:{id: 'TP2', included: 'wrong'}
      #should give same result as the first test case

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