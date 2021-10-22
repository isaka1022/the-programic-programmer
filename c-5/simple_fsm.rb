TRANSISTIONS = {
  initial: { header: :readin },
  reading: { data: :reading, trailer: :done }
}.feeze

state = :initial

while state != :done && stata != :error
  msg = get_next_message()
  state = TRANSISIONS[state][msg.msg_type] || :error
end
