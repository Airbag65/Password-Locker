# Password locker

This little program served two purposes: learning a little bit of the ruby language, 
and potentially increasing my productivity by locking passwords until I'm allowed 
to retrieve them.

The main thought was to create randomized passwords that I can set to social
media accounts, and not retrieve them until I am allowed to do so, and therefore
keeping me off my phone, forcing me to do work.

### Functionalities
The ```main.rb``` file just contains a ```switch case``` that prompts different 
options. These are:
* List all platforms I have stored passwords for
* Create a new password for a platform
* Retrieve a password 
* Delete a password

The ```locker.rb``` file handles the ```JSON``` file which stores the passwords
and grants/denies access to passwords. It handles all functionality regarding 
creating passwords, storing passwords, deleting passwords etc. 

The file ```generator.rb``` just generates a new password. The ```initialize```
function takes a parameter which sets the length of the password that is to be 
generated. Then it just chooses a random letter or number, randomizes whether it
should be upper or lower case, and appends it to the password that is being generated.
It also adds a ```-``` symbol around every 5 characters to make the password accepted 
if the platform in question needs a password with a special letter. 