package com.vittach.couriers.ScreensMenu;

import com.badlogic.gdx.graphics.g2d.Sprite;
import com.vittach.couriers.myShell.MyImage;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.vittach.couriers.myShell.MovingMenu;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.myShell.ScreenButton;
import com.vittach.couriers.interfaces.ProcessorInput;

/**
 * Created by User on 12.09.2016.
 */
public class MyAdvert extends Stage implements ProcessorInput {

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
        if (leftMovingMenu.buttonArray.get(3).MyTouch_Down(x, y) == true) {
            leftMovingMenu.hideMovingMenu();
            DWNKey=4;
        }
        return true;
    }

    public MyAdvert(MovingMenu leftMovingMenu, Sprite navbarSprite, ScreenButton navBarButton) {
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
    }
}
