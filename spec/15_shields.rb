require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @robot2 = Robot.new
  end

  it "should have shields" do
    expect(@robot.shields).to eq(50)
  end

  it "should deplete shields first when attacked" do
    @robot.attack(@robot2)
    expect(@robot2.shields).to eq(45) #50 minus default attack (5)
  end

  it "should not allow shields to go below 0" do
    plasma = PlasmaCannon.new
    @robot.equipped_weapon = plasma
    @robot.attack(@robot2)   
    expect(@robot2.health).to be <= 0
  end

  it "should not take health damage if shields remain" do
    @robot.attack(@robot2)   
    expect(@robot2.health).to eq(Robot::MAX_HEALTH)
  end

end