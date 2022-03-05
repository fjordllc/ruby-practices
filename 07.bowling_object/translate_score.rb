class TranslateScore
  def initialize(input_from_command)
    @input_from_command = input_from_command
  end

  def translate_from_input_to_score
    base_scores = []
    @input_from_command.each do |value|
      if value == 'X'
        base_scores << 10
        base_scores << 0
      else
        base_scores << value.to_i
      end
    end
    base_scores
  end
end
