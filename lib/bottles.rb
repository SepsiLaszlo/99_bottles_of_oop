class Bottles
  def song
    verses(99, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).map { |i| verse(i) }.join("\n")
  end

  def verse(number)
    bottle_number = BottleNumber.for(number)
    next_bottle_number = bottle_number.successor

    "#{bottle_number}".capitalize + " of beer on the wall, " +
    "#{bottle_number} of beer.\n" +
    "#{bottle_number.action}, " +
    "#{next_bottle_number} of beer on the wall.\n"
  end
end

class BottleNumber
  attr_accessor :number
  def initialize(number)
    @number = number
  end

  def self.for(number)
    begin
      const_get("BottleNumber#{number}")
    rescue NameError
      BottleNumber
    end.new(number)
  end

  def to_s
    "#{quantity} #{container}"
  end

  def successor
    BottleNumber.for(number - 1)
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def container
    "bottles"
  end

  def pronoun
    "one"
  end

  def quantity
    number.to_s
  end
end

class BottleNumber0 < BottleNumber
  def successor
    BottleNumber.for(99)
  end

  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more"
  end
end

class BottleNumber1 < BottleNumber
  def pronoun
    "it"
  end

  def container
    "bottle"
  end
end
