package com.vittach.couriers.menuViewers;

import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.ScreensMenu.FirstMenu;
import com.vittach.couriers.ScreensMenu.StartMenu;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.myShell.ScreenButton;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ForGameScreen;

/**
 * Created by User on 16.09.2016.
 */
public class MyPinView implements ForGameScreen {
    private MyEngine E;

    public MyPinView(MyEngine E) {
        this.E = E;
    }

    void dispose() {
        E.myPin.DWNKey=-1;
        /*
        E.myPin.dispose();
        E.myPin=null;
        */
    }

    public
    void Display(Viewport view) {
        if (E.myPin.DWNKey >= 0) {
            Engine.inputListener.clnProces();
            switch (E.myPin.DWNKey) {
                case 2:
                    E.screen = 0;
                    if(E.startMenu == null)
                        E.startMenu = new StartMenu();
                    Engine.inputListener.addProces(E.startMenu.loginButton);
                    Engine.inputListener.addProces(E.startMenu);
                    dispose();
                    return;
                case 1:
                    E.screen = 1;
                    if(E.firstMenu == null)
                        E.firstMenu = new FirstMenu(E.leftMovingMenu, E.navbarSprite, E.navBarButton);
                    Engine.inputListener.addProces(E.firstMenu.leftMovingMenu);
                    Engine.inputListener.addProces(E.firstMenu.navBarButton);
                    Engine.inputListener.addProces(E.firstMenu);
                    dispose();
                    return;



                case 8:// opening leftMovingMenu
                    Engine.inputListener.addProces(E.myPin);
                    break;
                case 9:// closing leftMovingMenu
                    for(ScreenButton circlebutton:E.myPin.circlebuttons)
                        Engine.inputListener.addProces(circlebutton);
                    Engine.inputListener.addProces(E.myPin);
                    break;
            }
        }
        E.myPin.Display(view);
    }
}
