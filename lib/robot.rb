class Robot

  @@all_robots = []

  attr_reader :position, :items, :items_weight, :max_weight_item, :shields, :MAX_HEALTH
  attr_accessor :equipped_weapon, :health

  MAX_CAPACITY = 250
  MAX_HEALTH = 100
  MAX_SHIELDS = 50
  MIN_HEALTH = 0
  DEFAULT_ATTACK = 5
  DEFAULT_RANGE = 1

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
    @shields = 50
  end

  def self.create
    @@all_robots << self.new
    @@all_robots.last
  end

  def self.all_robots
    @@all_robots
  end

  def self.find_position(requested_position)
    found_robots = @@all_robots.select do |robot| 
      robot.position == requested_position 
    end
    found_robots
  end

  def items_weight
    @items.inject(0) {|sum, item| sum + item.weight}
  end

  def pick_up(item)
    unless items_weight + item.weight > MAX_CAPACITY
      if item.is_a?(BoxOfBolts) && (health <=80)
        item.feed(self)
      end
      @equipped_weapon = item if item.is_a? Weapon
      @items << item
    end
  end

  def health
    @health
  end 

  def heal(damage)
    @health += damage
    @health = MAX_HEALTH if @health > MAX_HEALTH
  end

  def heal!
    begin
      if @health >0
        @health
      else
        raise DeadRobotError, 'Dead robots cannot be healed.'
      end
    rescue DeadRobotError => e
      puts e.message
    end

  end

  def attack(target)
    equipped_weapon ? range = equipped_weapon.range : range = DEFAULT_RANGE
    position_difference_y = self.position[1] - target.position[1]
    if position_difference_y.to_i.abs <= range
      if equipped_weapon
        equipped_weapon.hit(target)
        @equipped_weapon = nil if equipped_weapon.instance_of?(Grenade)
      else
        target.wound(DEFAULT_ATTACK)
      end
    else
      puts "Opponent is too far away to attack."
    end
  end

  # def attack(target) EXCEPTION PROJECT
  #   begin 
  #     if target.instance_of?(Robot) = true
  #       if equipped_weapon != nil
  #         equipped_weapon.hit(target)
  #       else
  #         target.wound(@default_attack_points)
  #       end
  #     else
  #       raise BadTargetError, 'Only robots can be attacked.'
  #     end
  #   rescue BadTargetError => e
  #     puts e.message
  #   end
  # end

  def wound(damage)
    if damage <= shields
      @shields -= damage
    else
      @health = (shields-damage)
      @shields = 0
      @health = [@health, MIN_HEALTH].max
    end
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end
  
  def move_down
    @position[1] -= 1
  end
end