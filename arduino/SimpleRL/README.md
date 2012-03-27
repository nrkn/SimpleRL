This requires the BasicTerm Arduino library.  BasicTerm is available at
http://github.com/nottwo/BasicTerm

Clone the BasicTerm repository into ~/sketchbook/libraries and the
SimpleRL sketch should compile and upload correctly.

My Arduino appears as /dev/ttyACM0 under Linux and I connect to it with:

    $ screen /dev/ttyACM0 115200

You may have to ensure that you have read & write permissions to the
Arduino tty device or access it as root.

borys@nottwo.org
