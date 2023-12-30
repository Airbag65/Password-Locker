require_relative 'generator'
require_relative 'locker'

password_generator = Generator.new(15)
password_locker = Locker.new

puts "What would you like to do?\n(1): Create A New Password\n(2): Retrieve A Password"
choice = gets.chomp.to_i

case choice
when 1
  new_pass = password_generator.generate_password
  print "Enter the name of the platform the new password should be for: "
  user_key_input = gets.chomp
  password_locker.create_password(user_key_input, new_pass)
  puts "New password for '#{user_key_input}' was created"
when 2
  print "Which platform would you like to retrieve the password for? : "
  user_key_input = gets.chomp
  password_locker.retrieve_password(user_key_input)
else
  puts "Bad input"
end