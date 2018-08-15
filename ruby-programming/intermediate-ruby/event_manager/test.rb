require 'date'
def clean_phone_number(number)
  number = number.to_s.split('').select {|el| ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].include?(el)}.join('')

  if number.length == 11 && number[0] == '1'
    return number[1..-1]
  elsif number.length == 10
    return number
  else
    return '0000000000'
  end
end

def register_hour(regdate)
  dat = DateTime.strptime(regdate, "%m/%d/%y %k:%M")
  # dat.hour
end
dat = register_hour("4/2/09 1:29")
p dat.wday
# p dat.month

wdays = {0=> 'Sunday', 1=> 'Monday', 2=> 'Tuesday', 3=> 'Wednesday', 4=> 'Thursday', 5=> 'Friday', 6=> 'Saturday'}
puts wdays[dat.wday]
