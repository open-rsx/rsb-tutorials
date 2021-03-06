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
        # Create server instance
        self.__localServer = ...
        self.__localServer.addMethod('get', self.sendAvatar)

    def sendAvatar(self, ignored):
        return self.__image

    def getAvatar(self, nick):
        # Create remote server instance
        remoteServer = ...
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
