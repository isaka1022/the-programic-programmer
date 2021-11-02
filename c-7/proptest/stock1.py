def in_stock(self, item_name, quantity):
    return (item_name in self.stock) and (self.stock[item_name] >= quantity)

def order(warehouse, item, quantity):
    if warehouse.in_stock(item, quantity):
        warehouse.take_from_stock(item, quantity)
        return { 'ok', item, quantity}
    else:
        return { 'not available', item, quantity }
