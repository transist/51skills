require 'spec_helper'

describe Person do
  it 'should create a new instance via Factory' do
    expect {
      person = create(:person)
    }.to change(Person, :count).by(1)
  end
end
