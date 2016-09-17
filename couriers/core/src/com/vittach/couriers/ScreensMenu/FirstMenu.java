package com.vittach.couriers.ScreensMenu;

import com.vittach.couriers.myShell.MyImage;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.vittach.couriers.myShell.MovingMenu;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.myShell.ScreenButton;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.ethernet.httpRequest;
import com.vittach.couriers.interfaces.ProcessorInput;
import com.vittach.couriers.simpleEngine.MyEngine;

import java.util.HashMap;

public class FirstMenu extends Stage implements ProcessorInput {

    public int DWNKey= -1;
    private Sprite sprite;
    private MyImage background;
    private Sprite navbarSprite;
    private SpriteBatch spriteBatch;
    public MovingMenu leftMovingMenu;
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
            }
            else
            if (leftMovingMenu.movingMenuDirection < 0) {
                leftMovingMenu.movingMenuDirection = 1;
                leftMovingMenu.isMovingMenu = true;
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
        return true;
    }

    public FirstMenu(MovingMenu leftMovingMenu, Sprite navbarSprite, ScreenButton navBarButton) {
        this.navbarSprite= navbarSprite;
        this.navBarButton= navBarButton;
        sprite = new Sprite();
        spriteBatch = new SpriteBatch();

        background = new MyImage();
        background.load("ui/background.png");

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
        leftMovingMenu.draw(spriteBatch);
        spriteBatch.end();

        setViewport(view);
        draw();
    }

    public void dispose() {
        spriteBatch.dispose();
        background.dispose();
        super.dispose();
    }
}
