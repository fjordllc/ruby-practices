# frozen_string_literal: true

module OptparseConditions
  def opt_has_two_numbers?(argv, opt_index_num)
    (/^\d+$/ === argv[opt_index_num + 1].to_s && /^\d+$/ === argv[opt_index_num.to_i + 2].to_s)
  end

  def opt_has_one_number?(argv, opt_index_num)
    (/^\d+$/ === argv[opt_index_num + 1].to_s)
  end

  def correct_month?(argv, index_num)
    argv[index_num].to_i.between?(1, 12)
  end

  def correct_year?(argv, index_num)
    argv[index_num].to_i.between?(1, 9999)
  end

  def opt_has_no_num?(argv, opt_index_num)
    /^\D+$/ === argv[opt_index_num + 1] || argv[opt_index_num + 1].nil?
  end

  def some_opt_after_this_opt?(argv, index_num)
    /^\D+$/ === argv[index_num + 1]
  end

  def argv_has_conflicting_opt?(argv, conflicting_opt_list)
    conflicting_opt = argv & conflicting_opt_list
    !conflicting_opt.empty?
  end
end
