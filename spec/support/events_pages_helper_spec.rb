def fill_event_name_date(name: 'testEvent', date: Date.tomorrow)
  fill_in 'Name', with: name
  fill_in 'Date', with: date.to_s
end