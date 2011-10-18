#include <string>

#include <boost/shared_ptr.hpp>

#include <rsb/Event.h>
#include <rsb/Factory.h>
#include <rsb/Handler.h>
#include <rsb/filter/OriginFilter.h>

using namespace std;

using namespace boost;

void printMessage(rsb::EventPtr event) {
    // Insert display of messages
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
	cerr << "usage: " << argv[0] << " NICKNAME" << endl;
	return EXIT_FAILURE;
    }
    string nick = argv[1];
    // Insert creation of sending and receiving participants
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
	informer ...
    }

    return EXIT_SUCCESS;
}
