current_pass = Dir.getwd 
files = Dir.glob('*').sort

blocks_total = []
files.each do |file|
  pass = current_pass + '/' + file
  stat = File.stat(pass)
  blocks = stat.blocks
  blocks_total << blocks
end

p blocks_total.sum

