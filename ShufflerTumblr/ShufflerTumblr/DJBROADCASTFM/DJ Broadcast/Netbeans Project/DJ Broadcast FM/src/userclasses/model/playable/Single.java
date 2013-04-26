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
public abstract class Single extends Release {

    /**
     * The URI from which the audio stream may be collected.
     */
    public final URI stream;

    protected Single(Set<Genre> genres, Set<Artist> artists, String title, 
            boolean embeddable, String organisationOwner, URI uri, 
            int releaseId, ArrayList<Image> covers, ArrayList<Image> smallCovers, 
            ArrayList<Image> hugeCovers, Date releaseDate, double playtime,
            final String stream) throws URISyntaxException {
        super(genres, artists, title, embeddable, organisationOwner, uri, 
                releaseId, covers, smallCovers, hugeCovers, releaseDate, 
                playtime);
        if (stream == null) {
            throw new IllegalArgumentException("@param stream == null");
        }
        this.stream = new URI(stream);

    }
}