require "date"
require "colorize"
# Data
id = 0
events = [
  { "id" => (id = id.next),
    "start_date" => "2022-05-12T00:00:00-05:00",
    "title" => "Ruby Basics 1",
    "end_date" => "",
    "notes" => "Ruby Basics 1 notes",
    "guests" => %w[Teddy Codeka],
    "calendar" => "tech" },
  { "id" => (id = id.next),
    "start_date" => "2022-05-12T12:00:00-05:00",
    "title" => "English Course",
    "end_date" => "2021-11-15T13:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2022-05-12T00:00:00-05:00",
    "title" => "Ruby Basics 2",
    "end_date" => "",
    "notes" => "Ruby Basics 2 notes",
    "guests" => %w[Andre Codeka],
    "calendar" => "tech" },
  { "id" => (id = id.next),
    "start_date" => "2022-05-14T12:45:00-05:00",
    "title" => "Soft Skills - Mindsets",
    "end_date" => "2021-11-15T13:30:00-05:00",
    "notes" => "Some extra notes",
    "guests" => ["Diego"],
    "calendar" => "soft-skills" },
  { "id" => (id = id.next),
    "start_date" => "2022-05-15T00:00:00-05:00",
    "title" => "Ruby Methods",
    "end_date" => "",
    "notes" => "Ruby Methods notes",
    "guests" => %w[Diego Andre Teddy Codeka],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2022-05-16T12:00:00-05:00",
    "title" => "English Course",
    "end_date" => "2021-11-15T13:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2021-11-18T09:00:00-05:00",
    "title" => "Summary Workshop",
    "end_date" => "2022-05-17T13:30:00-05:00",
    "notes" => "A lot of notes",
    "guests" => %w[Diego Teddy Andre Codeka],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2022-05-18T09:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2022-05-19T09:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2022-05-20T12:00:00-05:00",
    "title" => "English for Engineers",
    "end_date" => "2021-11-19T13:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2022-11-20T10:00:00-05:00",
    "title" => "Breakfast with my family",
    "end_date" => "2021-11-20T11:00:00-05:00",
    "notes" => "",
    "guests" => [],
    "calendar" => "default" },
  { "id" => (id = id.next),
    "start_date" => "2022-11-20T15:00:00-05:00",
    "title" => "Study",
    "end_date" => "2021-11-20T20:00:00-05:00",
    "notes" => "",
    "guests" => [],
    "calendar" => "default" },
  { "id" => (id = id.next),
    "start_date" => "2022-11-25T09:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2022-11-26T09:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" }
]

# Methods - Validaciones
def validate_date(date)
  y, m, d = date.split "-"
  valid = Date.valid_date?(y.to_i, m.to_i, d.to_i)
  until valid
    puts "Type a valid date: YYYY-MM-DD"
    print "Date: "
    date = gets.chomp
    y, m, d = date.split "-"
    valid = Date.valid_date?(y.to_i, m.to_i, d.to_i)
  end
  date
end

def validate_date_update(date)
  return date if date.empty?

  y, m, d = date.split "-"
  valid = Date.valid_date?(y.to_i, m.to_i, d.to_i)
  until valid
    puts "Type a valid date: YYYY-MM-DD"
    print "Date: "
    date = gets.chomp
    return date if date.empty?

    y, m, d = date.split "-"
    valid = Date.valid_date?(y.to_i, m.to_i, d.to_i)
  end
  date
end

def validate_title(title)
  while title.empty?
    puts "Cannot be blank"
    print "Title: "
    title = gets.chomp
  end
  title
end

def validate_startend_date_empty(start_end)
  valid = false
  valid = true if start_end.split.length <= 1

  while valid
    puts "Format: #{'HH:MM HH:MM'.light_red} or leave it empty"
    print "Start_end: "
    start_end = gets.chomp

    return start_end if start_end.empty?

    valid = false
    valid = true if start_end.split.length <= 1
  end
  start_end
end

