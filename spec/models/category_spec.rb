require 'spec_helper'

describe Category do
  
  it "main category should have depth 0" do
    category = create(:category)
    category.depth.should eq(0)
  end

  it "sub category should have depth 1" do
    category = create(:sub_category)
    category.depth.should eq(1)
  end
end