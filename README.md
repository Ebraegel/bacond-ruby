# bacond-ruby

Inspiration and list of meats taken from http://baconipsum.com/

## Usage:
 
./bacond.rb  [-nh]  [-p port]
note: you should be root to use ports < 1024

    -p, --port port                  BaconServer's listen port.  Default is 47808 (0xBAC0).
    -n, --newline                    Include a newline after each meat. Default is no newline.
    -d, --debug                      Produce extra output for debugging
    -c, --continuous                 Produce a continuous stream of meat.  Default is to close the connections after only one meat.
    -h, -?, --help                   Display this help text

## Example:

./bacond.rb -cn

BaconServer is now listening on port 47808, ready to deliver a continuous stream of meat.

Now, you can do something like:

echo | curl -s telnet://localhost:47808 >> meat

Witness your meat file fill up with meat very quickly.
