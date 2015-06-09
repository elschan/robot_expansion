require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.create
    @robot2 = Robot.create
  end

  it "should have two total robots" do
    expect(Robot.all_robots.count).to eq(2)
  end

end
