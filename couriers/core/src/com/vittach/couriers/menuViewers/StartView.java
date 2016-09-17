package com.vittach.couriers.menuViewers;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.ScreensMenu.FirstMenu;
import com.vittach.couriers.ScreensMenu.MyPin;
import com.vittach.couriers.ScreensMenu.Registration;
import com.vittach.couriers.myShell.ScreenButton;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ForGameScreen;

public class StartView implements ForGameScreen {
    private MyEngine E;

    public StartView(MyEngine E) {
        this.E = E;
    }

    void dispose() {
        E.startMenu.DWNKey=-1;
        /*
        E.startMenu.dispose();
        E.startMenu=null;
        */
    }

    public
    void Display(Viewport view) {
        if (E.startMenu.DWNKey >= 0) {
            Engine.inputListener.clnProces();
            switch (E.startMenu.DWNKey) {
                case 1:
                    E.screen = 1;
                    if(E.firstMenu == null)
                        E.firstMenu = new FirstMenu(E.leftMovingMenu, E.navbarSprite, E.navBarButton);
                    Engine.inputListener.addProces(E.firstMenu.leftMovingMenu);
                    Engine.inputListener.addProces(E.firstMenu.navBarButton);
                    Engine.inputListener.addProces(E.firstMenu);
                    dispose();
                    return;
                case 2:
                    E.screen = 4;
                    if(E.registration == null)
                        E.registration = new Registration(E.leftMovingMenu, E.navbarSprite, E.navBarButton);
                    Engine.inputListener.addProces(E.registration.registrationButton);
                    Engine.inputListener.addProces(E.registration.leftMovingMenu);
                    Engine.inputListener.addProces(E.registration.combobuttonCity);
                    Engine.inputListener.addProces(E.registration.navBarButton);
                    Engine.inputListener.addProces(E.registration);
                    dispose();
                    return;
                case 3:
                    E.screen = 7;
                    if(E.myPin == null)
                        E.myPin = new MyPin();
                    for(ScreenButton circlebutton:E.myPin.circlebuttons)
                    Engine.inputListener.addProces(circlebutton);
                    Engine.inputListener.addProces(E.myPin);
                    dispose();
                    return;
            }
        }
        E.startMenu.Display(view);
    }
}
