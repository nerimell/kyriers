package com.vittach.couriers.menuViewers;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ForGameScreen;

public class StartView implements ForGameScreen {
    private MyEngine E;

    public StartView(MyEngine E) {
        this.E = E;
    }

    public
    void Display(Viewport view) {
        if (E.startMenu.DWNKey >= 0) {
            Engine.inputListener.clnProces();
            switch (E.startMenu.DWNKey) {
                case 1:
                    E.screen = 1;
                    Engine.inputListener.addProces(E.firstMenu.leftMovingMenu);
                    Engine.inputListener.addProces(E.firstMenu.navBarButton);
                    Engine.inputListener.addProces(E.firstMenu);
                    break;
            }
            E.startMenu.DWNKey = -1;
        }
        E.startMenu.Display(view);
    }
}
