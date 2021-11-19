# RailsGoat Security CTF [![Build Status](https://api.travis-ci.org/OWASP/railsgoat.png?branch=master)](https://travis-ci.org/OWASP/railsgoat) [![Code Climate](https://codeclimate.com/github/OWASP/railsgoat.png)](https://codeclimate.com/github/OWASP/railsgoat) 

  #### A long time ago in a galaxy far, far away . . .

RailsGoat is a vulnerable version of the Ruby on Rails Framework from versions 3 to 5. It includes vulnerabilities from the OWASP Top 10, as well as some "extras" that the initial project contributors felt worthwhile to share. This project is designed to educate both developers, as well as security professionals.

## Introduction

Welcome to FinanceIt's in-house security training module, built on top of the RailsGoat project and made in the style of a *Capture the Flag* event, a common type of competition in the information security world, similar to a hack-a-thon or coding contest.
    
There are typically two types of CTFs: Attack/Defend and Jeopardy style. Our training module is modeled after an Attack-based CTF and places you in the role of a black hat hacker aiming to exploit a vulnerable web application.

Each attacker will be required to find a series of “flags” which are hidden throughout the RailsGoat app. Finding all the flags will require the attacker to exploit common web vulnerabilities based on the OWASP Top 10 Web Security Risks.

The flags are ordered in rough order of increasing difficulty with resources and reading material on various web vulnerabilities provided throughout. Each flag appears in the form: `CTF[NameOfFlagHere]`.
  

## CTF Instructions
  

**Level One: Noob Town**

- **Theme**: Sensitive Data Exposure

- **Hint**: Look around the app for any suspicious information lying around. Remember that only suspicious people would dare to take Paid Time Off (PTO).

- **Solution**: Navigate to the bottom of the PTO tab.

- **Password**: `CTF[DemonSlayer]`
---
  **Level Two: Toddler with an iPad**

- **Theme**: Sensitive Data Exposure

- **Hint**: Look for suspicious CSS classes. The `Work Info` tab seems to be particularly stylish.

- **Solution**: Use Inspector to find the hidden CSS class of the SSN column in the Work Info tab.

- **Password**: `CTF[OnePiece]`
---
**Level Three: Chrome Inspector Master**

- **Theme**: Security Misconfiguration

- **Hint**: If configured incorrectly, an application will display a full routing trace instead of a 404 page.

- **Solution**: Go to a non-existent path and look for a flag in the list of routes.

- **Password**: `CTF[JojosBizarreAdventure]`
---
**Level Four: Security Engineer at SolarWinds**

- **Theme**: Security Misconfiguration

- **Hint**: Look for privileged routes that aren't properly protected. 

- **Solution**: Navigate to `/admin/1/get_all_users` and look for a user with an exposed Secure UUID.

- **Password**: `CTF[ChainsawMan]`
---
**Level Five: Dollar Store Neo**

- **Theme**: User Access Control

- **Hint**: There is an admin-level page that is missing proper access controls.

- **Solution**: Go to `/admin/1/dashboard` from any non-admin user.

- **Password**: `CTF[CowboyBebop]`
---
**Level Six: NSA Watchlist**

- **Theme**: Insecure Direct Object Reference

- **Hint**: There is a file `secret_token.rb` which contains sensitive information. On another note, it seems files can be downloaded from the Benefit Forms tab.

- **Solution**: Use the link for downloading files in the Benefit Forms tab and replace the file name with `secret_token.rb`.

- **Password**: `CTF[FullmetalAlchemist]`
---
**Level Seven: Greensky Corporate Spy**

- **Theme**: Unvalidated Redirects and Forwards

- **Hint**: Log out and try redirecting a user to Financeit's website.

- **Solution**: Go to /login?url=https://financeit.io and login as a valid user.

- **Password**: `CTF[FromTheNewWorld]`
---
**Level Eight: Gandalf the Grey-Hat Hacker**

- **Theme**: DOM or Python XSS (Cross-Site Scripting)

- **Hint**: You can execute remote commands by browsing to `/#test=<script>...</script>.`

- **Solution**: Go to `/#test=<script>alert(document.cookie)</script>.`

- **Password**: `CTF[Baccano]`
---
**Level Nine: Gandalf the White-Hat Hacker**

- **Theme**: Stored XSS (Cross-Site Scripting)

- **Hint**: When creating new objects in the DB, you can store JS as an attribute which will be executed whenever it's called.

- **Solution**: Sign up with a new user with a First Name of `<script>alert(document.cookie)</script>`.

- **Password**: `CTF[CodeGeass]`
---
**Level Ten: Gandalf the Black-Hat Hacker**

- **Theme**: Reflected XSS (Cross-Site Scripting)

- **Hint**: Uploading files can be used to inject a JS alert. The document's cookie is a good place to start.

