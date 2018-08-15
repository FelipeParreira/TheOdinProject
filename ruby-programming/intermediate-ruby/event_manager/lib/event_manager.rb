require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

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
  hour = dat.hour.to_s
  wday = dat.wday
  hours_relation ||= Hash.new(0)
  wday_relation ||= Hash.new(0)
  hours_relation[hour] += 1
  wday_relation[wday] += 1
  return dat
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  phone_number = clean_phone_number(row[:homephone])

  reg_date = register_hour(row[:regdate])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)

end

copy_hours_relation = hours_relation
max_hours = []
3.times do
  k = copy_hours_relation.key(copy_hours_relation.values.max)
  max_hours.push(k)
  copy_hours_relation.delete(k)
end

wdays = {0 => 'Sunday', 1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday', 4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday'}
max_wday = wdays[wday_relation.key(wday_relation.values.max)]
