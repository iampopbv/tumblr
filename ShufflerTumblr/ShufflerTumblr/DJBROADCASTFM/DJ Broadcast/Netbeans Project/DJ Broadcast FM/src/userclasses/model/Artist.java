/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userclasses.model;

/**
 *
 * @author Casper
 */
public class Artist {
    private final int artistId;
    private final String name;
    private final String artistPhotoURL;
    private final String biography;
    private final String facebookLink;
    private final String twitterLink;
    private final String soundcloudLink;

    
    /** 
     * Creates a new Artist Object.
     * 
     * @param artistId the id of the artist
     * @param name the name of the artist
     * @param artistPhotoURL the url to the photo of the artist
     * @param biography the biography of the artist
     * @param facebookLink a link to the facebook of the artist
     * @param twitterLink a link to the twitter account of the artist
     * @param soundcloudLink a link to the soundcloud account of the artist
     */
    public Artist(int artistId, String name, String artistPhotoURL, 
            String biography, String facebookLink, String 
                    twitterLink, String soundcloudLink) {
        this.artistId = artistId;
        this.name = name;
        this.artistPhotoURL = artistPhotoURL;
        this.biography = biography;
        this.facebookLink = facebookLink;
        this.twitterLink = twitterLink;
        this.soundcloudLink = soundcloudLink;
    }

    /** Getters */
    
    /** 
     * Get the Artist ID.
     * 
     * @return the id of the artist in the form of an int
     */
    public int getArtistId() {
        return artistId;
    }

    /** 
     * Get the Artist name.
     * 
     * @return a String containing the name of the artist.
     */
    public String getName() {
        return name;
    }

    /**
     * 
     * 
     * @return 
     */
    public String getArtistPhotoURL() {
        return artistPhotoURL;
    }

    public String getBiography() {
        return biography;
    }

    public String getFacebookLink() {
        return facebookLink;
    }

    public String getTwitterLink() {
        return twitterLink;
    }

    public String getSoundcloudLink() {
        return soundcloudLink;
    }
}