def validate_end_date(start_end)
  start_end = validate_startend_date_empty(start_end)
  return start_end if start_end.empty?

  initial_hour, final_hour = start_end.split
  initial_hour_uno, final_hour_uno = initial_hour.split(":")
  initial_hour_dos, final_hour_dos = final_hour.split(":")

  valid_start_end = false
  valid_start_end = true if (initial_hour_uno.to_i >= initial_hour_dos.to_i && final_hour_uno.to_i > final_hour_dos.to_i)

  while valid_start_end
    puts "Cannot end before start"
    print "Start_end: "
    start_end = gets.chomp
    return start_end if start_end.empty?

    initial_hour, final_hour = start_end.split
    initial_hour_uno, final_hour_uno = initial_hour.split(":")
    initial_hour_dos, final_hour_dos = final_hour.split(":")

    valid_start_end = false
    valid_start_end = true if (initial_hour_uno.to_i >= initial_hour_dos.to_i && final_hour_uno.to_i > final_hour_dos.to_i)
  end

  [start_end, initial_hour, final_hour]
end

def validate_color(text)
  color = :white
  return color = :light_red if text == "tech"

  return color = :light_magenta if text == "english"

  return color = :green if text == "soft-skills"

  color
end

# Validar si el evento existe, para poder mostrarlo o actualizarlo
def validate_event(events, id)
  exist_event = events.find { |event| event["id"] == id }
  while exist_event.nil?
    puts "Id not exists"
    print "Event ID: "
    id = gets.to_i
    exist_event = events.find { |event| event["id"] == id }
  end
  id
end

# Methods
def print_calendary(array_calendary)
  puts ""
  array_calendary.each do |day|
    print DateTime.parse(day.keys[0]).strftime("%a %b %d")
    if day[day.keys[0]].length.zero?
      puts "#{' ' * 16} No events"
    else
      day[day.keys[0]].each do |event|
        color = validate_color(event["calendar"])
        if day[day.keys[0]].index(event).zero?
          if event["end_date"] == ""
            puts "#{' ' * 16} #{event['title']}  (#{event['id']})".colorize(color)
          else
            start_date = DateTime.parse(event["start_date"]).strftime("%H:%M") # Reducir a funcion
            end_date = DateTime.parse(event["end_date"]).strftime("%H:%M")
            puts "  #{start_date} - #{end_date}  #{event['title']}  (#{event['id']})".colorize(color)
          end
        else
          if event["end_date"] == ""
            puts "#{' ' * 26} #{event['title']}  (#{event['id']})".colorize(color)
          else
            start_date = DateTime.parse(event["start_date"]).strftime("%H:%M")
            end_date = DateTime.parse(event["end_date"]).strftime("%H:%M")
            puts "#{' ' * 11} #{start_date} - #{end_date}  #{event['title']}  (#{event['id']})".colorize(color)
          end
        end
      end
    end
    puts ""
  end
end

def list_calendary(events, date)
  puts "-----------------------------Welcome to CalenCLI------------------------------"
  year = date.year
  number_week = date.cweek
  wk_begin = Date.commercial(year, number_week, 1)
  wk_end = Date.commercial(year, number_week, 7)

  array_week = []
  (wk_begin..wk_end).each do |day|
    array_week.push(day)
  end

  array_new = []
  array_with_events = []

  array_week.each do |day| # 2022-05-09  2022-05-10  2022-05-11 ... 2022-05-15
    array_new = events.select { |event| Date.parse(event["start_date"].to_s) == day } # []
    array_with_events.push({
                             day.to_s => array_new
                           })
  end
  print_calendary(array_with_events)
end

def show_actions
  puts "------------------------------------------------------------------------------"
  puts "list | create | show | update | delete | next | prev | #{'exit'.light_green}"
end

