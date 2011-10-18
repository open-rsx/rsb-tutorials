/** ============================================================
 *
 * This file is part of the RSB project.
 *
 * Copyright (C) 2011 Jan Moringen jmoringe@techfak.uni-bielefeld.de
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
	    List<String> results =  e.getScope().getComponents();
		System.out.print("\r" + results.get(results.size()-1) + ": " + e.getData() + "\n> ");
	    System.out.flush();
	}
    };

    public static void main(String args[]) throws IOException, RSBException {
	if (args.length != 1) {
	    System.err.println("usage: <java command> NICKNAME");
	    System.exit(1);
	}
	String nick = args[0];

	Informer informer = Factory.getInstance().createInformer("/chat/text/" + nick);
	informer.activate();

	Listener listener = Factory.getInstance().createListener("/chat/text");
	listener.activate();
	listener.addFilter(new OriginFilter(informer.getId(), true));
	listener.addHandler(new MessagePrinter(), true);

	InputStreamReader converter = new InputStreamReader(System.in);
        BufferedReader in = new BufferedReader(converter);
	while (true) {
	    System.out.print("> ");
	    System.out.flush();
	    String line = in.readLine();
	    if (line.equals("/quit")) {
		break;
	    }
	    informer.send(line);
	}
    }
};
