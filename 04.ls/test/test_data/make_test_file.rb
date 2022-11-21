20.times.each{|i| `touch #{i.to_s.rjust(2,'0')}_file -f`}
5.times.each do |i|
  dir = i.to_s.rjust(2,'0') + 'dir'
  `mkdir #{dir}`
  (20..25).each{|i| `touch ./#{dir}/#{i.to_s}_file`}
end
