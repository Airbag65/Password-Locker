require 'date'
require 'json'
require_relative 'generator'

class Locker
  attr_accessor :current_date, :json_data, :json_filepath

  def initialize
    self.current_date = Date.parse(Time.now.strftime("%Y-%m-%d"))
    self.json_filepath = "locker.json"
    @json_data = JSON.parse(File.read(@json_filepath))
  end

  def load_data
    @json_data = JSON.parse(File.read(@json_filepath))
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
    load_data
  end

  def create_password(key)
    load_data
    generator = Generator.new(15)
    if self.json_data[key]
      puts "\nThere's already a password saved for: '#{key}'"
      puts "Do you want to override it with a new generated password? [Y/N]"
      choice = gets.chomp
      if choice.upcase == "N"
        return nil
      elsif choice.upcase != "Y"
        new_pass = {
          "unlock_date" => self.current_date+5,
          "password" => generator.generate_password
        }
        @json_data[key] = new_pass
        puts "---Created new password for #{key}---\n\n"
        write_content
        return nil
      end
    end
    new_pass = {
      "unlock_date" => self.current_date+5,
      "password" => generator.generate_password
    }
    @json_data[key] = new_pass
    puts "---Created new password for #{key}---\n\n"
    write_content
  end


  def delete_password(key)
    load_data
    if @json_data[key] == nil
      puts "---No password for '#{key}' is stored---\n\n"
      return nil
    end
    unlock_date_string = @json_data[key]["unlock_date"]
    unlock_date = Date.new(unlock_date_string[0..3].to_i, unlock_date_string[5..6].to_i, unlock_date_string[8..9].to_i)
    if unlock_date <= DateTime.now
      @json_data[key] = nil
      write_content
      puts "---Deleted password for '#{key}'---\n\n"
    else
      puts "---It's too early to delete this password. Wait until '#{unlock_date_string}' to do so---\n\n"
    end
  end

  def retrieve_password(key)
    load_data
    if self.json_data[key] == nil
      puts "---No password saved for '#{key}'---"
      return nil
    end
    unlock_date = self.json_data[key]["unlock_date"].to_s
    if unlock_date != self.current_date.to_s
      puts "---You will have to wait until '#{unlock_date}' to retrieve the password for '#{key}'---\n\n"
      return nil
    end
    puts "---The password for '#{key}' is: #{self.json_data[key]["password"]}---\n\n"
  end
end
