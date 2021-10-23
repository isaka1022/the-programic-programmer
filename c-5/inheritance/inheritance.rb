class Vehicle
  def initialize
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def move_at(speed)
    @speed = speed
  end
end

class Car < Vehicle
  def info
    "I'm car driving at #{@speed}"
  end
end


# top-level code
my_ride = Car.new
my_ride.move_at(30)
