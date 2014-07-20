h1 The package for SBCL

h3 Author: Rudolph Miller

1. How to Use
	```
	sbcl = new SBCL 'path-to-lisp-program
	sbcl.use (data) -> console.log data
	sbcl.write 'Hi'
	```

2. Methods
	* use = (fn) -> fn (stdout-of-lisp-program)
	* write = (str) -> write str to stdin of lisp-program
