require 'rails_helper'

describe TestPanel, type: :model do
  it 'should store the data in a DATA constant' do
    expect(TestPanel::DATA.length > 0).to eq true
  end
end