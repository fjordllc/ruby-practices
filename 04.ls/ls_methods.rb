class LsMethods
  def initialize(path = '.')
    @all_contents = Dir.entries(path)
  end

  def ls_without_any_options
    filtered_contents = @all_contents.filter { |content| content !~ /^\..*$/ }
    show_ls(filtered_contents)
  end

  def show_ls(contents)
    height = (contents.length / 3.0).ceil
    # 行のナンバリング
    (0...height).each do |h_num|
      # 列のナンバリング
      3.times do |w_num|
        contents_index = h_num + (height * w_num)
        print "#{contents[contents_index]}".ljust(20) if !contents[contents_index].nil? # rubocop:disable all
      end
      puts
    end
    nil
  end
end