- **Solution**: Upload a file named `><img  src=1  onerror=alert(document.cookie)>` to the Benefit Forms tab.

- **Password**: `CTF[MobPsycho100]`
---
**Level Eleven: NSA Most Wanted**

- **Theme**: Cross-Site Request Forgery (CSRF)

- **Tools**: Code Editor

- **Hint**: The Pay model has a hidden attribute called `show_secure_token` which is automatically false if created through the Pay tab.

- **Solution**: Open a script HTML file to create a Pay object with `show_secure_token` set to true.

- **Password**: `CTF[HunterXHunter]`
---
**Level Twelve: Cyberpunk 2078**

- **Theme**: Missing Function Level Access Control

- **Tools**: Chrome Inspector or Burpsuite

- **Hint**: Send a tampered message masquerading as another user. View the message.

- **Solution**: Send a message normally and intercept the POST request. Modify the creator_id to another user and send the request.

- **Password**: `CTF[LegendOfTheGalacticHeroes]`
---
**Level Thirteen: Destin's Reincarnation**

- **Theme**: SQL Injection / Privilege Escalation

- **Tools**: Chrome Inspector

- **Hint**: Use the password change function to change the admin's password. Browse for the flag on privileged pages.

- **Solution**: Intercept a password change POST and modify the user_id with `999') OR admin = 't' --'")`. Navigate to Analytics tab.

- **Example**:
``` 
"utf8=%E2%9C%93&_method=patch&authenticity_token=Bbl9ldbL6dgWq6YLPwQjxhHKVNrKwi13FiFOEhb%2BIcp0FdjR2VlxDHpl6WUTb7KSUnBk4WbdICMWtBmROxQBIw%3D%3D&user%5Buser_id%5D=999%27)%20OR%20admin%20%3D%20%27t%27%20--%27%22)&user%5Bpassword%5D=demonslayer&user%5Bpassword_confirmation%5D=demonslayer"
```

- **Password**: `CTF[DrStone]`
---
**Level Fourteen: Power Level Integer Overflow**

- **Theme**: Broken Session Management / Privilege Escalation

- **Tools**: Burpsuite

- **Hint**: This application re-uses encryption keys for auth tokens. The admin has a `user_id` of 1.

- **Solution**: Create a Pay object with all attributes set to 1. Modify the encrypted key to be url-encoded and intercept a GET request with Burpsuite. Navigate to Dashboard tab as admin.

- **Example**: `Cookie: auth_token=YuiYZyqVrlsLk7%2b6YcrC1Q%3d%3d`

- **Password**: `CTF[SteinsGate]`
---
**Level Fifteen: Ne Plus Ultra**

- **Theme**: Command Injection

- **Tools**: Burpsuite

- **Hint**: Find a way to create a directory called `mischiefmanaged` on the server.

- **Solution**: Intercept an upload/download request, modify the `benefits[backup]` to `true`, and append `;+mkdir+mischiefmanaged` to the filename. Navigate to Benefit Forms tab.

- **Password**: `CTF[GraveOfTheFireflies]`
---
**Bonus Level: Oscar-Winning Performance**

- **Theme**: High Performance Computing
- **Tools**: Code Editor, Terminal
- **Hint**: Every function in the code actually  just performs a simple arithmetic operation, but done in a very roundabout way. Try distilling each function into an equation to uncover the full behaviour of the app.
- **Password**: `HV15-mHPC-067e-751e-f50e-17e3`

The goal of this challenge is simply to run the file `oscar-winning-performance.cpp` to completion, the flag should be printed out at the end of the program. As this is a `.CPP` file written in C++, you will first need to compile the file before running it:
```
> g++ -o runthis oscar-winning-performance.cpp
> ./runthis
```
Notice that the file takes a very long time to complete and seems to run endlessly. Therefore, in order to reveal the flag, you simply need to refactor the program to improve performance without affecting its behaviour. The flag printed out at the end will begin with `HV15`.

- **Solution**:

Begin by noting that every one of the helper functions actually performs a simple arithmetic operation, and so a mapping can be formed from the helpers to their mathematical values:
```
foo(a)        ==  a++
bar(a)        ==  a--
baz(a,b)      ==  a+b
spam(a,b)     ==  a-b
eggs(a,b)     ==  a*b
merry(a,b)    ==  a/b
xmas(a,b)     ==  a - (a/b)*b
hackvent(a,b) ==  b^a
```
Further note that the original code strictly uses `uint64_t` which are unsigned 64-bit integers, meaning there is no need to account for negative values when optimizing each helper function.

