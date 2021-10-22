TRANSITIONS = {
  # current   new_state   action to take
  #---------------------------------------
  look_for_string: {
    '"' => [:in_string, :start_new_string],
    :default => [:look_for_string, :ignore]
  },

  in_string: {
    '"' => [:look_for_string, :finish_current_string],
    '\\' => [:copy_next_char, :add_current_string],
    :default => [:in_string, :add_current_to_string]
  },

  copy_next_char: {
    :default => [ :in_string, :add_current_to_string],
  }
}


state = :look_for_string
result = []

while ch = STDIN.getc
  state, action = TRANSITIONS[state][ch] || TRANSITIONS[state][:default]
  case action
  when :ignore
  when :start_new_string
    result = []
  when :add_current_to_string
    result << ch
  when :finish_current_string
    puts result.join
  end
end
