/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userclasses.model.playable;

import com.codename1.ui.Image;
import java.net.URI;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Set;
import userclasses.model.Artist;
import userclasses.model.Genre;

/**
 *
 * @author Sem
 */
public class Release {

    /**
     * All of the genres this mix subscribes to
     */
    private Set<Genre> genres;
    /**
     * The artist(s) involved
     */
    private Set<Artist> artists;
    private String title;
    private boolean embeddable;
    private String organisationOwner;
    private URI uri;
    private int releaseId;
    private ArrayList<Image> covers;
    private ArrayList<Image> smallCovers;
    private ArrayList<Image> hugeCovers;
    private Date releaseDate;
    private double playtime;

    public Release(Set<Genre> genres, Set<Artist> artists, String title,
            boolean embeddable, String organisationOwner, URI webPageURI,
            int releaseId, ArrayList<Image> covers, ArrayList<Image> smallCovers,
            ArrayList<Image> hugeCovers, Date releaseDate, double playtime) {
        this.genres = genres;
        this.artists = artists;
        this.title = title;
        this.embeddable = embeddable;
        this.organisationOwner = organisationOwner;
        this.uri = webPageURI;
        this.releaseId = releaseId;
        this.covers = covers;
        this.smallCovers = smallCovers;
        this.hugeCovers = hugeCovers;
        this.releaseDate = releaseDate;
        this.playtime = playtime;
    }

    /**
     * The genres to which this release belongs.
     */
    /**
     * @return a copy of the genres this Single subscribes to.
     */
    public Collection<? extends Genre> getGenres() {
        return genres;
    }

    public Set<Artist> getArtists() {
        return artists;
    }

    public void addGenre(Genre genre) {
        genres.add(genre);
    }

    public void addArtist(Artist artist) {
        artists.add(artist);
    }

    public void setGenres(Set<Genre> genres) {
        this.genres = genres;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isEmbeddable() {
        return embeddable;
    }

    public void setEmbeddable(boolean embeddable) {
        this.embeddable = embeddable;
    }

    public String getOrganisationOwner() {
        return organisationOwner;
    }

    public void setOrganisationOwner(String organisationOwner) {
        this.organisationOwner = organisationOwner;
    }

    public URI getUri() {
        return uri;
    }

    public void setUri(URI uri) {
        this.uri = uri;
    }

    public int getReleaseId() {
        return releaseId;
    }

    public void setReleaseId(int releaseId) {
        this.releaseId = releaseId;
    }

    public ArrayList<Image> getCovers() {
        return covers;
    }

    public void setCovers(ArrayList<Image> covers) {
        this.covers = covers;
    }

    public ArrayList<Image> getSmallCovers() {
        return smallCovers;
    }

    public void setSmallCovers(ArrayList<Image> smallCovers) {
        this.smallCovers = smallCovers;
    }

    public ArrayList<Image> getHugeCovers() {
        return hugeCovers;
    }

    public void setHugeCovers(ArrayList<Image> hugeCovers) {
        this.hugeCovers = hugeCovers;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public double getPlaytime() {
        return playtime;
    }

    public void setPlaytime(double playtime) {
        this.playtime = playtime;
    }
}
