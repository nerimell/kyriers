package com.vittach.couriers.ScreensMenu;

import com.vittach.couriers.myShell.*;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.ethernet.httpRequest;
import com.vittach.couriers.interfaces.ProcessorInput;
import com.vittach.couriers.simpleEngine.MyEngine;

import java.util.Map;
import java.util.HashMap;

/**
 * Created by User on 16.09.2016.
 */
public class MyStatus extends Stage implements ProcessorInput {

    public int DWNKey= -1;

    private Sprite sprite;
    private MyImage background;
    private Sprite navbarSprite;
    private SpriteBatch spriteBatch;

    public MovingMenu leftMovingMenu;

    public ToggleButton zaniat;
    public ToggleButton otoshel;
    public ToggleButton svoboden;
    public ScreenButton navBarButton;

    @Override
    public void setIDOffset(int id){}

    @Override
    public boolean touchUp(int x, int y, int id, int b) {
        if (navBarButton.MyTouch_Down(x,y))
        {
            if (leftMovingMenu.movingMenuDirection > 0) {
                leftMovingMenu.movingMenuDirection =-1;
                leftMovingMenu.isMovingMenu = true;
                DWNKey=9;
            }
            else
            if (leftMovingMenu.movingMenuDirection < 0) {
                leftMovingMenu.movingMenuDirection = 1;
                leftMovingMenu.isMovingMenu = true;
                DWNKey=8;
            }
        }
        else
            leftMovingMenu.closingByTouch(x, y);

        if (leftMovingMenu.buttonArray.get(0).MyTouch_Down(x, y) == true) {
            leftMovingMenu.hideMovingMenu();
            DWNKey=1;
        }
        if (leftMovingMenu.buttonArray.get(1).MyTouch_Down(x, y) == true) {
            leftMovingMenu.hideMovingMenu();
            DWNKey=2;
        }
        if (leftMovingMenu.buttonArray.get(2).MyTouch_Down(x, y) == true) {
            leftMovingMenu.hideMovingMenu();
            DWNKey=3;
        }
        if (leftMovingMenu.buttonArray.get(3).MyTouch_Down(x, y) == true) {
            leftMovingMenu.hideMovingMenu();
            DWNKey=4;
        }
        if (leftMovingMenu.buttonArray.get(4).MyTouch_Down(x, y) == true) {
            httpRequest request = new httpRequest(MyEngine.baseURL + "auth/appLogout");
            request.sendRequest(new HashMap(), "GET");
            leftMovingMenu.hideMovingMenu();
            DWNKey=5;
        }


        //if leftMovingMenu is closing
        if(leftMovingMenu.movingMenuDirection<0) {
            if (svoboden.MyTouch_Down(x, y)) {
                zaniat.backgrn= false;
                otoshel.backgrn = false;
                /*
                Map parameters=new HashMap();
                parameters.put("login", "");

                httpRequest request = new httpRequest(MyEngine.baseURL + "auth/appRegistration");
                request.sendRequest(parameters, "POST");
                */
            }
            if (otoshel.MyTouch_Down(x, y)) {
                zaniat.backgrn= false;
                svoboden.backgrn = false;
                /*
                Map parameters=new HashMap();
                parameters.put("login", "");

                httpRequest request = new httpRequest(MyEngine.baseURL + "auth/appRegistration");
                request.sendRequest(parameters, "POST");
                */
            }
            if (zaniat.MyTouch_Down(x, y)) {
                svoboden.backgrn= false;
                otoshel.backgrn = false;
                /*
                Map parameters=new HashMap();
                parameters.put("login", "");

                httpRequest request = new httpRequest(MyEngine.baseURL + "auth/appRegistration");
                request.sendRequest(parameters, "POST");
                */
            }
        }

        return true;
    }

    public MyStatus(MovingMenu leftMovingMenu, Sprite navbarSprite, ScreenButton navBarButton) {
        this.navbarSprite= navbarSprite;
        this.navBarButton= navBarButton;
        sprite = new Sprite();
        spriteBatch = new SpriteBatch();

        background = new MyImage();
        background.load("ui/background.png");

        //--------------------------------------svoboden----------------------------------------------------------------
        svoboden = new ToggleButton();
        svoboden.choice = new MyImage();
        svoboden.choice.load("ui/startchoi.png");
        svoboden.background.load("ui/startbuts.png");
        svoboden.font = MyEngine.textFont28;
        svoboden.itext = "Свободен";
        svoboden.textY = 31;
        svoboden.textX = 70;
        svoboden.Position(Engine.screenX / 2 - svoboden.background.getWidth() / 2, Engine.screenY - 200);
        svoboden.accept();
        //--------------------------------------svoboden---------------------------------------------------------------/

        //--------------------------------------zaniat------------------------------------------------------------------
        zaniat = new ToggleButton();
        zaniat.choice = new MyImage();
        zaniat.choice.load("ui/startchoi.png");
        zaniat.background.load("ui/startbuts.png");
        zaniat.font = MyEngine.textFont28;
        zaniat.itext = "Занят";
        zaniat.textY = 31;
        zaniat.textX = 70;
        zaniat.Position(Engine.screenX / 2 - svoboden.background.getWidth() / 2, Engine.screenY - 250);
        zaniat.accept();
        //--------------------------------------zaniat-----------------------------------------------------------------/

        //--------------------------------------zaniat------------------------------------------------------------------
        otoshel = new ToggleButton();
        otoshel.choice = new MyImage();
        otoshel.choice.load("ui/startchoi.png");
        otoshel.background.load("ui/startbuts.png");
        otoshel.font = MyEngine.textFont28;
        otoshel.itext = "Отошел";
        otoshel.textY = 31;
        otoshel.textX = 70;
        otoshel.Position(Engine.screenX / 2 - svoboden.background.getWidth() / 2, Engine.screenY - 300);
        otoshel.accept();
        //--------------------------------------zaniat-----------------------------------------------------------------/


        this.leftMovingMenu = leftMovingMenu;

        sprite = background.flip();
    }

    public void Display(Viewport view) {

        view.apply();
        spriteBatch.setProjectionMatrix(view.getCamera().combined);

        spriteBatch.begin();
        sprite.draw(spriteBatch);
        navbarSprite.draw(spriteBatch);
        navBarButton.draw(spriteBatch);
        zaniat.draw(spriteBatch);
        otoshel.draw(spriteBatch);
        svoboden.draw(spriteBatch);
        spriteBatch.end();

        setViewport(view);
        draw();

        spriteBatch.begin();
        leftMovingMenu.draw(spriteBatch);
        spriteBatch.end();
    }

    public void dispose() {
        spriteBatch.dispose();
        background.dispose();
        super.dispose();
    }
}
