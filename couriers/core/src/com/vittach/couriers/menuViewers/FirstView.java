package com.vittach.couriers.menuViewers;
import com.vittach.couriers.ScreensMenu.*;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ForGameScreen;

public class FirstView implements ForGameScreen {
    private MyEngine E;

    public FirstView(MyEngine E){
        this.E = E;
    }

    void dispose() {
        E.firstMenu.DWNKey=-1;
        /*
        E.firstMenu.dispose();
        E.firstMenu=null;
        */
    }

    public
    void Display(Viewport view) {
        if (E.firstMenu.DWNKey >= 0) {
            Engine.inputListener.clnProces();
            switch (E.firstMenu.DWNKey) {
                case 5:
                    E.screen = 0;
                    if(E.startMenu == null)
                        E.startMenu = new StartMenu();
                    Engine.inputListener.addProces(E.startMenu.loginButton);
                    Engine.inputListener.addProces(E.startMenu);
                    dispose();
                    return;
                case 4:
                    E.screen = 2;
                    if(E.addAdvert == null)
                        E.addAdvert = new AddAdvert(E.leftMovingMenu, E.navbarSprite, E.navBarButton);
                    Engine.inputListener.addProces(E.addAdvert.leftMovingMenu);
                    Engine.inputListener.addProces(E.addAdvert.postInfoButton);
                    Engine.inputListener.addProces(E.addAdvert.combobuttonA);
                    Engine.inputListener.addProces(E.addAdvert.combobuttonB);
                    Engine.inputListener.addProces(E.addAdvert.navBarButton);
                    Engine.inputListener.addProces(E.addAdvert);
                    dispose();
                    return;
                case 3:
                    E.screen = 6;
                    if(E.myStatus == null)
                        E.myStatus = new MyStatus(E.leftMovingMenu, E.navbarSprite, E.navBarButton);
                    Engine.inputListener.addProces(E.myStatus.svoboden);
                    Engine.inputListener.addProces(E.myStatus.otoshel);
                    Engine.inputListener.addProces(E.myStatus.zaniat);
                    Engine.inputListener.addProces(E.myStatus.leftMovingMenu);
                    Engine.inputListener.addProces(E.myStatus.navBarButton);
                    Engine.inputListener.addProces(E.myStatus);
                    dispose();
                    return;
                case 2:
                    E.screen = 3;
                    if(E.myAdvert == null)
                        E.myAdvert = new MyAdvert(E.leftMovingMenu, E.navbarSprite, E.navBarButton);
                    Engine.inputListener.addProces(E.myAdvert.leftMovingMenu);
                    Engine.inputListener.addProces(E.myAdvert.navBarButton);
                    Engine.inputListener.addProces(E.myAdvert);
                    dispose();
                    return;
                case 1:
                    E.screen = 5;
                    if(E.mySettings == null)
                        E.mySettings = new MySettings(E.leftMovingMenu, E.navbarSprite, E.navBarButton);
                    Engine.inputListener.addProces(E.mySettings.leftMovingMenu);
                    Engine.inputListener.addProces(E.mySettings.navBarButton);
                    Engine.inputListener.addProces(E.mySettings);
                    dispose();
                    return;
            }
        }
        E.firstMenu.Display(view);
    }
}
