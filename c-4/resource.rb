# 悪い例

def read_customer(file)
  @balance = BigDecimal(file.gets)
end

def write_customer(file)
  @customer_file.rewind
  @customer_file.puts @balance.to_s
end

def update_customer(transaction_amount)
  file = file.open(@name + '.rec', 'r+')
  read_customer(file)
  @balance = @balance.add(transaction_amount, 2)
  write_customer(file)
  file.close
end
