package com.vittach.couriers.ScreensMenu;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.scenes.scene2d.ui.*;
import com.vittach.couriers.myShell.*;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Actor;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.ethernet.httpRequest;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ProcessorInput;
import com.badlogic.gdx.scenes.scene2d.utils.ChangeListener;
import com.badlogic.gdx.scenes.scene2d.utils.TextureRegionDrawable;

import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Collections;

/**
 * Created by User on 16.09.2016.
 */
public class Registration extends Stage implements ProcessorInput {

    public int DWNKey= -1;

    private Sprite sprite;
    private Sprite navbarSprite;
    private SpriteBatch spriteBatch;

    private int errorcode;
    private String errorstring = "";

    public MovingMenu leftMovingMenu;

    private MyImage cursor;
    private MyImage iSElector;
    private MyImage textfield;
    private MyImage background;
    private MyImage combofield;

    private MyColor textColor;

    private TextField myCity;

    private Dialog errorwindow;

    public TextField emailField;
    public TextField passField1;
    public TextField passField2;
    public TextField loginField;

    private boolean comboBoxVisible;

    private SelectBox myCitySelectBox;

    public ScreenButton navBarButton;
    public ScreenButton combobuttonCity;
    public ScreenButton registrationButton;

    ArrayList<String> listSelectBox;
    ArrayList<String> listForCombBox;

    @Override
    public void setIDOffset(int id){}

    @Override
    public boolean touchUp(int x, int y, int id, int b) {
        super.touchUp(x,y,id,b);
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
            if (combobuttonCity.MyTouch_Down(x, y)) {
                if (comboBoxVisible==false) {
                    comboBoxVisible = true;
                    myCitySelectBox.showList();
                } else {
                    comboBoxVisible = false;
                    myCitySelectBox.hideList();
                }
            }

            if (registrationButton.MyTouch_Down(x, y)) {
                if(getLogin().length() < 4) {
                    errorstring="Длина логина менее 4 симовлов";
                    errorWindowDialog();
                    addActor(errorwindow);
                    errorcode = 1;
                    DWNKey = 8;
                }
                else if(getPass1().equals(getPass2())) {
                    Map parameters = new HashMap();
                    parameters.put("login", getLogin());
                    parameters.put("email", getEmail());
                    parameters.put("password1", getPass1());
                    parameters.put("password2", getPass2());
                    parameters.put("city", "5");

                    httpRequest request = new httpRequest(MyEngine.baseURL + "auth/appRegistration");
                    request.sendRequest(parameters, "POST");
                }
                else {
                    errorstring="Введенные пароли не совпадают";
                    errorWindowDialog();
                    addActor(errorwindow);
                    errorcode = 0;
                    DWNKey = 8;
                }
            }
        }


