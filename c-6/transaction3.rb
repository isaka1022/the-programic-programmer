slice = display_case.get_pie_if_available()
scoop = freezer.get_ice_cream_if_available()

# 陳列ケースと合わせてアイスクリームが利用可能か調べる
if slice && scoop
  give_order_to_customer()
end


def get_pie_if_available()
  @case_semaphore.lock()

  try {
    if @slices.size > 0
      update_sales_data(:pie)
      return @slices.shift
    else
      false
    end
  }
  ensure {
    @case_semaphore.unlock()
  }

end
