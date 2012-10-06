/** ============================================================
 *
 * This file is part of the RSB project.
 *
 * Copyright (C) 2011, 2012 Jan Moringen jmoringe@techfak.uni-bielefeld.de
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

// mark-start::body
package chat2;

import com.google.protobuf.ByteString;
import java.util.logging.Level;
import java.util.logging.Logger;
import rsb.Factory;
import rsb.InitializeException;
import rsb.patterns.DataCallback;

import rst.vision.ImageType;
import rst.vision.ImageType.Image;

public class AvatarServer {

    private ImageType.Image image;

    private class Get implements DataCallback<ImageType.Image, Object> {
        public ImageType.Image invoke(Object ignored) {
            return AvatarServer.this.image;
        }

    }

    AvatarServer(String nickname) {
        rsb.patterns.LocalServer server = ...
            try {
                Image.Builder builder  = Image.newBuilder();
                this.image =  builder.setWidth(32).setHeight(32).setData(ByteString.EMPTY).build();
                server.addMethod("get", new Get());
                server.activate();
            } catch (InitializeException ex) {
                Logger.getLogger(AvatarServer.class.getName()).log(Level.SEVERE, null, ex);
            }
    }

};
// mark-end::body
