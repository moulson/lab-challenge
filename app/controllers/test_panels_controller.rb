class TestPanelsController < ApplicationController

  def show
    #Get the hash via ID
    test_panel = TestPanel::DATA.select{|test| test[:id] == params[:id]}.first

    #Get an array of tests that the Test panel works with
    tests = []
    test_panel[:tests].each do |testy|
      tests.push Test::DATA.select{|x| x[:id] == testy}.first
    end

    debugger
    render json: test_panel
  end

end