        return true;
    }

    private void errorWindowDialog() {
        Skin uiskinjson = new Skin(Gdx.files.internal("uiskin.json"));
        errorwindow = new Dialog("Исключение", uiskinjson, "default"){
            @Override
            public void result(Object ob) {
                errorwindow.remove();
                switch (errorcode) {
                    case 0:
                        passField1.setText("");
                        passField2.setText("");
                        break;
                }
                DWNKey=9;
            }
        };
        errorwindow.text(errorstring);
        errorwindow.button("Хорошо, я обязательно исправлюсь!", true);
        errorwindow.setSize(textfield.getWidth(),100);
        errorwindow.setPosition(Engine.screenX/2-errorwindow.getWidth()/2,300);
    }

    public Registration(MovingMenu leftMovingMenu, Sprite navbarSprite, ScreenButton navBarButton) {

        sprite = new Sprite();
        spriteBatch = new SpriteBatch();

        this.navbarSprite= navbarSprite;
        this.navBarButton= navBarButton;

        cursor = new MyImage();
        cursor.load("ui/cursor.png");

        textColor= new MyColor(1,1,1,1);

        combofield = new MyImage();
        combofield.load("ui/combobox.png");

        iSElector = new MyImage();
        iSElector.load("ui/iselector.png");

        textfield = new MyImage();
        textfield.load("ui/textField.png");

        background = new MyImage();
        background.load("ui/background.png");

        listForCombBox = new ArrayList<String>();

        SelectBox.SelectBoxStyle boxStyle = new SelectBox.SelectBoxStyle();
        boxStyle.font = MyEngine.textFont28.get_font();
        boxStyle.fontColor = textColor.color();
        boxStyle.background = new TextureRegionDrawable(combofield.flip());
        boxStyle.scrollStyle = new ScrollPane.ScrollPaneStyle();
        boxStyle.scrollStyle.background=new TextureRegionDrawable(combofield.flip());
        boxStyle.listStyle = new List.ListStyle();
        boxStyle.listStyle.font = MyEngine.textFont28.get_font();
        boxStyle.listStyle.fontColorSelected = textColor.color();
        boxStyle.listStyle.fontColorUnselected = textColor.color();
        boxStyle.listStyle.selection = new TextureRegionDrawable(combofield.flip());
        boxStyle.listStyle.background= new TextureRegionDrawable(combofield.flip());

        listSelectBox = new ArrayList<String>();
        String[] citiesArray = new String[]{"Slow", "Medium", "Fast", "Fastest", "Lastest"};
        for(String str:citiesArray)
            listSelectBox.add(str);
        myCitySelectBox = new SelectBox(boxStyle);
        myCitySelectBox.setItems(listSelectBox.toArray());

        //--------------------------------------combobuttonCity---------------------------------------------------------
        combobuttonCity = new ScreenButton();
        combobuttonCity.background.load("ui/combobutton.png");
        combobuttonCity.Position(Engine.screenX- combobuttonCity.background.getWidth(), Engine.screenY-400);
        combobuttonCity.accept();
        //--------------------------------------combobuttonCity--------------------------------------------------------/

        //--------------------------------------registrationButton------------------------------------------------------
        registrationButton = new ScreenButton();
        registrationButton.choice = new MyImage();
        registrationButton.choice.load("ui/startchoi.png");
        registrationButton.background.load("ui/startbuts.png");
        registrationButton.font = MyEngine.textFont28;
        registrationButton.itext = "Зарегистрироваться";
        registrationButton.textY = 31;
        registrationButton.textX = 40;
        registrationButton.Position(Engine.screenX / 2 - registrationButton.background.getWidth() / 2, Engine.screenY - 450);
        registrationButton.accept();
        //--------------------------------------registrationButton-----------------------------------------------------/

        myCitySelectBox.addListener(new ChangeListener() {
            @Override
            public void changed(ChangeEvent event, Actor actor) {
                myCity.setText(myCitySelectBox.getSelected().toString());
            }
        });

        TextField.TextFieldStyle
                textFieldStyle = new TextField.TextFieldStyle(
                MyEngine.textFont28.get_font(), textColor.color(),
                new TextureRegionDrawable(cursor.flip()),
                new TextureRegionDrawable(iSElector.flip()),
                new TextureRegionDrawable(textfield.flip())
        );

        myCity = new TextField("", textFieldStyle);
        myCity.setTextFieldListener(new TextField.TextFieldListener(){
            @Override
            public void keyTyped(TextField textField1, char key) {
                if (myCity.getText().length() <2) {
                    myCity.setText(" " + key);
                    myCity.setCursorPosition(2);
                }
                listForCombBox.clear();
                for(String str : listSelectBox)
                    if(String.valueOf(key).compareTo(str.toLowerCase()) <= 0)
                        listForCombBox.add(str);
                Collections.sort(listForCombBox);
                if(listForCombBox.size()> 0)
                    myCitySelectBox.setItems(listForCombBox.toArray());
                myCitySelectBox.showList();
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        emailField = new TextField("", textFieldStyle);
        emailField.setTextFieldListener(new TextField.TextFieldListener(){
            @Override
            public void keyTyped(TextField textField1, char key) {
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        loginField = new TextField("", textFieldStyle);
        loginField.setTextFieldListener(new TextField.TextFieldListener(){
            @Override
            public void keyTyped(TextField textField1, char key) {
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        passField1 = new TextField("", textFieldStyle);
        passField1.setTextFieldListener(new TextField.TextFieldListener() {
            @Override
            public void keyTyped(TextField textField1, char key) {
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        passField2 = new TextField("", textFieldStyle);
        passField2.setTextFieldListener(new TextField.TextFieldListener() {
            @Override
            public void keyTyped(TextField textField1, char key) {
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        loginField.setMessageText(" Введите логин");
        loginField.setPosition(Engine.screenX/ 2 - textfield.getWidth() / 2, Engine.screenY - 200);
        loginField.setSize(textfield.getWidth(),textfield.getHigh());
        loginField.setAlignment(1);

        emailField.setMessageText(" Введите Email");
        emailField.setPosition(Engine.screenX/ 2 - textfield.getWidth() / 2, Engine.screenY - 250);
        emailField.setSize(textfield.getWidth(),textfield.getHigh());
        emailField.setAlignment(1);

        passField1.setMessageText(" Введите пароль");
        passField1.setPosition(Engine.screenX / 2 - textfield.getWidth() / 2, Engine.screenY - 300);
        passField1.setSize(textfield.getWidth(), textfield.getHigh());
        passField1.setPasswordCharacter('*');
        passField1.setPasswordMode(true);
        passField1.setAlignment(1);

        passField2.setMessageText(" Повторите пароль");
        passField2.setPosition(Engine.screenX / 2 - textfield.getWidth() / 2, Engine.screenY - 350);
        passField2.setSize(textfield.getWidth(), textfield.getHigh());
        passField2.setPasswordCharacter('*');
        passField2.setPasswordMode(true);
        passField2.setAlignment(1);

        myCitySelectBox.setPosition(Engine.screenX / 2 - textfield.getWidth() / 2, Engine.screenY - 400);
        myCitySelectBox.setSize(combofield.getWidth(), combofield.getHigh());

        myCity.setMessageText(" Введите свой город");
        myCity.setPosition(Engine.screenX / 2 - textfield.getWidth() / 2, Engine.screenY - 400);
        myCity.setSize(textfield.getWidth(), textfield.getHigh());
        myCity.setAlignment(1);

        this.leftMovingMenu = leftMovingMenu;

        sprite = background.flip();

        addActor(myCitySelectBox);
        addActor(myCity);
        addActor(emailField);
        addActor(loginField);
        addActor(passField1);
        addActor(passField2);
    }

    public String getLogin() {
        int length =loginField.getText().length();
        return length > 0 ? loginField.getText(): "";
    }

    public String getEmail() {
        int length =emailField.getText().length();
        return length > 0 ? emailField.getText(): "";
    }

    public String getPass1() {
        int length =passField1.getText().length();
        return length > 0 ? passField1.getText(): "";
    }

    public String getPass2() {
        int length =passField2.getText().length();
        return length > 0 ? passField2.getText(): "";
    }

    public String getCity() {
        int length =myCity.getText().length();
        return length > 0 ? myCity.getText(): "";
    }

    public void Display(Viewport view) {

        view.apply();
        spriteBatch.setProjectionMatrix(view.getCamera().combined);

        spriteBatch.begin();
        sprite.draw(spriteBatch);
        navbarSprite.draw(spriteBatch);
        navBarButton.draw(spriteBatch);
        combobuttonCity.draw(spriteBatch);
        registrationButton.draw(spriteBatch);
        spriteBatch.end();

        setViewport(view);
        act();
        draw();

        spriteBatch.begin();
        leftMovingMenu.draw(spriteBatch);
        spriteBatch.end();
    }

    public void dispose() {
        registrationButton.dispose();
        combobuttonCity.dispose();
        spriteBatch.dispose();
        background.dispose();
        super.dispose();
    }
}
