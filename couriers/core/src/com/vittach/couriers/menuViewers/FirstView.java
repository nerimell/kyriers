package com.vittach.couriers.menuViewers;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ForGameScreen;

public class FirstView implements ForGameScreen {
    private MyEngine E;

    public FirstView(MyEngine E){
        this.E = E;
    }

    public
    void Display(Viewport view) {
        if (E.firstMenu.DWNKey >= 0) {
            Engine.inputListener.clnProces();
            switch (E.firstMenu.DWNKey) {
                case 4:
                    E.screen = 2;
                    Engine.inputListener.addProces(E.addAdvert.leftMovingMenu);
                    Engine.inputListener.addProces(E.addAdvert.postInfoButton);
                    Engine.inputListener.addProces(E.addAdvert.combobuttonA);
                    Engine.inputListener.addProces(E.addAdvert.combobuttonB);
                    Engine.inputListener.addProces(E.addAdvert.navBarButton);
                    Engine.inputListener.addProces(E.addAdvert);
                    break;
                case 2:
                    E.screen = 3;
                    Engine.inputListener.addProces(E.myAdvert.leftMovingMenu);
                    Engine.inputListener.addProces(E.myAdvert.navBarButton);
                    Engine.inputListener.addProces(E.myAdvert);
                    break;
                case 1:
                    E.screen = 0;
                    Engine.inputListener.addProces(E.startMenu.loginButton);
                    Engine.inputListener.addProces(E.startMenu);
                    break;
            }
            E.firstMenu.DWNKey=-1;
        }
        E.firstMenu.Display(view);
    }
}
