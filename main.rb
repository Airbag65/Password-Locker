require_relative 'generator'
require_relative 'locker'

# password_generator = Generator.new(15)

password_locker = Locker.new

while true
  puts "What would you like to do?\n(1): Create A New Password\n(2): Retrieve A Password\n(3): View Platforms\n(4): Delete A Password\n(5): Exit"
  choice = gets.chomp.to_i
  case choice
  when 1
    print "\nEnter the name of the platform the new password should be for: "
    user_key_input = gets.chomp
    password_locker.create_password(user_key_input)
  when 2
    print "\nWhich platform would you like to retrieve the password for? : "
    user_key_input = gets.chomp
    password_locker.retrieve_password(user_key_input)
  when 3
    password_locker.list_platforms
  when 4
    print "\nWhich platform would you like to delete the password for? : "
    user_key_input = gets.chomp
    password_locker.delete_password(user_key_input)
  when 5
    break
  else
    puts "Bad input"
  end
end


