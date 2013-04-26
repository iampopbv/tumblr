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
import java.util.Arrays;
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
public class Track extends Single {

    // <editor-fold desc="Initialisation" defaultstate="collapsed">
    /**
     * Creates a track from this streamURL, initialises no genre or keywords.
     *
     * @param stream the URL from which the audio may be collected. may not be
     * null.
     * @param genre The genre of this track
     */
    public Track(final String stream, Set<Genre> genres, Set<Artist> artists, String title,
            boolean embeddable, String organisationOwner, URI uri,
            int releaseId, ArrayList<Image> covers, ArrayList<Image> smallCovers,
            ArrayList<Image> hugeCovers, Date releaseDate, double playtime)
            throws URISyntaxException {


        super(genres, artists, title, embeddable, organisationOwner, uri,
                releaseId, covers, smallCovers, hugeCovers, releaseDate,
                playtime, stream);

        if (genres == null) {
            throw new IllegalArgumentException("@param genre == null");
        }
    }
}
