/** ============================================================
 *
 * This file is part of the RSB project.
 *
 * Copyright (C) 2011 Jan Moringen <jmoringe@techfak.uni-bielefeld.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * ============================================================  */

#include <string>

#include <boost/shared_ptr.hpp>

#include <rsb/Event.h>
#include <rsb/Factory.h>
#include <rsb/Handler.h>
#include <rsb/filter/OriginFilter.h>

#include <rsb/converter/Repository.h>
#include <rsb/converter/ProtocolBufferConverter.h>

#include <rsb/patterns/Server.h>

#include <rst/vision/Image.pb.h>

using namespace std;

using namespace boost;

void printMessage(rsb::EventPtr event) {
    shared_ptr<string> message
	= static_pointer_cast<string>(event->getData());

    string sender = event->getScope().getComponents().back();

    cout << "\r" << sender << ": " << *message  << endl
         << "> ";
    cout.flush();
}

typedef shared_ptr<rst::vision::Image> ImagePtr;

class AvatarCallback: public rsb::patterns::Server::Callback<void, rst::vision::Image> {
public:
    AvatarCallback(ImagePtr image):
	image(image) {
    }

    ImagePtr call(const string &methodName) {
	return this->image;
    }
private:
    ImagePtr image;
};

int main(int argc, char *argv[]) {
    rsb::converter::stringConverterRepository()->registerConverter(rsb::converter::Converter<string>::Ptr(new rsb::converter::ProtocolBufferConverter<rst::vision::Image>()));

    if (argc != 2) {
	cerr << "usage: " << argv[0] << " NICKNAME" << endl;
	return EXIT_FAILURE;
    }
    string nick = argv[1];

    rsb::Factory &factory = rsb::Factory::getInstance();

    rsb::Informer<string>::Ptr informer
	= factory.createInformer<string>("/chat/text/" + nick);
    rsb::ListenerPtr listener = factory.createListener("/chat/text");
    listener->addFilter(rsb::filter::FilterPtr(new rsb::filter::OriginFilter(informer->getId(), true)));
    listener->addHandler(rsb::HandlerPtr(new rsb::EventFunctionHandler(&printMessage)));

    ImagePtr avatarImage(new rst::vision::Image());
    avatarImage->set_width(32);
    avatarImage->set_height(32);
    avatarImage->mutable_data()->resize(32 * 32 * 3);
    rsb::patterns::ServerPtr avatarServer
	= factory.createServer("/chat/avatar/"  + nick);
    avatarServer->registerMethod("get", rsb::patterns::Server::CallbackPtr(new AvatarCallback(avatarImage)));

    while (true) {
	cout << "> ";
	cout.flush();
	shared_ptr<string> message(new string());
	getline(cin, *message);
	if (*message == "/quit") {
	    break;
	}
	informer->publish(message);
    }

    return EXIT_SUCCESS;
}