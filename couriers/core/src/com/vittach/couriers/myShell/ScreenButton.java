package com.vittach.couriers.myShell;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.vittach.couriers.simpleEngine.Engine;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.controllers.InputListener;

/**
 * Created by ZHARIKOV VITALIY at 12.02.2016.
 */

public class ScreenButton extends InputListener {
    public MyFont font;
    public String itext;
    public MyColor icolor;
    public MyImage choice;
    public boolean backgrn;
    public int x = 0, y = 0;
    public int textX, textY;
    protected Sprite sprite1;
    protected Sprite sprite2;
    public MyImage background;

    public ScreenButton() {
        font = new MyFont();
        background = new MyImage();
        icolor = new MyColor(1, 1,1,1);
    }

    @Override
    public boolean
    mouseMoved(int scrx,int scry) {
        if (choice != null) {
        if (MyTouch_Down(scrx,scry,-1))
            backgrn = true;
            else
            backgrn =false;
        }
        return true;
    }

    @Override
    public boolean touchDragged(int xpos, int ypos, int ID) {
        mouseMoved(xpos, ypos);
        return true;
    }

    public boolean MyTouch_Down(int my_xposi, int my_yposi) {
        return MyTouch_Down(my_xposi, my_yposi, 0);
    }

    public boolean MyTouch_Down(int xops, int ypos, int id) {
        float scalex = Engine.width /  (float) Engine.screenX;
        float scaley = Engine.height / (float) Engine.screenY;
        xops -= (Engine.Width - Engine.width) / 2;
        ypos -= (Engine.Height - Engine.height) / 2;

        if (xops >= x * scalex && xops <= x * scalex + background.getWidth()
        *scalex&&ypos >= (Engine.height - y * scaley) - background.getHigh()
           * scaley && ypos <= (Engine.height - y * scaley)) {
            return true;
        }
        else return false;
    }

    //отображение кнопки на экране
    public void draw(SpriteBatch sprteBatch) {
        sprite1.setPosition(x,y);
        if(choice!=null)
        sprite2.setPosition(x,y);
        if(!backgrn||choice==null)
        sprite1.draw(sprteBatch);
        else
        sprite2.draw(sprteBatch);
    }

    public void accept()
    {
        if (itext!=null)
        background.fontPrint(font,textX,textY, itext, icolor);
        sprite1=background.flip();
        if(choice!=null)
        {
        if (itext!=null)
            choice.fontPrint(font,textX,textY, itext, icolor);
            sprite2=choice.flip();
        }
    }

    //установка позиции кнопки
    public void Position(int xpos, int ypos) {
        this.x = xpos;
        this.y = ypos;
    }

    public void dispose() {
        background.dispose();
        if(choice!= null)
        choice.dispose();
    }
}
