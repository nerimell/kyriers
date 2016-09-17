package com.vittach.couriers.ScreensMenu;

import com.badlogic.gdx.Gdx;
import com.vittach.couriers.myShell.*;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.scenes.scene2d.ui.Skin;
import com.vittach.couriers.simpleEngine.Engine;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.badlogic.gdx.scenes.scene2d.ui.Dialog;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ProcessorInput;

import java.util.ArrayList;

/**
 * Created by User on 16.09.2016.
 */
public class MyPin extends Stage implements ProcessorInput {

    public int DWNKey= -1;

    private Sprite sprite;
    private MyImage background;
    private SpriteBatch spriteBatch;

    private String pinCode= "";

    private Dialog errorwindow;

    public ArrayList<ToggleButton> pincircles;
    public ArrayList<ScreenButton> circlebuttons;

    @Override
    public void setIDOffset(int id){}

    void clearAllCircle() {
        ToggleButton lol;
        for(int i=0;i<pincircles.size();i++) {
            lol = pincircles.get(i);
            lol.backgrn = false;
            pincircles.set(i, lol);
        }
        pinCode = "";
    }

    void addCircle() {
        ToggleButton lol=pincircles.get(pinCode.length());
        lol.backgrn = true;
        pincircles.set(pinCode.length(),lol);
    }

    void removeCircle() {
        ToggleButton lol=pincircles.get(pinCode.length());
        lol.backgrn = false;
        pincircles.set(pinCode.length(),lol);
    }

    private void errorWindowDialog() {
        Skin uiskinjson = new Skin(Gdx.files.internal("uiskin.json"));
        errorwindow = new Dialog("Исключение", uiskinjson, "default"){
            @Override
            public void result(Object ob) {
                clearAllCircle();
                errorwindow.remove();
                DWNKey = 9;
                errorWindowDialog ();
            }
        };
        errorwindow.text("Проверьте правильность пинкода\n и повторите попытку снова");
        errorwindow.button("Хорошо, я обязательно исправлюсь!", true);
        errorwindow.setSize(345,100);
        errorwindow.setPosition(Engine.screenX/2-errorwindow.getWidth()/2,300);
    }

    @Override
    public boolean touchUp(int x,int y,int id,int b){
        super.touchUp(x, y, id, b);
        for(int i = 0; i < circlebuttons.size(); i++)
        if (circlebuttons.get(i).MyTouch_Down(x,y)) {
            if(pinCode.length()<4) {
                if (i < 9) {
                    addCircle();
                    pinCode += String.valueOf(i + 1);
                } else if (i == 9) {
                    addCircle();
                    pinCode += "0";
                } else if (i == 10) {
                    if (pinCode.length() > 0) {
                        pinCode = pinCode.substring(0, pinCode.length() - 1);
                        removeCircle();
                    }
                } else if (i == 11) {
                    DWNKey = 2;
                }
                if(pinCode.length() == 4) {
                    if (MyEngine.user.getPin().equals(pinCode))
                        DWNKey = 1;
                    else {
                        addActor(errorwindow);
                        DWNKey = 8;
                    }
                }
            }
        }
        return true;
    }

    public MyPin() {
        sprite = new Sprite();
        spriteBatch = new SpriteBatch();

        errorWindowDialog();

        background = new MyImage();
        background.load("ui/background.png");

        pincircles = new ArrayList<ToggleButton>();
        circlebuttons = new ArrayList<ScreenButton>();

        int i = 0, j = 0;
        for(int k = 0; k < 4; k++) {
            ToggleButton circlepin=new ToggleButton();
            circlepin.choice = new MyImage();
            circlepin.choice.load("ui/pincircleactive.png");
            circlepin.background.load("ui/pincircle.png");
            circlepin.Position(k * (circlepin.background.getWidth() + 30) + 165, Engine.screenY - 120);
            circlepin.accept();
            pincircles.add(circlepin);
        }

        for(int k = 1; k < 13; k++) {
            ScreenButton circlebutton=new ScreenButton();
            circlebutton.choice = new MyImage();
            if(k<11) {
                circlebutton.choice.load("ui/circlebuttchoice.png");
                circlebutton.background.load("ui/circlebutton.png");
            }
            else if(k==11) {
                circlebutton.choice.load("ui/circlebackchoice.png");
                circlebutton.background.load("ui/circlebacks.png");
            }
            else if(k==12) {
                circlebutton.choice.load("ui/homescreenchoise.png");
                circlebutton.background.load("ui/homescreen.png");
            }
            if(k<10) {
                circlebutton.font = MyEngine.textFont72;
                circlebutton.itext = String.valueOf(k);
            }
            else if(k==10) {
                circlebutton.font = MyEngine.textFont72;
                circlebutton.itext = String.valueOf(0);
            }
            circlebutton.textY = 75;
            circlebutton.textX = 32;
            if(k<10)
                circlebutton.Position(i * (circlebutton.background.getWidth() + 50) + 69, Engine.screenY - 300 - j * (circlebutton.background.getHigh() + 50));
            else if(k==10||k==11)
                circlebutton.Position((i+1)*(circlebutton.background.getWidth()+50) + 69, Engine.screenY - 300 - j * (circlebutton.background.getHigh() + 50));
            else
                circlebutton.Position(69, Engine.screenY - 300 - j * (circlebutton.background.getHigh() + 50));
            circlebutton.accept();
            circlebuttons.add(circlebutton);
            if (i%2 == 0 && i > 0) {
                i = 0;
                j++;
            } else
                i++;
        }

        background.fontPrint(MyEngine.textFont28,165,Engine.screenY-40,"Введите пин-код",new MyColor(1,0,0,1));
        sprite = background.flip();
    }

    public void Display(Viewport view) {

        view.apply();
        spriteBatch.setProjectionMatrix(view.getCamera().combined);

        spriteBatch.begin();
        sprite.draw(spriteBatch);
        for(ScreenButton scrb:circlebuttons)
            scrb.draw(spriteBatch);
        for(ScreenButton scrb:pincircles)
            scrb.draw(spriteBatch);
        spriteBatch.end();

        setViewport(view);
        act();
        draw();
    }

    public void dispose() {
        circlebuttons.clear();
        spriteBatch.dispose();
        background.dispose();
        pincircles.clear();
        super.dispose();
    }
}
