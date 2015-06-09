require_relative 'spec_helper'
require 'pry'

describe Robot do
  before :each do
    @optimus = Robot.create
    @megatron = Robot.create
  end

  it "should return both robots at 0,0" do
    expect(Robot.find_position([0,0])).to eq([@optimus, @megatron])
  end

  it "should return correct coordinates for all robots" do
    @optimus.move_up 
    expect(Robot.find_position([0,1])).to eq([@optimus])    
  end

end