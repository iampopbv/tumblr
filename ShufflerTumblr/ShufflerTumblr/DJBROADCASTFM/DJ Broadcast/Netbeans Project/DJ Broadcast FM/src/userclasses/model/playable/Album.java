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
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import userclasses.model.Artist;
import userclasses.model.Genre;

/**
 *
 * @author B.Al <berend.al@hva.nl>
 */
public class Album extends Release {
    // <editor-fold desc="Fields" defaultstate="collapsed">

    /**
     * The tracks in this album
     */
    private final List<Single> tracks;
    /**
     * The genres of the tracks in this album
     */
    private final Set<Genre> genres;
    

    // </editor-fold>
    // <editor-fold desc="Initialisation" defaultstate="collapsed">
    public Album(final Collection<? extends Single> singles,
            Set<Genre> genres, Set<Artist> artists, String title, 
            boolean embeddable, String organisationOwner, URI uri, 
            int releaseId, ArrayList<Image> covers, ArrayList<Image> smallCovers, 
            ArrayList<Image> hugeCovers, Date releaseDate, double playtime) {
        
        super(genres, artists, title, embeddable, organisationOwner, uri, 
                releaseId, covers, smallCovers, hugeCovers, releaseDate, playtime);
        this.tracks = new ArrayList<Single>(singles);
        this.genres = new HashSet(singles.size());
        for (final Single single : singles) {
            this.genres.addAll(single.getGenres());
        }
    }
    // </editor-fold>
}
