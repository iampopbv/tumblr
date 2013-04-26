/*
 * If you own this file you are free to edit and share it.
 * You are, however, not allowed to mass-distribute it
 *     E.g.: Mailing a copy is O.K., 
 *     mirroring/hosting this or a modified version is not O.K.
 * Exemptions to this are assigned at will by the author only.
 */
package userclasses.model.playable;

import com.codename1.ui.Image;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import userclasses.model.Artist;
import userclasses.model.Genre;

/**
 *
 * @author B.Al <berend.al@hva.nl>
 */
public class Mix extends Single {
    // <editor-fold desc="Fields" defaultstate="collapsed">

    /**
     * All of the genres this mix subscribes to
     */
    private final HashSet<Genre> genres;

    // </editor-fold>
    // <editor-fold desc="Initialisation" defaultstate="collapsed">
    /**
     * Creates a new mix, which is not much different from a track.
     *
     * @param stream the stream resource for this single
     * @param genres the genres to which this single subscribes
     */
    /*package*/
    public Mix(final String stream, Set<Genre> genres, Set<Artist> artists, String title, 
            boolean embeddable, String organisationOwner, URI uri, 
            int releaseId, ArrayList<Image> covers, ArrayList<Image> smallCovers, 
            ArrayList<Image> hugeCovers, Date releaseDate, double playtime) 
            throws URISyntaxException {
        super(genres, artists, title, embeddable, organisationOwner, uri, 
                releaseId, covers, smallCovers, hugeCovers, releaseDate,
                playtime, stream);
        this.genres = new HashSet<Genre>(genres);
    }

    // </editor-fold>

}
