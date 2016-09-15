package com.vittach.couriers.ScreensMenu;

import java.util.Map;
import java.util.HashMap;
import java.io.IOException;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.utils.JsonValue;
import com.badlogic.gdx.files.FileHandle;
import com.badlogic.gdx.utils.JsonReader;
import com.vittach.couriers.myShell.MyFont;
import com.vittach.couriers.myShell.MyImage;
import com.vittach.couriers.myShell.MyColor;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Actor;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.scenes.scene2d.ui.Skin;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.vittach.couriers.myShell.ScreenButton;
import com.vittach.couriers.ethernet.httpRequest;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.scenes.scene2d.ui.Dialog;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.badlogic.gdx.scenes.scene2d.ui.CheckBox;
import com.badlogic.gdx.scenes.scene2d.ui.TextField;
import com.badlogic.gdx.scenes.scene2d.ui.TextButton;
import com.vittach.couriers.interfaces.ProcessorInput;
import com.badlogic.gdx.scenes.scene2d.utils.ChangeListener;
import com.badlogic.gdx.scenes.scene2d.utils.TextureRegionDrawable;

public class StartMenu extends Stage implements ProcessorInput {

    private Sprite sprite;
    public int DWNKey = -1;
    private MyFont textFont;
    private MyColor textColor;

    private MyImage cursor;
    private MyImage checkOn;
    private MyImage checkOff;
    private MyImage iSElector;
    private MyImage textfield;
    private MyImage backgound;
    private MyImage forgotpass;

    private CheckBox checkBox;

    public TextField passField;
    public TextField loginField;

    private httpRequest request;
    private String resultRequest;

    private Dialog errorwindow;

    public ScreenButton loginButton;

    private SpriteBatch spriteBatch;

    private TextButton forgotAccount;
    private TextButton createAccount;

    private FileHandle file;
    private String filename = "couriers/usersData.bin";

    @Override
    public void setIDOffset(int s){}

    @Override
    public boolean touchUp(int x, int y, int id, int b) {
        super.touchUp(x,y,id,b);
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
                        if(checkBox.isChecked())
                        file.writeString("login=" + getLogin() + ";password=" + getPassword(), false);
                        DWNKey = 1;
                    } else
                        addActor(errorwindow);
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
        spriteBatch.setProjectionMatrix (view. getCamera ().combined);
        spriteBatch.begin();
        sprite.draw(spriteBatch);
        loginButton.draw(spriteBatch);
        spriteBatch.end();
        setViewport(view);
        act();
        draw();
    }

    private void errorWindowDialog() {
        Skin uiskinjson = new Skin(Gdx.files.internal("uiskin.json"));
        errorwindow = new Dialog("Исключение", uiskinjson, "default"){
            @Override
            public void result(Object ob) {
                errorwindow.remove();
                errorWindowDialog ();
            }
        };
        errorwindow.text("Проверьте правильность введенных вами\nданных и повторите попытку снова");
        errorwindow.button("Хорошо, я обязательно исправлюсь!", true);
        errorwindow.setSize(textfield.getWidth(),100);
        errorwindow.setPosition(Engine.screenX/2-errorwindow.getWidth()/2,300);
    }

    public StartMenu() throws IOException {
        file= Gdx.files.external(filename);

        sprite = new Sprite();

        cursor = new MyImage();
        cursor.load("ui/cursor.png");

        textFont = new MyFont();
        textFont.load("arial.ttf");
        textFont.setPixelSizes(28);

        spriteBatch = new SpriteBatch();
        textColor= new MyColor(1,1,1,1);

        checkOn = new MyImage();
        checkOn.load("ui/checkboxOn.png");

        checkOff = new MyImage();
        checkOff.load("ui/checkboxOff.png");

        iSElector = new MyImage();
        iSElector.load("ui/iselector.png");

        textfield = new MyImage();
        textfield.load("ui/textField.png");

        backgound = new MyImage();
        backgound.load("ui/background.png");

        forgotpass = new MyImage();
        forgotpass.load("ui/startbutsunder.png");

        errorWindowDialog();

        //--------------------------------------forgotAccount----------------------------------------------------------
        TextButton.TextButtonStyle textButtonStyle = new TextButton.TextButtonStyle();
        textButtonStyle.up=new TextureRegionDrawable(forgotpass.flip());
        textButtonStyle.down=new TextureRegionDrawable(forgotpass.flip());
        textButtonStyle.checked=new TextureRegionDrawable(forgotpass.flip());
        textButtonStyle.fontColor = Color.BLACK;
        textButtonStyle.font=textFont.get_font();

        forgotAccount = new TextButton("Забыли пароль?",textButtonStyle);
        forgotAccount.setPosition(97,Engine.screenY-300);
        forgotAccount.setSize(215,26);
        forgotAccount.addListener(new ChangeListener() {
            public void changed (ChangeEvent event, Actor actor) {
                System.out.println("LOL");
            }
        });
        //--------------------------------------forgotAccount---------------------------------------------------------/

        //--------------------------------------createAccount----------------------------------------------------------
        createAccount = new TextButton("Создать аккаунт",textButtonStyle);
        createAccount.setPosition(97,Engine.screenY-350);
        createAccount.setSize(215,26);
        createAccount.addListener(new ChangeListener() {
            public void changed (ChangeEvent event, Actor actor) {
                System.out.println("LAL");
            }
        });
        //--------------------------------------createAccount---------------------------------------------------------/

        CheckBox.CheckBoxStyle
                checkBoxStyle = new CheckBox.CheckBoxStyle(
                new TextureRegionDrawable(checkOff.flip()),
                new TextureRegionDrawable(checkOn.flip()),
                textFont.get_font(),new MyColor(1,0,0,1).color()
        );

        checkBox = new CheckBox("Запомнить меня",checkBoxStyle);
        checkBox.getCells().get(0).size(60, 24);
        checkBox.setPosition(97, Engine.screenY - 200);

        checkBox.addListener(new ChangeListener() {
            @Override
            public void changed(ChangeEvent event, Actor actor){
                if(!checkBox.isChecked())
                    if(file.exists() == true) file.delete();
            }
        });

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

        if(file.exists()) {
            String string = file.readString();
            if (string!=null)
            {
                checkBox.setChecked(true);
                String[] keyValPairs = string.split(";");
                for (String encodedPairs : keyValPairs) {
                String keyVal[]= encodedPairs.split("=");
                if (keyVal[0].equalsIgnoreCase("login")){
                    loginField.setText(keyVal[1]);
                    }
                    else if (keyVal[0].equalsIgnoreCase("password")) passField.setText(keyVal[1]);
                }
            }
        }

        //--------------------------------------loginButton------------------------------------------------------------
        loginButton = new ScreenButton();
        loginButton.choice = new MyImage();
        loginButton.choice.load("ui/startchoi.png");
        loginButton.background.load("ui/startbuts.png");
        loginButton.font = textFont;
        loginButton.itext = "Войти в систему";
        loginButton.textY = 31;
        loginButton.textX = 70;
        loginButton.Position(Engine.screenX / 2 - loginButton.background.getWidth() / 2, Engine.screenY - 250);
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

        addActor(forgotAccount);
        addActor(createAccount);
        addActor(loginField);
        addActor(passField);
        addActor(checkBox);
    }

    public String getPassword() {
        int length = passField.getText().length();
        return length > 0 ? passField.getText(): "";
    }

    public String getLogin() {
        int length =loginField.getText().length();
        return length > 0 ? loginField.getText():"";
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
