# ============================================================
#
# This file is part of the RSB project.
#
# Copyright (C) 2011, 2012 Jan Moringen <jmoringe@techfak.uni-bielefeld.de>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# ============================================================

# mark-start::body
import sys
import rsb
import rsb.filter

def chatClient(nick):
    informer = rsb.createInformer('/chat/text/%s' % nick)

    listener = rsb.createListener('/chat/text')
    def printMessage(event):
        sys.stdout.write('%s%s: %s\n> '
                         % (chr(13),
                            event.scope.components[-1],
                            event.data))
        sys.stdout.flush()
    listener.addFilter(rsb.filter.OriginFilter(informer.id, invert = True))
    listener.addHandler(printMessage)

    while True:
        sys.stdout.write('> ')
        sys.stdout.flush()
        line = sys.stdin.readline().strip()
        if line == '/quit':
            return
        if line:
            informer.publishData(line)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print 'usage: %s NICKNAME' % sys.argv[0]
        sys.exit(1)
    nick = sys.argv[1]

    chatClient(nick)
# mark-end::body
