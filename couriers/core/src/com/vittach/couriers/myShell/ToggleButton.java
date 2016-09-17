package com.vittach.couriers.myShell;

/**
 * Created by User on 16.09.2016.
 */
public class ToggleButton extends ScreenButton {

    @Override
    public boolean
    mouseMoved(int scrx,int scry) {
        return true;
    }

    @Override
    public boolean MyTouch_Down(int xops, int ypos, int id) {
        if(super.MyTouch_Down(xops, ypos, id)) {
            if(backgrn==true)
                backgrn=false;
            else backgrn=true;
            return true;
        }
        return false;
    }
}
