$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'tdms'

filename = File.dirname(__FILE__) + "/test/fixtures/example.tdms"
doc = Tdms::File.parse(filename)

ch1 = doc.channels.find {|c| c.name == "StatisticsText"}
ch2 = doc.channels.find {|c| c.name == "Res_Noise_1"}

last = [ch1.values.size, ch2.values.size].min - 1

puts "#{ch1.name},#{ch2.name}"
0.upto(last) do |i|
  puts "#{ch1.values[i]},#{ch2.values[i]}"
end
