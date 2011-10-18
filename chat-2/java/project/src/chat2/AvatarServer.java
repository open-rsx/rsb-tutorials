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
