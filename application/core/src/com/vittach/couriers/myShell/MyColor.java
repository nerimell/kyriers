package com.vittach.couriers.myShell;
import com.badlogic.gdx.graphics.Color;

public class MyColor {
    private Color clr;

    public MyColor
    (float x, float y, float z, float a) {
        clr = new Color(x, y, z, a);
    }

    public Color color() {
        return clr;
    }
}
