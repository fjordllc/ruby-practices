# frozen_string_literal: true

class FileDetailsList
  def initialize(dir)
    @dir = dir
  end

  def array_containing_file_details
    [
      @dir.map(&:file_type_and_permission),
      @dir.map(&:number_of_hard_links),
      @dir.map(&:owner_name),
      @dir.map(&:group_name),
      @dir.map(&:file_size),
      @dir.map(&:final_update_time),
      @dir.map(&:file_name)
    ].transpose
  end

  def array_containing_maximum_number_of_words
    [
      @dir.map { |file| file.number_of_hard_links.to_s.size }.max,
      @dir.map { |file| file.owner_name.size }.max,
      @dir.map { |file| file.group_name.size }.max,
      @dir.map { |file| file.file_size.to_s.size }.max,
      @dir.map { |file| file.final_update_time.size }.max,
      @dir.map { |file| file.file_name.size }.max
    ]
  end

  def total_number_of_blocks
    @dir.map(&:number_of_blocks).sum
  end

  def output_file_details_list
    puts "total #{total_number_of_blocks}"
    array_containing_file_details.each do |file_details|
      print "#{file_details[0]}  "
      print "#{file_details[1].to_s.rjust(array_containing_maximum_number_of_words[0])} "
      print "#{file_details[2].to_s.ljust(array_containing_maximum_number_of_words[1])}  "
      print "#{file_details[3].to_s.ljust(array_containing_maximum_number_of_words[2])}  "
      print "#{file_details[4].to_s.rjust(array_containing_maximum_number_of_words[3])}  "
      print "#{file_details[5].to_s.rjust(array_containing_maximum_number_of_words[4])} "
      print file_details[6].to_s.ljust(array_containing_maximum_number_of_words[5])
      print "\n"
    end
  end
end
