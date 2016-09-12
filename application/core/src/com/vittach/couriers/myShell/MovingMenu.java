package com.vittach.couriers.myShell;

import java.util.ArrayList;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.controllers.InputListener;
import com.vittach.couriers.simpleEngine.Engine;

/**
 * Created by VITTACH on 04.09.2016.
 */
public class MovingMenu extends InputListener {

    private Sprite isprite;
    private boolean allButton;
    public MyImage background;
    public int velocity, x=0, y=0;
    public boolean isMovingMenu = false;
    public int movingMenuDirection = -1;
    public ArrayList<ScreenButton> buttonArray;
    private float scalx= Engine.width /(float)Engine.screenX;
    private float scaly= Engine.height/(float)Engine.screenY;

    public MovingMenu() {
    background = new MyImage();
    buttonArray= new ArrayList<ScreenButton>();
    }

    @Override
    public boolean
    mouseMoved(int screenx,int screeny){
        allButton = true;
        for(ScreenButton scrbutton:buttonArray)
            allButton=allButton&&scrbutton.mouseMoved(screenx, screeny);
        return true;
    }

    @Override
    public boolean touchDragged(int xpos, int ypos, int id) {
        allButton = true;
        for(ScreenButton scrbutton:buttonArray)
            allButton=allButton&&scrbutton.touchDragged(xpos, ypos, id);
        return true;
    }

    @Override
    public boolean touchDown(int xpos,int ypos,int p,int id){
        allButton = true;
        for(ScreenButton scrbutton:buttonArray)
            allButton = allButton && scrbutton.MyTouch_Down(xpos, ypos);
        return true;
    }

    public void closingByTouch(int xpos, int ypos) {
        if (xpos > (x + background.getWidth()) * scalx && Engine.height - ypos < (y + background.getHigh()) * scaly) {
            if (movingMenuDirection > 0) {
                movingMenuDirection = -1;
                isMovingMenu = true;
            }
        }
    }

    public void openMovingMenu() {
        isMovingMenu = false;
        for (int i = 0; i<buttonArray.size(); i++) {
            ScreenButton button= buttonArray.get(i);
            button.x = 0;
            buttonArray.set(i,button);
        }
        x=0;
    }

    public void hideMovingMenu() {
        isMovingMenu = false;
        movingMenuDirection = -1;

        for (int i = 0; i<buttonArray.size(); i++) {
            ScreenButton button= buttonArray.get(i);
            button.x = -background.getWidth();
            buttonArray.set(i,button);
        }
        x=-background.getWidth();
        isprite.setX(x);
    }

    public void moving() {
        if(movingMenuDirection > 0)
            if (x + velocity < 0) {
                x += velocity;
                for (int i=0;i<buttonArray.size();i++) {
                    ScreenButton button= buttonArray.get(i);
                    button.x += velocity;
                    buttonArray.set(i,button);
                }
            } else openMovingMenu();
        if(movingMenuDirection < 0)
            if (x > -background.getWidth()) {
                x -= velocity;
                for (int i=0;i<buttonArray.size();i++) {
                    ScreenButton button= buttonArray.get(i);
                    button.x -= velocity;
                    buttonArray.set(i,button);
                }
            } else hideMovingMenu();
    }

    public void draw(SpriteBatch spr) {
        if (isprite==null){
            isprite= background.flip();
            isprite.setX(x);
        }
        else
        if (isMovingMenu) {
            moving();
            isprite.setX(x);
        }
        isprite.draw(spr);
        for(ScreenButton s:buttonArray)
            s.draw(spr);
    }

    public void dispose() {
        background.dispose();
        buttonArray.clear();
    }
}
