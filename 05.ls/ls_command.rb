# frozen_string_literal: true

dir = []
if ARGV[1].nil?
  dir = '.'
elsif ARGV[1][0] == '-'
  dir = ARGV[2] || dir = '.'
elsif ARGV[1][0] == '/'
  dir = ARGV[1]
elsif ARGV[2][0] == '/'
  dir = ARGV[2]
else puts 'error 1'
end

def ls_current
  x = []
  Dir.glob('./*') do |f| # dir.globは表示のみ、後はnilで帰ってくる
    x << f.split('/')[-1]
  end
  if ARGV[1].nil?
    x.sort
  elsif ARGV[1][0] == '-' && ARGV[2].nil? # '/')
    x.sort
  end
end

def full_directory
  y = []
  dir = case ARGV[1][0]
        when '/'
          ARGV[1]
        when '-'
          ARGV[2]
        end
  dir = 'none' if dir.nil?

  Dir.glob("#{dir}/*") do |f|
    y << f.split('/')[-1]
  end

  if ARGV[1][0] == ('/')
    y.sort
  elsif (ARGV[1][0] == '-') || (ARGV[2][0] == '/')
    y.sort
  else
    puts 'error 2'
  end
end

# run
if ARGV[0] == 'ls' && ARGV[1].nil? # current directory
  ls_current
elsif (ARGV[0] == 'ls' && ARGV[1][0] == '/') || (ARGV[0] == 'ls' && ARGV[1] == dir) # stated directory
  full_directory
elsif (ARGV[0] == 'ls' && ARGV[2] == dir) || (ARGV[0] == 'ls' && ARGV[1] == dir)
  full_directory
elsif ARGV[0] == 'ls' && ARGV[1][0] == '-'
  ls_current
else puts ''
end

# formatting
def ls_method_current
  row1 = []
  row2 = []
  row3 = []
  row4 = []
  ls_current.each.with_index(1) do |n, idx|
    n += ' ' * [24 - n.length, 0].max
    case idx % 4
    when 0
      row4 << n
    when 1
      row1 << n
    when 2
      row2 << n
    when 3
      row3 << n
    end
  end

  if ARGV[1].nil?
    print row1.join(' ')
    puts ' '
    print row2.join(' ')
    puts ' '
    print row3.join(' ')
    puts ' '
    print row4.join(' ')
    puts ' '
  else
    [row1, row2, row3, row4].reverse
  end
end

def ls_method_full
  row1 = []
  row2 = []
  row3 = []
  row4 = []

  full_directory.each.with_index(1) do |n, idx|
    n += ' ' * [24 - n.length, 0].max
    case idx % 4
    when 0
      row4 << n
    when 1
      row1 << n
    when 2
      row2 << n
    when 3
      row3 << n
    end
  end

  if ARGV[2].nil?
    print row1.join(' ')
    puts ' '
    print row2.join(' ')
    puts ' '
    print row3.join(' ')
    puts ' '
    print row4.join(' ')
    puts ' '
  else
    [row1, row2, row3, row4]
  end
end

# adding options
require 'optparse'
opt = OptionParser.new

opt.on('-a', '--all', 'show all items') do # show all
  # files = ls_method_full #ARGV[2]
  # files = ls_method_current if ARGV[2] == '' #'.' if files == ''
  list = [] #-を含まない
  ARGV.each do |e|
    list.push e unless e[0] == '-'
  end

  if dir == '.' && ARGV[1][0] == '-'
    ls_current
  elsif dir[0] == '/' # ARGV[2][0] == '/'
    full_directory
  else
    puts 'error desune'
  end

  option_a = []
  z = ARGV[2]
  Dir.foreach(z) do |f|
    # puts f
    option_a << f
  end

  row1 = []
  row2 = []
  row3 = []
  row4 = []

  option_a.each.with_index(1) do |n, idx|
    n += ' ' * [18 - n.length, 0].max
    case idx % 4
    when 0
      row4 << n
    when 1
      row1 << n
    when 2
      row2 << n
    when 3
      row3 << n
    end
  end

  print row1.join(' ')
  puts ' '
  print row2.join(' ')
  puts ' '
  print row3.join(' ')
  puts ' '
  print row4.join(' ')
  puts ' '
end

opt.on('-r', '--reverse', 'reverse order of files') do # reverse
  if dir == '.'
    ls_method_current.each do |row|
      puts row.reverse.join(' ')
    end
  elsif ARGV[2][0] == '/'
    ls_method_full.each do |row|
      puts row.reverse.join(' ')
    end
  end
end

opt.on('-l', '--list', 'list in details') do # long list
  path = ARGV[2] # 引数を提示
  path = '.' if ARGV[2] == ''
  target_files = Dir.glob("#{path}/*") # 全てのディレクトリを表示する
  total_files = 0
  target_files.each do |a|
    total_files += File.stat(a).blocks
  end
  puts "Total #{total_files}"

  target_files.each do |target_file|
    fs = File::Stat.new(target_file) # ハードリンクの数
    permission = fs.mode.to_s(8) # octal value

    permission = format('%06d', permission)
    m = /(\d{2})(\d{1})(\d{1})(\d{1})(\d{1})/.match(permission)
    # directory
    t = m[1].to_i
    a = {
      0o1 => 'p',
      0o2 => 'cu',
      0o4 => 'd',
      0o6 => 'b',
      10 => '-',
      12 => 'l',
      14 => 's'
    }
    perm = a[t]
    # permission
    sample = ''
    permission_type = m[2], m[3], m[4], m[5]
    permission_type.each do |k| # 終わるまで何回も繰り返すよ～
      b = {
        '0' => '---',
        '1' => '--x',
        '2' => '-w-',
        '3' => '-wx',
        '4' => 'r--',
        '5' => 'r-x',
        '6' => 'rw-',
        '7' => 'rwx'
      }
      sample += b[k]
    end
    require 'etc'
    owner = Etc.getpwuid(fs.uid).name # owner name
    group = Etc.getgrgid(fs.gid).name # group name
    f_name = File.basename(target_file) # file name

    # output
    l_option = [perm, sample, ' ', fs.nlink, ' ', owner, ' ', group, ' ', fs.size, ' ', fs.mtime, ' ', f_name]
    puts l_option.join
  end
end
opt.parse(ARGV)

def ls_method_full_a
  row1 = []
  row2 = []
  row3 = []
  row4 = []

  # option a
  option_a.each.with_index(1) do |n, idx|
    n += ' ' * [24 - n.length, 0].max
    case idx % 4
    when 0
      row4 << n
    when 1
      row1 << n
    when 2
      row2 << n
    when 3
      row3 << n
    end
  end

  print row1.join(' ')
  puts ' '
  print row2.join(' ')
  puts ' '
  print row3.join(' ')
  puts ' '
  print row4.join(' ')
  puts ' '
end

# if dir == '.' && ARGV[1] == '-a'
#   puts ls_method_current_a
# elsif dir[0] == '/' && ARGV[1] == '-a'
#   puts ls_method_full_a

if dir == '.' && ARGV[1].nil?
  puts ls_method_current
elsif dir[0] == '/' && ARGV[2].nil?
  puts ls_method_full
end