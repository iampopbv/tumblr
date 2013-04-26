package com.IT8.DJBroadcastFM;


import com.codename1.ui.Display;
import com.codename1.ui.Form;
import userclasses.StateMachine;

public class DJBroadcastFM {
   
    public Form current;

    public void init(Object context) {
    }

    public void start() {
        /*if(current != null){
            current.show();
            return;
        }*/
        StateMachine state = new StateMachine("/theme");     
        state.player.showPlayer();
    }

    public void stop() {
        current = Display.getInstance().getCurrent();
    }
    
    public void destroy() {
    }
}
