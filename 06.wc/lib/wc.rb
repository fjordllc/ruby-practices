# frozen_string_literal: true

def main
  param = {}
  param[:options] = []
  param[:files] = []

  ARGV.each do |option|
    case option
    when /^-[a-zA-Z]+/
      param[:options] << option
    else
      param[:files] << option
    end
  end

  wc = WC.new(**param)
  wc.output_wc_results
end

class WC
  def initialize(param)
    @options = param[:options]
    @target_files = param[:files]
    @strings = obtain_target_strings(@target_files)
    @lines = []
    @word_count = []
    @bytesizes = obtain_bytesizes(@target_files)

    @strings.each do |string|
      @lines << string.length
      @word_count << string.map do |line|
        line.split(/[\s　]+/).length
      end.sum
    end

    return if @target_files.size <= 1

    @lines << @lines.sum
    @word_count << @word_count.sum
    @bytesizes << @bytesizes.sum
    @target_files << 'total'
  end

  def output_wc_results
    outputs = []
    outputs << @lines
    unless @options.grep(/l/).length >= 1
      outputs << @word_count
      outputs << @bytesizes
    end
    outputs << @target_files

    if @target_files.empty?
      puts outputs.join(' ')
    else
      formatted_outputs = outputs.map.with_index do |string, i|
        # 最後の列（ファイル名）以外は右揃えにする
        i == outputs.size - 1 ? string : fit_to_longest_item(string, right_aligned: true)
      end.transpose
      formatted_outputs.each { |item| puts item.join(' ') }
    end
  end

  private

  def obtain_target_strings(files)
    target_string = []
    if files.empty?
      target_string << $stdin.readlines
    else
      files.each do |file|
        target_string << File.new(file).readlines
      end
    end
    target_string
  end

  def obtain_bytesizes(files)
    bytesizes = []
    if files.empty?
      @strings.each do |string|
        bytesizes << string.join.bytesize
      end
    else
      files.each do |file|
        bytesizes << File.size(file)
      end
    end
    bytesizes
  end

  # 配列の各要素の長さを最大の要素の幅に合わせる（短い要素の末尾に半角スペースを追加する）
  # 引数：配列
  # 戻り値：最長の要素に合わせて各要素に半角スペースを追加した配列
  def fit_to_longest_item(items, right_aligned: false)
    longest_length = items.max_by { |item| item.to_s.length }.to_s.length
    items.map do |item|
      space_count = longest_length - item.to_s.length
      if space_count.positive?
        if right_aligned
          item.to_s.rjust(longest_length)
        else
          item.to_s.ljust(longest_length)
        end
      else
        item
      end
    end
  end
end

main
