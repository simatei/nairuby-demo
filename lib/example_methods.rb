class ExampleMethods
  def self.calculate_factorial(number)
    (1..number).inject(:*) || 1
  end

  def self.fibonacci(number)
    return number if number <= 1
    fibonacci(number - 1) + fibonacci(number - 2)
  end
end
