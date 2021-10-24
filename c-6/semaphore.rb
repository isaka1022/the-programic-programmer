case_semaphore.lock()

if display_case.pie_count > 0
  promise_pie_to_custoemr()
  display_case.take_pie()
  give_pie_to_customer()
end

case_semaphore.unlock()
