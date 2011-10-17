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

using namespace std;

using namespace boost;

void printMessage(rsb::EventPtr event) {
    // Insert display messages 
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
	cerr << "usage: " << argv[0] << " NICKNAME" << endl;
	return EXIT_FAILURE;
    }
    string nick = argv[1];
    // Insert sending and receiving instances
    rsb::Factory &factory = ...

    rsb::Informer<string>::Ptr informer = ...
    rsb::ListenerPtr listener = ...
    listener->addFilter(rsb::filter::FilterPtr(new rsb::filter::OriginFilter(informer->getId(), true)));
    // Add a handler
    listener->addHandler(...);

    while (true) {
	cout << "> ";
	cout.flush();
	shared_ptr<string> message(new string());
	getline(cin, *message);
	if (*message == "/quit") {
	    break;
	}
	// Send the message
    }

    return EXIT_SUCCESS;
}
