slice = display_case.get_pie_if_available()

if slice
  try {
    scoop = freezer.get_ice_cream_if_available()
    try {
      give_order_to_customer()
    }
    rescue {
      freezer.give_back()
    }
    end
  }
  rescue {
    display_case.give_back(slice)
  }
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
