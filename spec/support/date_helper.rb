def humanized_date(date)
  date.strftime('%Y-%m-%d') #year/month/day
end

def random_date
  rand(1.week.ago..Time.now).strftime('%Y-%m-%d')
end