class TestPanelsController < ApplicationController

  def show
    #Get the hash via id
    test_panel = TestPanel::DATA.select{|test| test[:id] == params[:id]}.first

    #make sure it's a valid id
    if test_panel.nil?
      json = {
        data:{
          error: "test panel with id '#{params[:id]}' not found"
        }
      }
      render json: json, status: 400
      return nil
    end

    #Get an array of tests that the Test panel works with
    tests = []
    test_panel[:tests].each do |t|
      tests.push Test::DATA.select{|x| x[:id] == t}.first
    end

    #sort tests alphabetically by id
    tests.sort_by! {|x| x[:id]}

    

    #Iterate over tests and add values
    sample_tubes = []
    sample_volume_requirement = 0
    
    tests.each do |t|
      sample_tubes.push(t[:sample_tube_type])
      sample_volume_requirement += t[:sample_volume_requirement]
    end

    #remove duplicates and sort
    sample_tubes.uniq!
    sample_tubes.sort!

    #create relationships hash
    relationships = []
    tests.each do |t|
      hash = {
        id: t[:id],
        type: 'test'
      }
      relationships.push(hash)
    end

    #create data hash
    data = {
        type: 'test_panels',
        id: params[:id],
        attributes: {
          price: test_panel[:price],
          sample_tube_types: sample_tubes,
          sample_volume_requirement: sample_volume_requirement
        },
        relationships: {
          test:{
            data:
              relationships
          }
        }
    }

    #if the 'included' parameter = 'test', append additional info to the response
    included = []
    if params[:included] == 'test'
      tests.each do |t|
        hash = {
          type: 'test',
          id: t[:id],
          attributes: {
            name: t[:name],
            sample_volume_requirement: t[:sample_volume_requirement],
            sample_tube_type: t[:sample_tube_type]
          }
        }
        included.push(hash)
      end
      json = {
        data: data,
        included: included
      }
    else
      json = {
        data: data
      }
    end
    
    render json: json, status: 200
  end
end