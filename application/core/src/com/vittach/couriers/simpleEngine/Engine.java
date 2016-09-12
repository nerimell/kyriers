package com.vittach.couriers.simpleEngine;

import com.badlogic.gdx.Gdx;
import com.vittach.couriers.controllers.InputListener;

import java.util.HashSet;

public class Engine {
    public static boolean sessionChecker = false;
    public static int width =Gdx.graphics.getWidth();
    public static int height=Gdx.graphics.getHeight();
    public static int Width, Height, screenX = 539, screenY = 800;
    public static HashSet<Integer>usedID = new HashSet<Integer>();
    public static InputListener inputListener=new InputListener();

    static void setHeight(int height1, int height2) {
        height = height1;
        Height = height2;
    }

    static void setWidth ( int width1, int width2 ) {
        width = width1;
        Width = width2;
    }
}
