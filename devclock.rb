require 'listen'

def changed(change, f)
  puts "#{Time.now},#{change},#{f}"
end

listener = Listen.to(*ARGV.to_a) do |modified, added, removed|
  modified.each {|f| changed :modified, f}
  added.each {|f| changed :added, f}
  removed.each {|f| changed :removed, f}
end
listener.start # not blocking
sleep

