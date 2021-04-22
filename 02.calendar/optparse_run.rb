# frozen_string_literal: true

require 'optparse'
require 'date'
require './optparse_conditions'

class OptparseRun
  include OptparseConditions

  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(keys)
    @keys = keys
    @keys_result = keys
  end

  def optparse_run
    argv_parser = OptionParser.new
    argv = Marshal.load(Marshal.dump(ARGV))

    begin
      argv_parser_on_y(argv_parser, argv)
      argv_parser_on_m(argv_parser, argv)
      argv_parser_on_3(argv_parser, argv)
      argv_parser_on_A(argv_parser, argv)
      argv_parser_on_B(argv_parser, argv)
      argv_parser_on_j(argv_parser, argv)
      argv_parser_on_h(argv_parser, argv)

      argv_parser.parse(argv)

      argv_parser_on_no_opt(argv)
    rescue NoMethodError
      puts 'エラークラス: NoMethodError'
      puts 'そのオプションは無効です'
      exit
    rescue OptionParser::InvalidOption
      puts 'エラークラス: OptionParser::InvalidOption'
      puts 'そのオプションは無効です'
      exit
    rescue OptionParser::MissingArgument
      puts 'エラークラス: OptionParser::MissingArgument'
      puts 'オプションに引数を与えてください'
      exit
    rescue
      puts 'エラークラス: 不明'
      puts 'そのオプションは無効です'
      exit
    end
    @keys_result
  end

  private

  def argv_parser_on_y(argv_parser, argv)
    argv_parser.on('-y [VAL]') do |v|
      index = argv.find_index('-y')
      case
      when opt_has_one_number?(argv, index) && !correct_year?(argv, index + 1)
        puts '年は1から9999の間で入力してください'
        exit
      when opt_has_two_numbers?(argv, index)
        puts '月を入力することはできません'
        exit
      end

      case
      when opt_has_one_number?(argv, index) && correct_year?(argv, index + 1)
        @keys_result[:next_month] = 11
        @keys_result[:basic_month] = 1
        @keys_result[:basic_year] = v.to_i
      when opt_has_no_num?(argv, index)
        @keys_result[:next_month] = 11
        @keys_result[:basic_month] = 1
        @keys_result[:basic_year] = THIS_Y
      end
      @keys_result[:year_position] = 'header'
    end
  end

  def argv_parser_on_m(argv_parser, argv)
    argv_parser.on('-m VAL') do |v|
      index = argv.find_index('-m')
      case
      when some_opt_after_this_opt?(argv, index) || opt_has_no_num?(argv, index)
        puts '-mオプションの直後には月を入力してください'
        exit
      when opt_has_one_number?(argv, index) && !correct_month?(argv, index + 1)
        puts '月は1から12の間で入力してください'
        exit
      when opt_has_two_numbers?(argv, index) && !correct_year?(argv, index + 2)
        puts '年は1から9999の間で入力してください'
        exit
      end

      case
      when opt_has_two_numbers?(argv, index) && correct_month?(argv, index + 1) && correct_year?(argv, index + 2)
        @keys_result[:basic_month] = argv[index + 1].to_i
        @keys_result[:basic_year] = argv[index + 2].to_i
        argv.delete_at(index + 2)
        argv.delete_at(index + 1)
        argv.delete_at(index)
      when opt_has_one_number?(argv, index) && correct_month?(argv, index + 1)
        @keys_result[:basic_month] = argv[index + 1].to_i
        @keys_result[:basic_year] = THIS_Y
        argv.delete_at(index + 1)
        argv.delete_at(index)
      end
    end
  end

  def argv_parser_on_3(argv_parser, argv)
    argv_parser.on('-3') do |v|
      index = argv.find_index('-3')
      @conflicting_opt_list = ['-y', '-A', '-B']
      @keys_result[:pre_month] = 1
      @keys_result[:next_month] = 1

      case
      when opt_has_two_numbers?(argv, index) && !correct_month?(argv, index + 1)
        puts '月は1から12の間で入力してください'
        exit
      when argv_has_conflicting_opt?(argv, @conflicting_opt_list)
        puts 'これらのオプションは同時に使えません'
        exit
      when opt_has_one_number?(argv, index) && !opt_has_two_numbers?(argv, index)
        puts '年を入力してください'
        exit
      end

      case
      when opt_has_two_numbers?(argv, index) && correct_month?(argv, index + 1) && correct_year?(argv, index + 2)
        @keys_result[:basic_month] = argv[index + 1].to_i
        @keys_result[:basic_year] = argv[index + 2].to_i
        @keys_result[:pre_month] = 1
        @keys_result[:next_month] = 1
        argv.delete_at(index + 2)
        argv.delete_at(index + 1)
        argv.delete_at(index)
      when opt_has_no_num?(argv, index)
        @keys_result[:basic_month] = THIS_M
        @keys_result[:basic_year] = THIS_Y
        @keys_result[:pre_month] = 1
        @keys_result[:next_month] = 1
        argv.delete_at(index)
      end
    end
  end

  def argv_parser_on_A(argv_parser, argv)
    argv_parser.on('-A VAL') do |v|
      index = argv.find_index('-A')
      case
      when !opt_has_one_number?(argv, index)
        puts 'オプションの後ろに何ヶ月先まで表示するか入力してください'
        exit
      end

      case
      when opt_has_one_number?(argv, index)
        @keys_result[:next_month] = v.to_i
        argv.delete_at(index + 1)
        argv.delete_at(index)
      end
      @keys_result[:next_month] = v.to_i
    end
  end

  def argv_parser_on_B(argv_parser, argv)
    argv_parser.on('-B VAL') do |v|
      index = argv.find_index('-B')
      case
      when !opt_has_one_number?(argv, index)
        puts 'オプションの後ろに何ヶ月前まで表示するか入力してください'
        exit
      end

      case
      when opt_has_one_number?(argv, index)
        @keys_result[:pre_month] = v.to_i
        argv.delete_at(index + 1)
        argv.delete_at(index)
      end
      @keys_result[:pre_month] = v.to_i
    end
  end

  def argv_parser_on_j(argv_parser, argv)
    argv_parser.on('-j') do | v |
      index = argv.find_index('-j')
      @keys_result[:julius] = true
      argv.delete_at(index)
    end
  end

  def argv_parser_on_h(argv_parser, argv)
    argv_parser.on('-h') do |v|
      index = argv.find_index('-h')
      @keys_result[:highligth] = false
      argv.delete_at(index)
    end
  end

  def argv_parser_on_no_opt(argv)
    case
    when argv.size == 2 && /\d{1,2}/ === argv[0] && /\d{1,4}/ === argv[1] && correct_month?(argv, 0) && !correct_year?(argv, 1)
      puts '年は1から9999の間で入力してください'
      exit
    when argv.size == 2 && /\d{1,2}/ === argv[0] && /\d{1,4}/ === argv[1] && !correct_month?(argv, 0) && correct_year?(argv, 1)
      puts '月は1から12の間で入力してください'
      exit
    when argv.size == 1 && /\d{1,4}/ === argv[0] && !correct_year?(argv, 0)
      puts '年は1から9999の間で入力してください'
      exit
    end

    case
    when argv.size == 2 && /\d{1,2}/ === argv[0] && /\d{1,4}/ === argv[1] && correct_month?(argv, 0) && correct_year?(argv, 1)
      @keys_result[:basic_month] = argv[0].to_i
      @keys_result[:basic_year] = argv[1].to_i
    when argv.size == 1 && /\d{1,4}/ === argv[0] && correct_year?(argv, 0)
      @keys_result[:basic_year] = argv[0].to_i
    end
  end
end
