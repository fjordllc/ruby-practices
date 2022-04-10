# frozen_string_literal: true

class Command
  attr_reader :l_option, :files

  def initialize(options, files)
    @l_option = options['l']
    @files = files
  end

  def ls
    if l_option
      total_blocks
      output_with_l_option
    else
      output_without_l_option
    end
  end

  private

  def total_blocks
    target_files = files.map { |file| file.last }
    block_count = 0
    target_files.each do |file|
      stat = File.lstat(file)
      block_count += stat.blocks
    end
    print "total #{block_count}\n"
  end

  def output_with_l_option
    files.each do |file|
      file.each.with_index do |value, index|
        suffix = "\n"
        case index
        when 0, 2, 3
          print "#{value}  "
        when file.length - 1
          print "#{value}#{suffix}"
        else
          print "#{value} "
        end
      end
    end
  end

  def output_without_l_option
    files.each do |file|
      file.each.with_index do |value, index|
        suffix = "\n"
        if index == 2
          print "#{value}#{suffix}"
        else
          print value.to_s
        end
      end
    end
  end
end
