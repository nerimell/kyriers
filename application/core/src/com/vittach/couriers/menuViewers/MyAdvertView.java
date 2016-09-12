package com.vittach.couriers.menuViewers;

import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ForGameScreen;

/**
 * Created by User on 12.09.2016.
 */
public class MyAdvertView implements ForGameScreen {
    private MyEngine E;

    public MyAdvertView(MyEngine E){
        this.E = E;
    }

    public
    void Display(Viewport view) {
        if (E.myAdvert.DWNKey >= 0) {
            Engine.inputListener.clnProces();
            switch (E.myAdvert.DWNKey) {
                case 4:
                    E.screen = 2;
                    Engine.inputListener.addProces(E.addAdvert.leftMovingMenu);
                    Engine.inputListener.addProces(E.addAdvert.postInfoButton);
                    Engine.inputListener.addProces(E.addAdvert.combobuttonA);
                    Engine.inputListener.addProces(E.addAdvert.combobuttonB);
                    Engine.inputListener.addProces(E.addAdvert.navBarButton);
                    Engine.inputListener.addProces(E.addAdvert);
                    break;
                case 1:
                    E.screen = 0;
                    Engine.inputListener.addProces(E.startMenu.loginButton);
                    Engine.inputListener.addProces(E.startMenu);
                    break;
            }
            E.myAdvert.DWNKey=-1;
        }
        E.myAdvert.Display(view);
    }
}
