filepath = '.'
@fnames = Dir.glob("#{filepath}/*").map { |path| path.split('/')[-1] }

flength = @fnames.map(&:size).max
rows = 3
group_size = @fnames.size / rows + 1

fgroups = @fnames.map { |fname| fname.ljust(flength) }.each_slice(group_size).to_a

(0..group_size).each do |gs|
  (0..rows - 1).each do |row|
    print "#{fgroups[row][gs]} "
  end
  puts ''
end
