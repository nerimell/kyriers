package com.vittach.couriers.menuViewers;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ForGameScreen;

public class LoadSave implements ForGameScreen {
    private MyEngine E;

    public LoadSave(MyEngine E) {
        this.E = E;
    }

    public
    void Display(Viewport view) {
        if (E.open.DWNKey >= 0) {
            Engine.inputListener.clnProces();
            switch (E.open.DWNKey) {
                case 1:E.screen = 0;
                    Engine.inputListener.addProces(E.startMenu.loginButton);
                    Engine.inputListener.addProces(E.startMenu);
                    break;
            }
            E.open.DWNKey = -1;
        }
        E.open.Display(view);
    }
}
