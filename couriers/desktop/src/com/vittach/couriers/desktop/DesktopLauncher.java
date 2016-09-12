package com.vittach.couriers.desktop;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.badlogic.gdx.backends.lwjgl.LwjglApplication;
import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration;

public class DesktopLauncher {
    public static void main(String[] arg) {
        LwjglApplicationConfiguration config0
                = new LwjglApplicationConfiguration();
        config0.width = 539;
        config0.height= 800;
        config0.title = "couriers";
        new LwjglApplication(new MyEngine(0),config0);
    }
}
