require 'spec_helper'

describe Person do
  it 'should create a new instance via Factory' do
    expect {
      person = create(:person)
    }.to change(Person, :count).by(1)
  end
  
  it 'should create an admin via Factory' do
    expect {
      admin = create(:admin)
      admin.should be_admin
    }.to change(Person, :count).by(1)
  end
end
