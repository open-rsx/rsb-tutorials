import sys
import rsb
import rsb.filter

def chatClient(nick):
    # Insert creation of sending and receiving participants
    informer = ...
    listener = ...

    def printMessage(event):
	# Insert display of messages
	...

    listener.addFilter(rsb.filter.OriginFilter(informer.id, invert = True))
    # Add a handler
    listener.addHandler(...)

    while True:
        sys.stdout.write('> ')
        sys.stdout.flush()
        line = sys.stdin.readline().strip()
        if line == '/quit':
            return
        if line:
            # Insert sending code here
            informer ...

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print 'usage: %s NICKNAME' % sys.argv[0]
        sys.exit(1)
    nick = sys.argv[1]

    chatClient(nick)
