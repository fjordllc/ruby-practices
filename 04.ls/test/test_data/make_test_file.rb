# frozen_string_literal: true

20.times.each { |i| `touch #{i.to_s.rjust(2, '0')}_file -f` }
5.times.each do |i|
  dir = "#{i.to_s.rjust(2, '0')}#{dir}"
  `mkdir #{dir}`
  (20..25).each { |index| `touch ./#{dir}/#{index}_file` }
end
