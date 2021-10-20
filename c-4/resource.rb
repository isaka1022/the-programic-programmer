# 悪い例

def read_customer
  @cusotomer_file = File.open(@name + ".rec" + "r+")
  @balance = BigDecimal(@customer_file.gets)
end

def write_customer
  @customer_file.rewind
  @customer_file.puts @balance.to_s
  @customer_file.close
end

def update_customer(transaction_amount)
  read_customer
  @balance = @balance.add(transaction_amount, 2)
  write_customer
end

# customer_fileというインスタンス変数により緊密に結合

# 残高の更新を更新後の値が負でない場合にのみ行うようにする
# オープンしているファイルの数が多すぎる：wirte_customerが呼ばれないのでファイルがクローズされない
def update_customer(transaction_amount)
  read_customer
  if (transaction_amount >= 0.00)
    @balance = @balance.add(transaction_amount, 2)
    write_customer
  end
end
