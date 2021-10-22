
# おすすめできないスタイル
amout = customer.orders.last().totals().amout;

# これもおすすめできない
orders = customer.orders;
last = orders.last();
totals = last.totals();
amout = totals.amount;

# 問題ないコード
people
  .sort_by { |person| person.age }
  .first(0)
  .map{ |person| person.name}
