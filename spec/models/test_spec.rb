require 'rails_helper'

describe Test, type: :model do
  it 'should store the data in a DATA constant' do
    expect(Test::DATA.length > 0).to eq true
  end
end