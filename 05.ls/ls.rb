require 'minitest/autorun' 

class Column
  attr_accessor :max_name_size, :files, :name
  def initialize
    @files = []
    @max_name_size = 0
  end
end
NUMBER_OF_COLUMNS = 3
def ls
  files_directories = Dir.glob('*')
  number_of_files_in_a_column = files_directories.size / NUMBER_OF_COLUMNS
  number_of_files_in_a_column += 1 unless (files_directories.size % NUMBER_OF_COLUMNS).zero?

  first  = Column.new
  second = Column.new
  third  = Column.new

  files_directories.each_with_index do |file, i|
    if i / number_of_files_in_a_column == 0
      p first.files
      first.files << file
      first.max_name_size = file.size if first.max_name_size < file.size
    elsif i / number_of_files_in_a_column == 1
      second.files << file
      second.max_name_size = file.size if second.max_name_size < file.size
    else
      third.files << file      
      third.max_name_size = file.size if third.max_name_size < file.size
    end
  end

  ans = []
  number_of_files_in_a_column.times do |o|
    tmp = []
    tmp << first[o].ljust(first_max_length) if first[o]
    tmp << second[o].ljust(second_max_length) if second[o]
    tmp << third[o].ljust(third_max_length) if third[o]
    puts tmp.join('   ')
    ans << tmp.join('   ')
  end
  ans.join("\n")
end


class LsTest < Minitest::Test
  def test_1
    output1=<<~TEXT
    ls.rb           practiceE.txt   practiceJ.txt
    practiceA.txt   practiceF.txt   practiceK.txt
    practiceB.txt   practiceG.txt   practiceL.txt
    practiceC.txt   practiceH.txt   practiceM.txt
    practiceD.txt   practiceI.txt
    TEXT
    assert_equal output1, ls
  end
end
