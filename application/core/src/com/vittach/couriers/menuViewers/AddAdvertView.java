package com.vittach.couriers.menuViewers;

import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ForGameScreen;

/**
 * Created by User on 05.09.2016.
 */
public class AddAdvertView implements ForGameScreen {
    private MyEngine E;

    public AddAdvertView(MyEngine E) {
        this.E = E;
    }

    public
    void Display(Viewport view) {
        if (E.addAdvert.DWNKey >= 0) {
            Engine.inputListener.clnProces();
            switch (E.addAdvert.DWNKey) {
                case 1:
                    E.screen = 1;
                    Engine.inputListener.addProces(E.firstMenu.leftMovingMenu);
                    Engine.inputListener.addProces(E.firstMenu.navBarButton);
                    Engine.inputListener.addProces(E.firstMenu);
                    break;
                case 2:
                    E.screen = 3;
                    Engine.inputListener.addProces(E.myAdvert.leftMovingMenu);
                    Engine.inputListener.addProces(E.myAdvert.navBarButton);
                    Engine.inputListener.addProces(E.myAdvert);
                    break;




                case 8:// opening leftMovingMenu
                    Engine.inputListener.addProces(E.addAdvert.leftMovingMenu);
                    Engine.inputListener.addProces(E.addAdvert.navBarButton);
                    Engine.inputListener.addProces(E.addAdvert);
                    break;
                case 9:// closing leftMovingMenu
                    Engine.inputListener.addProces(E.addAdvert.leftMovingMenu);
                    Engine.inputListener.addProces(E.addAdvert.postInfoButton);
                    Engine.inputListener.addProces(E.addAdvert.combobuttonA);
                    Engine.inputListener.addProces(E.addAdvert.combobuttonB);
                    Engine.inputListener.addProces(E.addAdvert.navBarButton);
                    Engine.inputListener.addProces(E.addAdvert);
                    break;
            }
            E.addAdvert.DWNKey = -1;
        }
        E.addAdvert.Display(view);
    }
}