The key line in the original code is the following:
```
val = xmas(eggs(baz(hackvent(merry(i,42),3),val),i),0x42DEADBABEC0FFEE);
```
With the new mapping, this can be translated to mean:
```
val = xmas(eggs(baz(hackvent(merry(i, 42), 3), val), i), 0x42DEADBABEC0FFEE);
val = xmas(eggs(baz(hackvent(i / 42, 3), val), i), 0x42DEADBABEC0FFEE);
val = xmas(eggs(baz(3 ^ (i / 42), val), i), 0x42DEADBABEC0FFEE);
val = xmas(eggs((3 ^ (i / 42)) + val, i), 0x42DEADBABEC0FFEE);
val = xmas(((3 ^ (i / 42)) + val) * i, 0x42DEADBABEC0FFEE);
val = (((3 ^ (i / 42)) + val) * i) - ((((3 ^ (i / 42)) + val) * i) / 0x42DEADBABEC0FFEE) * 0x42DEADBABEC0FFEE
```
Re-writing the code to perform this equation in a more performant manner should yield a script similar to:
```
#include <stdio.h>
#include <stdint.h>

uint64_t hackvent(uint64_t base, uint64_t exp){
	if (exp==0) 
		return 1

	uint64_t x = mypow(base,exp/2);

	if(exp % 2==0) 
		return x*x;
	else 
		return base*x*x;
}

uint64_t xmas(uint64_t a, uint64_t b) {
	return a - (a/b)*b;
}

int main() {
	uint64_t val=0;
	for(uint64_t i=0; i<0xC0DE42; i++) {
                val = xmas((hackvent(3, i / 42) + val) * i ,0x42DEADBABEC0FFEE);
	}

	printf("HV15-mHPC-%04llx-%04llx-%04llx-%04llx\n",
		val>>48,(val&0x0000FFFF00000000)>>32,
		(val&0x00000000FFFF0000)>>16, (val&0x000000000000FFFF));
	return 0;
}
```
This newer script runs much faster and at the end of its execution, it outputs the following flag: `HV15-mHPC-067e-751e-f50e-17e3`.

