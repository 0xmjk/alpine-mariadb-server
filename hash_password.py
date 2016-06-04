#!/usr/bin/env python3
''' Generate a password hash compatible with MySQL-4.1+ PASSWORD().
The password hash is a hex representation of SHA1 of SHA1 digest of the plain text password.
Everytime you use an unsalted password a puppy dies :(
'''
 
import hashlib
from getpass import getpass
p = getpass(prompt="MariaDB Password: ").encode()
m = hashlib.sha1()
m.update(p)
s1 = m.digest()
m = hashlib.sha1()
m.update(s1)
s2 = m.hexdigest().upper()
print("*"+s2)

