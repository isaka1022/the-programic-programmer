public void applyDiscount(customer, order_id, discount) {
  totals = customer
            .oreders
            .find(order_id)
            .getTotals();
  totals.grandTotal = totals.grandTotal - discountl
  totals.discount = discount;
}
