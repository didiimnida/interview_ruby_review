module Inventoryable

  def self.included(klass)
    klass.extend(ClassMethods)
    klass.extend(Enumerable)
  end

  module ClassMethods
    def create(attributes)
      object = new(attributes)
      instances.push(object)
      return object
    end

    def instances
      @instances ||= []
    end

    def each(&block)
      instances.each(&block)
    end

    def in_stock_report
      puts "#{self.to_s} In Stock Report"
      reportable = instances.select{ |instance| instance.in_stock? }
      reportable.each do |item|
        line = []
        line.push("Item: #{item.attributes[:name]}")
        line.push("Stock: #{item.stock_count}")
        if item.attributes.include?(:size)
          line.push("Size: #{item.attributes[:size]}")
        end
        puts line.join("\t")
      end
      puts "\n"
    end
  end

  def stock_count
    @stock_count ||= 0
  end

  def stock_count=(number)
    @stock_count = number
  end

  def in_stock?
    @stock_count != 0
  end

end

class Shirt
  include Inventoryable
  # extend Inventoryable::ClassMethods
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

class Pant
  include Inventoryable
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

class Accessory
  include Inventoryable
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

shirt = Shirt.create(name: "MTF", size: "L")
shirt.stock_count = 10

shirt = Shirt.create(name: "MTF2", size: "L")

shirt = Shirt.create(name: "MTF", size: "M")
shirt.stock_count = 9

pant = Pant.create(name: "Jeans", size: "M")
pant.stock_count = 2

pant = Pant.create(name: "Jeans", size: "S")
pant.stock_count = 4

accessory = Accessory.create(name: "Belt", size: "M")
accessory.stock_count = 1

accessory = Accessory.create(name: "Belt", size: "L")
accessory.stock_count = 1

accessory = Accessory.create(name: "Necklace")
accessory.stock_count = 1

Shirt.in_stock_report
Pant.in_stock_report
Accessory.in_stock_report

# puts Shirt.instances.inspect

# puts "Shirt 1 stock count: %s" % shirt1.stock_count
# puts "Shirt 2 stock count: %s" % shirt2.stock_count
# puts "Shirt 1 stock count: %s" % shirt1.in_stock?
# puts "Shirt 2 stock count: %s" % shirt2.in_stock?
