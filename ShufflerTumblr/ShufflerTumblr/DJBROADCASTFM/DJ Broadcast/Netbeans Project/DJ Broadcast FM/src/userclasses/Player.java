/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userclasses;

import com.codename1.ui.Button;
import com.codename1.ui.Container;
import com.codename1.ui.Form;
import com.codename1.ui.Image;
import com.codename1.ui.Label;
import com.codename1.ui.events.ActionEvent;
import com.codename1.ui.events.ActionListener;
import java.io.IOException;

/**
 *
 * @author Sem
 */
public class Player {

    private Form playerForm;
    private Image image, background;

    public Player() {
        playerForm = new Form();
        Container c = new Container();
        try {
            image = Image.createImage("/topbar.png");
            background = Image.createImage("/Backgroundcolor.png");
        } catch (IOException ex) {
            System.out.println(ex.getMessage());
        }
        playerForm.setBgImage(background);

        Label topBar = new Label(image);
        topBar.setX(0);
        topBar.setY(0);
        topBar.setUIID("ContentPane");

        c.addComponent(topBar);
        playerForm.addComponent(c);
    }

    public void showPlayer() {
        playerForm.show();
    }
}
