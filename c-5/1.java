public void applyDiscount(customer, order_id, discount) {
  // 顧客オブジェクトがorders,、find, getTotalsがあることを知っておかなければならない
  totals = customer
            .oreders
            .find(order_id)
            .getTotals();
  // 合計額のセッターも有している？
  totals.grandTotal = totals.grandTotal - discount
  // 割引額のセッターも有している?
  totals.discount = discount;
}


// 総額を管理するオブジェクトに割引額の処理を移譲する
public void applyDiscount(customer, order_id, discount) {
  customer
    .oreders
    .find(order_id)
    .getTotals()
    .applyDiscount(discount);
}


// 顧客オブジェクトから必要な注文を直接取り出すs
public void applyDiscount(customer, order_id, discount) {
  customer
    .findOrder(order_id)
    .getTotals()
    .applyDiscount(discount);
}

// 注文がその合計を格納するために別なオブジェクトを使用しているという実装を知っておくべきではない
public void applyDiscount(customer, order_id, discount) {
  customer
    .findOrder(order_id)
    .applyDiscount(discount)
}
