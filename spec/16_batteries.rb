require_relative 'spec_helper'

describe Battery do
  before :each do
    @battery = Battery.new
  end

  it "should be a type of Item" do
    expect(@battery).to be_a_kind_of(Item)
  end

  it "should have a name of Battery" do
    expect(@battery.name).to eq("Battery")
  end

  it "should weigh 25" do
    expect(@battery.weight).to eq(25)
  end

end