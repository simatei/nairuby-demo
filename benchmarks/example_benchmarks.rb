require_relative '../lib/example_methods'
require 'benchmark/ips'

Benchmark.ips do |x|
  x.config(time: 5, warmup: 2)

  x.report("calculate_factorial") { ExampleMethods.calculate_factorial(10) }
  x.report("fibonacci") { ExampleMethods.fibonacci(20) }

  x.compare!
end