#Método para crear evento
def create_event(events)
  print "Date: "
  date = gets.chomp
  date = validate_date(date)

  print "Title: "
  title = gets.chomp
  title = validate_title(title)

  print "Calendar: "
  calendar = gets.chomp.downcase.strip

  print "Start_end: "
  start_end = gets.chomp
  start_end.empty?
  _start_end, initial_hour, final_hour = validate_end_date(start_end)

  print "Notes: "
  notes = gets.chomp
  print "Guests: "
  guests = gets.chomp.split(",")

  # Optenemos el ultimo id del arreglo
  id = events[events.length - 1]["id"]

  new_event = {
    "id" => (id = id.next),
    "start_date" => DateTime.parse("#{date} #{initial_hour}-005:00").strftime("%Y-%m-%dT%l:%M:%S%z"),
    "title" => title,
    "end_date" => DateTime.parse("#{date} #{final_hour}-005:00").strftime("%Y-%m-%dT%l:%M:%S%z"),
    "notes" => notes,
    "guests" => guests,
    "calendar" => calendar
  }

  events << new_event
end

def show_event(events, id)
  event = events.find { |item| item["id"] == id }
  # Obtener el start_end
  start_end = ""
  if event["end_date"] != ""
    initial_hour = DateTime.parse(event["start_date"]).strftime("%H:%M")
    final_hour = DateTime.parse(event["end_date"]).strftime("%H:%M")
    start_end = "#{initial_hour} - #{final_hour}"
  end

  puts "Date: #{DateTime.parse(event['start_date']).strftime('%Y-%m-%d')}"
  puts "Title: #{event['title']}"
  puts "Calendar: #{event['calendar']}"
  puts "Start End: #{start_end}"
  puts "Notes: #{event['notes']}"
  puts "Guests: #{event['guests'].join(', ')}"
end

def update_event(events, id)
  event = events.find { |item| item["id"] == id }

  print "Date: "
  date = gets.chomp
  date = validate_date_update(date).empty? ? event["start_date"] : validate_date_update(date)

  print "Title: "
  title = gets.chomp
  title = title.empty? ? event["title"] : title

  print "Calendar: "
  calendar = gets.chomp.downcase.strip
  calendar = calendar.empty? ? event["calendar"] : calendar

  print "Start_end: "
  start_end = gets.chomp

  if start_end.empty?
    _start_end = event["end_date"]
  elsif validate_end_date(start_end).empty?
    _start_end = ""
  else
    _start_end, initial_hour, final_hour = validate_end_date(start_end)
  end

  print "Notes: "
  notes = gets.chomp
  print "Guests: "
  guests = gets.chomp.split(",")

  if initial_hour.nil?
    initial_hour = DateTime.parse(date).strftime("%l:%M")
    end_date = event["end_date"]
  else
    date = DateTime.parse(date).strftime("%Y-%m-%d")
    end_date = DateTime.parse("#{date} #{final_hour}-005:00").strftime("%Y-%m-%dT%l:%M:%S%z")
  end

  start_date = DateTime.parse("#{date} #{initial_hour}-005:00").strftime("%Y-%m-%dT%l:%M:%S%z")

  new_event = {
    "id" => id,
    "start_date" => start_date,
    "title" => title,
    "end_date" => end_date,
    "notes" => notes,
    "guests" => guests,
    "calendar" => calendar
  }

  events.map! do |item|
    if item["id"] == id
      new_event
    else
      item
    end
  end
end

def delete_event(events, id)
  events.delete_if { |event| event["id"] == id }
end

# Main Program
current_day = Date.today

list_calendary(events, current_day)
show_actions
action = nil
while action != "exit"
  puts ""
  print "action: "
  action = gets.chomp.downcase.strip
  case action
  when "list"
    current_day = Date.today
    list_calendary(events, current_day)
    show_actions
  when "create"
    create_event(events)
    show_actions
  when "show"
    print "Event ID: "
    id = gets.to_i
    id = validate_event(events, id)
    show_event(events, id)
    show_actions
  when "update"
    print "Event ID: "
    id = gets.to_i
    id = validate_event(events, id)
    update_event(events, id)
    show_actions
  when "delete"
    print "Event ID: "
    id = gets.to_i
    id = validate_event(events, id)
    delete_event(events, id)
    show_actions
  when "next"
    current_day += 7
    list_calendary(events, current_day)
    show_actions
  when "prev"
    current_day -= 7
    list_calendary(events, current_day)
    show_actions
  when "exit" then puts "Thanks #{'for'.blue} using calenCLI"
  else
    puts "You entered an invalid option"
  end
end
