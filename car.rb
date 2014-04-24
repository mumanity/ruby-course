class Car
  attr_accessor :color, :wheel_count, :count, :color_count, :color
  @@color_count = Hash.new(0)

  def initialize(color, wheel_count=4)
    @color = color
    @wheel_count = wheel_count
  end

  def honk
    'meep'
  end
end

class BigRig < Car

  def initialize(color)
    super(color)
    @wheel_count=18
  end

  def honk
    'BBBBBRRRRRRAAAAAWWWHHHHH'
  end
end

class Motorcycle < Car

  def initialize(color='red')
    super(color, 2)
  end

end

class CarStats < Car
  attr_accessor :top_color, :top_count, :bottom_color, :bottom_count

  def self.calc_top_color(whut)
    @top_color = ''
    @top_count = 0
    whut.each do |x|
    @@color_count[x.color] += 1
    end
    @@color_count.each do |key, value|
      if value > @top_count
        @top_count = value
        @top_color = key
      end
    end
    @top_color
  end

  def self.calc_bottom_color(whut)
    @bottom_color = ''
    @bottom_count = @top_count
    whut.each do |x|
    @@color_count[x.color] += 1
    end
    @@color_count.each do |key, value|
      if value < @bottom_count
        @bottom_count = value
        @bottom_color = key
      end
    end
    @bottom_color
  end

end



