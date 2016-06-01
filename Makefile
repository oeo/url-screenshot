export NODE_ENV = test
export TAKY_DEV = 1

main:
	iced -c --runtime inline module.iced

run:
	$(MAKE)
	node module.js

