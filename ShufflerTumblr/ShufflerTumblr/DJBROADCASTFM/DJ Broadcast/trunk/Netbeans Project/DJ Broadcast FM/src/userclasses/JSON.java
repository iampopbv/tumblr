/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userclasses;

import com.codename1.io.ConnectionRequest;
import com.codename1.io.JSONParser;
import com.codename1.io.NetworkEvent;
import com.codename1.io.NetworkManager;
import com.codename1.ui.Dialog;
import com.codename1.ui.events.ActionEvent;
import com.codename1.ui.events.ActionListener;
import java.io.*;
import java.util.Hashtable;

/**
 *
 * @author Sem
 */
public class JSON {

    private String urlString;
    private String[][] data;
    public Hashtable release;

    public JSON() {
        urlString = "http://www.djbroadcast.fm/fmapi";
    }

    public String getListData(int page) {
        return "";
    }

    public Hashtable getRelease(int id) {
        NetworkManager networkManager = NetworkManager.getInstance();
        networkManager.start();
        networkManager.addErrorListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                NetworkEvent n = (NetworkEvent) evt;
                n.getError().printStackTrace();
            }
        });
        release = null;
        ConnectionRequest request = new ConnectionRequest() {
            int chr;
            StringBuffer sb = new StringBuffer();
            String response = "";

            protected void readResponse(InputStream input) throws IOException {
                //do something with input stream
                while ((chr = input.read()) != -1) {
                    sb.append((char) chr);
                    // System.out.println("reading...");
                }
                response = sb.toString();

                if (response.equals("")) {
                    Dialog.show("Error", "There where no results.", "Ok", null);
                } else {
                    JSONParser parser = new JSONParser();
                    release = parser.parse(new StringReader(response));

                    System.out.println("Count: " + release.size());
                }
            }

            protected void handleException(Exception err) {
                //do something with err
                Dialog.show("No connection", "It seems you are not connected to the internet.", "Ok", null);
            }
        };

        urlString = urlString + "/release/" + id;
        request.setUrl(urlString);
        request.setPost(false);
        networkManager.addToQueue(request);
        return release;
    }

    public String getBlockedData(int page) {
        return "";
    }

    public String getSearch(String search) {
        return "";
    }
}
