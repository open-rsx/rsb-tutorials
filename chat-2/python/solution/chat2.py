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
from rsb.transport.converter import ProtocolBufferConverter, registerGlobalConverter

from rst.vision.Image_pb2 import Image

import chat1

registerGlobalConverter(ProtocolBufferConverter(messageClass = Image))
rsb.__defaultParticipantConfig = rsb.ParticipantConfig.fromDefaultSources()

class AvatarServer (object):
    def __init__(self, nick, image):
        self.__image = image
        self.__localServer = rsb.createServer('/chat/avatar/%s' % nick)
        self.__localServer.addMethod('get', self.sendAvatar)

    def sendAvatar(self, ignored):
        return self.__image

    def getAvatar(self, nick):
        remoteServer = rsb.createRemoteServer('/chat/avatar/%s' % nick)
        return remoteServer.get(None)

__image = Image()
__image.width = 32
__image.height = 32
__image.data = 'c'*(32 * 32 * 3)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print 'usage: %s NICKNAME' % sys.argv[0]
        sys.exit(1)
    nick = sys.argv[1]

    __server = AvatarServer(nick, __image)
    chat1.chatClient(nick)
# mark-end::body
