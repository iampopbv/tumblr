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
import com.codename1.ui.Image;
import com.codename1.ui.events.ActionEvent;
import com.codename1.ui.events.ActionListener;
import java.io.*;
import java.net.URI;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Set;
import java.util.Vector;
import userclasses.model.Artist;
import userclasses.model.playable.Release;

/**
 *
 * @author Sem
 */
public class DJBroadcastDB {

    private final String urlString;
    private String[][] data;
    private static DJBroadcastDB query;

    private DJBroadcastDB(String apiUrl) {
        urlString = apiUrl;
    }

    public static DJBroadcastDB getInstance() {
        if (query == null) {
            query = new DJBroadcastDB("http://www.djbroadcast.fm/fmapi");
        }
        return query;
    }
    private Hashtable hashtable;

    public Collection<Release> getListData(int page) {
        List<Release> release = null;


        NetworkManager networkManager = NetworkManager.getInstance();
        networkManager.start();
        networkManager.addErrorListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                NetworkEvent n = (NetworkEvent) evt;
                n.getError().printStackTrace();
            }
        });

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
                    JSONParser json = new JSONParser();
                    InputStream is = new ByteArrayInputStream(response.getBytes());
                    InputStreamReader reader = new InputStreamReader(is);

                    hashtable = json.parse(reader);

                    Enumeration releases = hashtable.keys();
                    System.out.println("Counting elements.");
                    while (releases.hasMoreElements()) {
                        String str = (String) releases.nextElement();
                        System.out.println("key: " + str + " value: "
                                + hashtable.get(str));
                    }
                    System.out.println("Done counting.");
                }
            }

            protected void handleException(Exception err) {
                //do something with err
                Dialog.show("No connection", "It seems you are not connected to the internet.", "Ok", null);
            }
        };

        String newUrl = urlString + "/getlisteddata/" + page;
        request.setUrl(newUrl);
        request.setPost(false);
        networkManager.addToQueueAndWait(request);

        // parse the hashtable to a Release object
//        Enumeration releases = hashtable.keys();
//        System.out.println("Counting elements.");
//        while (releases.hasMoreElements()) {
//        }
//        System.out.println("Done counting.");


        return release;
    }

    /**
     * Retreives a release with a specific ID. It uses the DJBroadcast API to
     * query the database.
     *
     * @param id an int representing the id of the release
     * @return the release
     */
    public Release getRelease(int id) {
        Release release = null;
        NetworkManager networkManager = NetworkManager.getInstance();
        networkManager.start();
        networkManager.addErrorListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                NetworkEvent n = (NetworkEvent) evt;
                n.getError().printStackTrace();
            }
        });

        ConnectionRequest request = new ConnectionRequest() {
            int chr;
            StringBuffer sb = new StringBuffer();
            String response = "";

            protected void readResponse(InputStream input) throws IOException {
                // Read the inputstream and put it into a StringBuffer
                while ((chr = input.read()) != -1) {
                    sb.append((char) chr);
                }
                // Make a String of the StringBuffer
                response = sb.toString();

                if (!response.equals("")) {
                    JSONParser json = new JSONParser();
                    InputStream is = new ByteArrayInputStream(response.getBytes());
                    InputStreamReader reader = new InputStreamReader(is);

                    hashtable = json.parse(reader);
                } else {
                    Dialog.show("Error", "There where no results.", "Ok", null);
                }
            }

            protected void handleException(Exception err) {
                //do something with err
                Dialog.show("No connection", "It seems you are not connected to the internet.", "Ok", null);
            }
        };

        String newUrl = urlString + "/release/" + id;
        request.setUrl(newUrl);
        request.setPost(false);
        networkManager.addToQueueAndWait(request);

        // parse the hashtable to a Release object
        Enumeration releases = hashtable.keys();

        /*while (releases.hasMoreElements()) {
            String key = (String) releases.nextElement();
            switch (key) {
                case "tracklist":
                    Vector v = (Vector) hashtable.get(key);                    
                    break;
                case "url":
                    break;
                case "cover_small":
                    break;
                case "cover_huge":
                    break;
                case "owner":
                    break;
                case "release_id":
                    break;
                case "release_embeddable":
                    break;
                case "cover_big":
                    break;
                case "artist":
                    break;
                case "release_date":
                    break;
                case "genre1":
                    break;
                case "release_frontpage":
                    break;
                case "type":
                    break;
                case "title":
                    break;
                case "playtime":
                    break;
            }
        }*/

        Set<Artist> artists;
        String title;
        boolean embeddable;
        String organisationOwner;
        URI uri;
        int releaseId;
        ArrayList<Image> covers;
        ArrayList<Image> smallCovers;
        ArrayList<Image> hugeCovers;
        Date releaseDate;
        double playtime;




        release = new Release(null, null, newUrl, true, urlString, null, id, null, null, null, null, id);


        return release;
    }

    public Collection<Release> getBlockedData(int page) {
        List<Release> release = null;

        NetworkManager networkManager = NetworkManager.getInstance();
        networkManager.start();
        networkManager.addErrorListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                NetworkEvent n = (NetworkEvent) evt;
                n.getError().printStackTrace();
            }
        });

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
                    JSONParser json = new JSONParser();
                    InputStream is = new ByteArrayInputStream(response.getBytes());
                    InputStreamReader reader = new InputStreamReader(is);

                    hashtable = json.parse(reader);
                }
            }

            protected void handleException(Exception err) {
                //do something with err
                Dialog.show("No connection", "It seems you are not connected to the internet.", "Ok", null);
            }
        };

        String newUrl = urlString + "/getblockeddata/" + page;
        request.setUrl(newUrl);
        request.setPost(false);
        networkManager.addToQueueAndWait(request);
        return release;
    }

    public Collection<Release> getSearch(String search) {
        List<Release> release = null;

        NetworkManager networkManager = NetworkManager.getInstance();
        networkManager.start();
        networkManager.addErrorListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                NetworkEvent n = (NetworkEvent) evt;
                n.getError().printStackTrace();
            }
        });

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
                    JSONParser json = new JSONParser();
                    InputStream is = new ByteArrayInputStream(response.getBytes());
                    InputStreamReader reader = new InputStreamReader(is);

                    hashtable = json.parse(reader);
                }
            }

            protected void handleException(Exception err) {
                //do something with err
                Dialog.show("No connection", "It seems you are not connected to the internet.", "Ok", null);
            }
        };

        String newUrl = urlString + "/search/" + search;
        request.setUrl(newUrl);
        request.setPost(false);
        networkManager.addToQueueAndWait(request);
        return release;
    }
}