**Credits**: Problem and Solution from [Hackvent 2015](https://github.com/shiltemann/CTF-writeups-public/blob/master/Hackvent_2015/writeup.md).

---
**Bonus Level: Something Fourier This Way Comes**

- **Theme**: Steganography
- **Tools**: Code Editor, Image Processing Library (MATLAB, ImageMagick, etc.)
- **Hint**: Try distilling the image by even or odd RGB values.
- **Password**: `f0urier-ru1ez`

The goal of this challenge is to find a password hidden somewhere in the `ballomatic.png` image. Note that while this challenge is based on steganography, it does not require the use of any of the usual suspects in such challenges (`binwalk`, `exiftool`, `xxd`, etc.).

Part-way through this challenge, you will need to be aware of [Fourier Transforms](https://en.wikipedia.org/wiki/Fourier_transform) and specifically it's use in image processing:  (https://www.cs.unm.edu/~brayer/vision/fourier.html).

Also relevant is knowledge of a long-running webcomic series known as XKCD: https://xkcd.com/2540/

- **Solution**:

Filter the image by even RGB bits using the following script (or a similar tool):
```
from PIL import Image

img = Image.open('ballomatic.png')
pixels_orig = img.load()
(w,h)=img.size

outimg = Image.new( 'RGB', (w,h), "white")
pixels_out = outimg.load()

for i in range(0,h):
    for j in range(0,w):
      (r,g,b) = pixels_orig[j,i]
      if(r%2==0):
          pixels_out[j,i]=(0,0,0)

outimg.save("even-pixels-red.png","png")
``` 
This script can be run through the following: 
```
> python3 -m pip install --upgrade Pillow
> python3 script_name.py
```
Note that the `r%2==0` line means the script is filtering out the even red pixels. Alternatively, replace it with `b%2==0` to filter out even blue pixels and similar for green pixels.

Filtering by red pixels results in a new image with a message saying that the `princess is in another castle`. Filtering by the blue pixels results in a new image with a message referring to XKCD #26: https://xkcd.com/26

This XKCD comic is about Fourier Transforms, so process the original `ballomatic.png` image using Fourier Transformations. You can also use an online tool like (https://ejectamenta.com/imaging-experiments/fourifier/).

The resulting image has the flag of `f0urier-ru1ez`.

**Credits**: Problem and Solution from [Hackvent 2015](https://github.com/shiltemann/CTF-writeups-public/blob/master/Hackvent_2015/writeup.md).

---
**Bonus Level: SHA-1-shank Redemption**

- **Theme**: Cryptography
- **Tools**: Code Editor
- **Hint**: Try a simple brute-force approach to finding the full lower-case flag, and then the case-sensitive flag.
- **Password**: `HV15-GnUj-1YQ7-vdYC-2wlr-E6xj`

The flag for this round is similar to the following: `HV15-G?UJ-1YQ7-?DYC-2WLR-E6?J`. As you can see, there are three missing characters, where a `?` appears instead of an alpha-numeric character. The following three bits of information are also available to you:

1. A valid flag contains both upper **and** lower-case characters, which means the above string is not currently in it's correct case as it contains exclusively upper-case lettering.
2. The following is an SHA-1 hash of the *lower-case* version of the flag: `B39ECFBC2C64ADBB7C7A9292EEE31794D28FE224`
3. The following is an SHA-1 hash of the actual case-sensitive flag: `0D353038908AD0FC8C51A5312BB3E2FEE1CDDF83`

For this challenge, you must decrypt `HV15-G?UJ-1YQ7-?DYC-2WLR-E6?J` using knowledge of the [SHA-1 cryptographic function](https://en.wikipedia.org/wiki/SHA-1) and the above context clues.

- **Solution**:

Use a simple brute-force approach to first find all the characters, by ignoring the case requirements and searching strictly for the lower-case version of the flag:
```
import itertools
import hashlib

target_lc='B39ECFBC2C64ADBB7C7A9292EEE31794D28FE224'.lower()
charset='abcdefghijklmnopqrstuvwxyz0123456789'

for i in itertools.product(charset, repeat=3):
    nugget = 'hv15-g'+i[0]+'uj-1yq7-'+i[1]+'dyc-2wlr-e6'+i[2]+'j'  
    h = hashlib.sha1()
    h.update(nugget)   
    h_hex = h.hexdigest()
    if h_hex == target_lc:
        print 'Lower-Case Flag: ' + nugget +' (sha1 '+h.hexdigest()+')'
        break
```

Then write a similar script to find the correct casing of each character using another brute-force approach:
```
import itertools
import hashlib

def all_casings(input_string):
    if not input_string:
        yield ""
    else:
        first = input_string[:1]
        if first.lower() == first.upper():
            for sub_casing in all_casings(input_string[1:]):
                yield first + sub_casing
        else:
            for sub_casing in all_casings(input_string[1:]):
                yield first.lower() + sub_casing
                yield first.upper() + sub_casing

target_cs='0D353038908AD0FC8C51A5312BB3E2FEE1CDDF83'.lower()

for i in all_casings(nugget):
    h = hashlib.sha1()
    h.update(i)   
    h_hex = h.hexdigest()
    if h_hex == target_cs:
        print 'Case Sensitive Flag: ' + i + ' (sha1 '+h.hexdigest()+')'
        break
```

The resulting scripts output the following:
```
Lower-Case Flag: hv15-gnuj-1yq7-vdyc-2wlr-e6xj (sha1 b39ecfbc2c64adbb7c7a9292eee31794d28fe224)
Case Sensitive Flag: HV15-GnUj-1YQ7-vdYC-2wlr-E6xj (sha1 0d353038908ad0fc8c51a5312bb3e2fee1cddf83)
```
**Credits**: Problem and Solution from [Hackvent 2015](https://github.com/shiltemann/CTF-writeups-public/blob/master/Hackvent_2015/writeup.md).

## Bibliography

- This CTF project is a modified version of the open-source RailsGoat project set up by the OWASP Foundation. Original Source: https://github.com/OWASP/railsgoat
- The challenge in `Bonus Level: Oscar-Winning Performance` is originally from **HackVent 2015**.
- The challenge in `Bonus Level: Something Fourier This Way Comes` is originally from **HackVent 2015**.
- The challenge in `Bonus Level: SHA-1-shank Redemption` is originally from **HackVent 2015**.


## Extra Training

For a more involved coding, exercise, every participant is welcome to and encouraged to set up the original RailsGoat application here: https://github.com/OWASP/railsgoat

The original application is not a CTF, but contains many of the same vulnerabilities as well as tests which are failing to start with. For extra training, please modify the code itself to try and patch the different vulnerabilities across the application; each test should go from failing to pending as each exploit is patched.


## Setting Up CTF Locally

To begin, if you do not have Ruby, Git, MySQL, and Postgres, we suggest
using this [site](https://gorails.com/setup) to install the software.
Pick the appropriate operating system and follow the instructions.

After installing the above software, clone this repo:

```bash
$ git clone git@github.com:OWASP/railsgoat.git
```

**NOTE: NOT NECESSARY IF YOU WANT TO WORK WITH RAILS 6.** Otherwise, if you wish to use the Rails 3 or 4 versions, you'll need to switch branches:

```bash
$ cd railsgoat
$ git checkout rails_3_2
$ git checkout rails_4_2
```

Navigate into the directory (already there if you followed the previous step) and install the dependencies:

```bash
$ bundle install
```

If you receive an error, make sure you have `bundler` installed:

```bash
$ gem install bundler
```

Initialize the database:

```bash
$ rails db:setup
```

Start the Thin web server:

```bash
$ rails server
```
  

## License

  

The MIT License (MIT)

  

Copyright (c) 2013-2014 The Open Web Application Security Project

  

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
