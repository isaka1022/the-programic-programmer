# 悪い例

def read_customer(file)
  @balance = BigDecimal(file.gets)
end

def write_customer(file)
  @customer_file.rewind
  @customer_file.puts @balance.to_s
end

# 始めた場所で作業が終わる
# ブロックの終端でファイルがクローズされる
def update_customer(transaction_amount)
  File.open(@name + '.rec', 'r+') do |file|
    read_customer(file)
    @balance = @balance.add(transaction_amount, 2)
    write_customer(file)
  end
end
