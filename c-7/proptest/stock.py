class Warehouse:
    def __init__(self, stock):
        self.stock = stock
    
    def in_stock(self, item_name):
        return (item_name in self.stock) and (self.stock[item_name] > 0)

    def take_from_stock(self,item_name, quantity):
        if quantity <= self.stock[item_name]:
            self.stock[item_name] -= quantity
        else:
            raise Exception("Oversold {}").format(item_name)

    def stock_count(self, item_name):
        return self.stock[item_name]
