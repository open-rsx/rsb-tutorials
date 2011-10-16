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

package chat;

import rsb.Factory;
import rsb.patterns.DataCallback;

import rst.vision.ImageType;

public class AvatarServer {

    private ImageType.Image image;

    ImageType.Image getImage() {
	return image;
    }

    void setImage(ImageType.Image image) {
	this.image = image;
    }

    private class Get implements Callback<Object, ImageType> {
	public ImageType.Image invoke(Object ignored) {
	    return AvatarServer.this.avatar;
	}
    }

    AvatarServer(String nickname) {
	server = Factory.getInstance().createServer("/chat/avatar/" + nickname);
	server.registerMethod(new Get());
    }

};
