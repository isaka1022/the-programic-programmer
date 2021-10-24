mixin CommonFinders {
  def find (id) { ... }
  def findAll() { ... }
}


class AccoundRecord extends BasicRecord with CommonFinders
class OrderRecord extends BasicRecord with CommonFinders
