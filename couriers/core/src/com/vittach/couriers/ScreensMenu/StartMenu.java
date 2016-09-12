package com.vittach.couriers.ScreensMenu;

import java.util.Map;
import java.util.HashMap;
import java.io.IOException;

import com.badlogic.gdx.Gdx;
import com.vittach.couriers.myShell.MyFont;
import com.vittach.couriers.myShell.MyImage;
import com.vittach.couriers.myShell.MyColor;
import com.badlogic.gdx.utils.JsonValue;
import com.vittach.couriers.myShell.ScreenButton;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.badlogic.gdx.utils.JsonReader;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.ethernet.httpRequest;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.badlogic.gdx.scenes.scene2d.ui.TextField;
import com.vittach.couriers.interfaces.ProcessorInput;
import com.badlogic.gdx.scenes.scene2d.utils.TextureRegionDrawable;

public class StartMenu extends Stage implements ProcessorInput {

    private Sprite sprite;
    public int DWNKey = -1;
    private MyFont textFont;
    private MyColor textColor;

    private MyImage cursor;
    private MyImage iSElector;
    private MyImage textfield;
    private MyImage backgound;

    public TextField passField;
    public TextField loginField;

    private httpRequest request;
    private String resultRequest;

    public ScreenButton loginButton;
    private SpriteBatch spriteBatch;

    @Override
    public void setIDOffset(int s){}

    @Override
    public boolean touchUp(int x, int y, int id, int b) {
        if (loginButton.MyTouch_Down(x, y)) {
            if (getLogin().length() > 3 && getPassword().length() > 3) {
                Map parameters = new HashMap();
                MyEngine.user.setUserName(getLogin());
                MyEngine.user.setPassword( getPassword());
                parameters.put("username", getLogin());
                parameters.put("password", getPassword());

                if(!Engine.sessionChecker) {
                    request = new httpRequest("http://tz.app-labs.ru/auth/AppAuth");
                    resultRequest = request.sendRequest(parameters,"POST");
                    System.out.println("JSON="+resultRequest);
                    Engine.sessionChecker=true;
                }
                else {
                    request.urlSite = "http://tz.app-labs.ru/auth/checker";
                    request.sendRequest(new HashMap(), "GET");
                }

                if (resultRequest.equals("failed") == false) {
                    JsonValue root = new JsonReader().parse(resultRequest);
                    if (root.getBoolean("result")) {
                        Gdx.input.setOnscreenKeyboardVisible(false);
                        MyEngine.user.setId (root.getInt("userId"));
                        passField.setText("");
                        DWNKey = 1;
                    } else
                        loginField.setText(" Ой чето ты мне не знаком");
                } else
                    loginField.setText(" Проверьте WiFi пожалуйста");
            }
            else {
                if (getPassword().length() < 4)
                    passField.setMessageText(" пароль короче 4 букв");
                if (getLogin().length() < 4)
                    loginField.setMessageText(" логин короче 4 букв");
            }
        }
        return true;
    }

    public void Display(Viewport view) {
        view.apply();
        spriteBatch.setProjectionMatrix(view.getCamera().combined);
        spriteBatch.begin();
        sprite.draw(spriteBatch);
        loginButton.draw(spriteBatch);
        spriteBatch.end();
        setViewport(view);
        draw();
    }

    public StartMenu() throws IOException {
        sprite = new Sprite();

        cursor = new MyImage();
        cursor.load("ui/cursor.png");

        textFont = new MyFont();
        textFont.load("arial.ttf");
        textFont.setPixelSizes(28);

        spriteBatch = new SpriteBatch();
        textColor= new MyColor(1,1,1,1);

        iSElector = new MyImage();
        iSElector.load("ui/iselector.png");

        textfield = new MyImage();
        textfield.load("ui/textField.png");

        backgound = new MyImage();
        backgound.load("ui/background.png");

        TextField.TextFieldStyle
                textFieldStyle = new TextField.TextFieldStyle(
                textFont.get_font(), textColor.color(),
                new TextureRegionDrawable(cursor.flip()),
                new TextureRegionDrawable(iSElector.flip()),
                new TextureRegionDrawable(textfield.flip())
        );

        loginField = new TextField("", textFieldStyle);
        loginField.setTextFieldListener(new TextField.TextFieldListener(){
            @Override
            public void keyTyped(TextField textField1, char key) {
                if (loginField.getText().length() <2) {
                    loginField.setText(" " + key);
                    loginField.setCursorPosition(2);
                }
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        passField = new TextField("", textFieldStyle);
        passField.setTextFieldListener(new TextField.TextFieldListener() {
            @Override
            public void keyTyped(TextField textField1, char key) {
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        //--------------------------------------loginButton------------------------------------------------------------
        loginButton = new ScreenButton();
        loginButton.choice = new MyImage();
        loginButton.choice.load("ui/startchoi.png");
        loginButton.background.load("ui/startbuts.png");
        loginButton.font = textFont;
        loginButton.itext = "Залогиниться";
        loginButton.textY = 31;
        loginButton.textX = 80;
        loginButton.Position(Engine.screenX / 2 - loginButton.background.getWidth() / 2, Engine.screenY - 200);
        loginButton.accept();
        //--------------------------------------loginButton-----------------------------------------------------------/

        loginField.setMessageText(" Введите логин");
        loginField.setPosition(Engine.screenX/ 2 - textfield.getWidth() / 2, Engine.screenY - 100);
        loginField.setSize(textfield.getWidth(),textfield.getHigh());
        loginField.setAlignment(1);

        passField.setMessageText(" Введите пароль");
        passField.setPosition(Engine.screenX / 2 - textfield.getWidth() / 2, Engine.screenY - 150);
        passField.setSize(textfield.getWidth(), textfield.getHigh());
        passField.setPasswordCharacter('*');
        passField.setPasswordMode(true);
        passField.setAlignment(1);

        sprite = backgound.flip();

        addActor(loginField);
        addActor(passField);
    }

    public String getPassword() {
        int length = passField.getText().length();
        return length > 0 ? passField.getText(): "";
    }

    public String getLogin() {
        int length =loginField.getText().length();
        return length > 0 ? loginField.getText().substring(1,length): "";
    }

    public void dispose() {
        spriteBatch.dispose();
        loginButton.dispose();
        iSElector.dispose();
        textfield.dispose();
        backgound.dispose();
        textFont.dispose();
        cursor.dispose();
    }
}
