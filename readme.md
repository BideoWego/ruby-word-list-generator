# Ruby word list generator

This is a simple word list generator written in Ruby. It is using the default Unix word list located at:

`/usr/share/dict/words`

To view this file on a Mac for instance go to Terminal and type:

`$ cat /usr/share/dict/words`

The operations the generator performs are clearly output during execution. This was my first real attempt to output execution progress in the command-line during a loop. This is nice because these files are quite long.

To execute this on a Unix machine like a Mac. Download the source and from the root directory run:

`ruby build.rb`

This will write the unique word list to `out.txt`