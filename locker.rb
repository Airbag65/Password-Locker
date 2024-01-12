require 'date'
require 'json'

class Locker
  attr_accessor :current_date, :json_data, :json_filepath

  def initialize
    self.current_date = Date.parse(Time.now.strftime("%Y-%m-%d"))
    self.json_filepath = "locker.json"
    self.json_data = JSON.parse(File.read(self.json_filepath))
  end

  def load_data
    self.json_data = JSON.parse(File.read(self.json_filepath))
  end

  def list_platforms
    load_data
    if self.json_data.empty?
      puts "\nYou have no saved passwords"
    else
      puts "\nYou have saved passwords for:"
      self.json_data.each do |key, item|
        puts "---#{key}---"
      end
    end
    puts ""
  end


  def write_content
    File.open(self.json_filepath, "w") do |file|
      JSON.dump(self.json_data, file)
    end
  end

  def create_password(key, value)
    load_data
    if self.json_data[key]
      puts "\nThere's already a password saved for: '#{key}'"
      puts "Do you want to override it with a new generated password? [Y/N]"
      choice = gets.chomp
      if choice.upcase == "N"
        return nil
      elsif choice.upcase != "Y"
        return nil
      end
    end
    new_pass = {
      "unlock_date" => self.current_date+5,
      "password" => value
    }
    self.json_data[key] = new_pass
    write_content
  end

  def retrieve_password(key)
    load_data
    if self.json_data[key] == nil
      puts "---No password saved for '#{key}'---"
      return nil
    end
    unlock_date = self.json_data[key]["unlock_date"].to_s
    if unlock_date != self.current_date.to_s
      puts "---You will have to wait until '#{unlock_date}' to retrieve the password for '#{key}'---"
      return nil
    end
    puts "---The password for '#{key}' is: #{self.json_data[key]["password"]} ---"
  end
end
