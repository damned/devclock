require 'listen'
require 'fileutils'

def snapshots_dir
  './snapshots/'
end

FileUtils.mkdir_p snapshots_dir

def changed(change, f)
  puts "#{Time.now},#{change},#{f}"
  puts `time cp #{f} "#{snapshots_dir}#{File.basename(f)}.#{Time.now.to_i}"`
end

listener = Listen.to(*ARGV.to_a) do |modified, added, removed|
  modified.each {|f| changed :modified, f}
  added.each {|f| changed :added, f}
  removed.each {|f| changed :removed, f}
end
listener.start # not blocking
sleep

