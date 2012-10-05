package chat1;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.util.List;

import rsb.RSBException;
import rsb.Event;
import rsb.Listener;
import rsb.Informer;
import rsb.Factory;
import rsb.Handler;

import rsb.filter.OriginFilter;

public class Chat1 {

    private static class MessagePrinter implements Handler {
        @Override
        public void internalNotify(Event e) {
            // Insert display of messages
        }
    };

    public static void main(String args[]) throws IOException, RSBException {
        if (args.length != 1) {
            System.err.println("usage: <java command> NICKNAME");
            System.exit(1);
        }
        String nick = args[0];

        // Insert creation of sending and receiving participants
        Informer informer = ...;
        informer.activate();

        Listener listener = ...;
        listener.activate();
        listener.addFilter(new OriginFilter(informer.getId(), true));
        // Add a handler
        listener.addHandler(...);

        InputStreamReader converter = new InputStreamReader(System.in);
        BufferedReader in = new BufferedReader(converter);
        while (true) {
            System.out.print("> ");
            System.out.flush();
            String line = in.readLine();
            if (line.equals("/quit")) {
                break;
            }
            // Insert sending code here
            informer ...
        }
    }
};
