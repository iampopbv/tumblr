/**
 * Your application code goes here
 */
package userclasses;

import userclasses.model.Genre;
import com.codename1.ui.*;
import com.codename1.ui.util.Resources;
import generated.StateMachineBase;
import java.net.URISyntaxException;
import java.util.Hashtable;
import java.util.Vector;
import userclasses.model.playable.Release;
import userclasses.model.playable.Track;

/**
 *
 * @author Your name here
 */
public class StateMachine extends StateMachineBase {

    private DJBroadcastDB json;
    public Player player;

    public StateMachine(final String resFile) {
        super(resFile);
        // do not modify, write code in initVars and initialize class members there,
        // the constructor might be invoked too late due to race conditions that might occur
    }

    /**
     * this method should be used to initialize variables instead of the
     * constructor/class scope to avoid race conditions
     */
    protected void initVars(final Resources res) {
    }

    @Override
    protected void onCreateMain() {
        setComponents();
    }

    private void setComponents() {
    }

    @Override
    protected void postMain(final Form f) {
        player = new Player();
        json = DJBroadcastDB.getInstance();
        Release rls = json.getRelease(50);
        

        player.showPlayer();
    }
}