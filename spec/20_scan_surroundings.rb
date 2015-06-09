require_relative 'spec_helper'

# A given robot should be able to scan its surroundings (tiles immediately next to its current @position) 
# Note: You should leverage the class method implemented in #18

describe Robot do
  
  describe "#scan_surroundings" do
    it "should find all robots that are one unit away" do
      robot1 = Robot.new
      robot2 = Robot.new
      robot3 = Robot.new
      robot1.move_up
      robot2.move_down

      expect(robot3.scan_surroundings).to include robot1, robot2
    end
  end

end