package com.vittach.couriers.simpleEngine;

import java.util.ArrayList;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.GL20;
import com.vittach.couriers.LoadAndSave;
import com.vittach.couriers.account.User;
import com.vittach.couriers.ScreensMenu.*;
import com.vittach.couriers.menuViewers.*;
import com.badlogic.gdx.ApplicationAdapter;
import com.vittach.couriers.myShell.MyFont;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.vittach.couriers.myShell.MyImage;
import com.vittach.couriers.myShell.MovingMenu;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.myShell.ScreenButton;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.vittach.couriers.interfaces.ForGameScreen;
import com.badlogic.gdx.utils.viewport.StretchViewport;

public class MyEngine extends ApplicationAdapter {

    private MyImage navbarMenu;
    public Sprite navbarSprite;
    public ScreenButton navBarButton;

    public Viewport view;
    public static int idev = 1;
    public MyPin myPin;
    public MyAdvert myAdvert;
    public MyStatus myStatus;
    public FirstMenu firstMenu;
    public StartMenu startMenu;
    public AddAdvert addAdvert;
    public MySettings mySettings;
    public Registration registration;

    public static String baseURL="http://tz.app-labs.ru/";

    public static MyFont textFont28;
    public static MyFont textFont30;
    public static MyFont textFont40;
    public static MyFont textFont72;

    public MovingMenu leftMovingMenu;
    ScreenButton leftMovingMenuButton;

    OrthographicCamera orthoCamera;
    public static LoadAndSave file;
    public static User user = new User();
    ArrayList<ForGameScreen> screenArray;
    public int screen = 0, width, height;

    @Override
    public void dispose() {
        textFont40.dispose();
        if(myPin != null) myPin.dispose();
        if(myStatus != null) myStatus.dispose();
        if(myAdvert != null) myAdvert.dispose();
        if(addAdvert != null) addAdvert.dispose();
        if(firstMenu != null) firstMenu.dispose();
        if(startMenu != null) startMenu.dispose();
        if(navbarMenu != null) navbarMenu.dispose();
        if(mySettings != null) mySettings.dispose();
        if(registration != null) registration.dispose();
        navBarButton.dispose();
        leftMovingMenu.dispose();
        leftMovingMenuButton.dispose();
    }

    public MyEngine(int deve) {idev = deve;}

    @Override
    public void create() {
        textFont28 = new MyFont();
        textFont28.load("arial.ttf");
        textFont28.setPixelSizes(28);

        textFont72 = new MyFont();
        textFont72.load("arial.ttf");
        textFont72.setPixelSizes(72);

        textFont40 = new MyFont();
        textFont40.load("arial.ttf");
        textFont40.setPixelSizes(40);

        textFont30 = new MyFont();
        textFont30.load("arial.ttf");
        textFont30.setPixelSizes(30);


        //-----------------------------------------navBarMenu-----------------------------------------------------------
        navbarMenu = new MyImage();
        navbarMenu.load("ui/navbarMenu.png");

        navbarSprite = navbarMenu.flip();
        navbarSprite.setY(Engine.screenY - navbarMenu.getHigh());

        navBarButton = new ScreenButton();
        navBarButton.background.load("ui/iselect.png");
        navBarButton.Position(10, Engine.screenY - navBarButton.background.getHigh() - 10);
        navBarButton.accept();
        //-----------------------------------------navBarMenu----------------------------------------------------------/





        //-----------------------------------------leftMovingMenu-------------------------------------------------------

        leftMovingMenu=new MovingMenu();
        leftMovingMenu.velocity = 80;
        leftMovingMenu.background.load("ui/movingMenu.png");
        leftMovingMenu.x=-leftMovingMenu.background.getWidth();
        leftMovingMenuButton = new ScreenButton();
        leftMovingMenuButton.choice = new MyImage();
        leftMovingMenuButton.choice.load("ui/choice.png");
        leftMovingMenuButton.background.load("ui/button.png");
        leftMovingMenuButton.font= textFont40;
        leftMovingMenuButton.textY = 50;
        leftMovingMenuButton.textX = 20;
        leftMovingMenuButton.itext = "Мои настройки";
        leftMovingMenuButton.Position(leftMovingMenu.x, Engine.screenY - 200);
        leftMovingMenuButton.accept();
        leftMovingMenu.buttonArray.add(leftMovingMenuButton);

        leftMovingMenuButton = new ScreenButton();
        leftMovingMenuButton.choice = new MyImage();
        leftMovingMenuButton.choice.load("ui/choice.png");
        leftMovingMenuButton.background.load("ui/button.png");
        leftMovingMenuButton.font= textFont40;
        leftMovingMenuButton.textY = 50;
        leftMovingMenuButton.textX = 20;
        leftMovingMenuButton.itext = "Мои объявления";
        leftMovingMenuButton.Position(leftMovingMenu.x, Engine.screenY - 270);
        leftMovingMenuButton.accept();
        leftMovingMenu.buttonArray.add(leftMovingMenuButton);

        leftMovingMenuButton = new ScreenButton();
        leftMovingMenuButton.choice = new MyImage();
        leftMovingMenuButton.choice.load("ui/choice.png");
        leftMovingMenuButton.background.load("ui/button.png");
        leftMovingMenuButton.font= textFont40;
        leftMovingMenuButton.textY = 50;
        leftMovingMenuButton.textX = 20;
        leftMovingMenuButton.itext = "Мой статус";
        leftMovingMenuButton.Position(leftMovingMenu.x, Engine.screenY - 340);
        leftMovingMenuButton.accept();
        leftMovingMenu.buttonArray.add(leftMovingMenuButton);

        leftMovingMenuButton = new ScreenButton();
        leftMovingMenuButton.choice = new MyImage();
        leftMovingMenuButton.choice.load("ui/choice.png");
        leftMovingMenuButton.background.load("ui/button.png");
        leftMovingMenuButton.font= textFont40;
        leftMovingMenuButton.textY = 50;
        leftMovingMenuButton.textX = 20;
        leftMovingMenuButton.itext = "Новое объявление";
        leftMovingMenuButton.Position(leftMovingMenu.x, Engine.screenY - 410);
        leftMovingMenuButton.accept();
        leftMovingMenu.buttonArray.add(leftMovingMenuButton);

        leftMovingMenuButton = new ScreenButton();
        leftMovingMenuButton.choice = new MyImage();
        leftMovingMenuButton.choice.load("ui/choice.png");
        leftMovingMenuButton.background.load("ui/button.png");
        leftMovingMenuButton.font= textFont40;
        leftMovingMenuButton.textY = 50;
        leftMovingMenuButton.textX = 20;
        leftMovingMenuButton.itext = "Выйти";
        leftMovingMenuButton.Position(leftMovingMenu.x, Engine.screenY - 480);
        leftMovingMenuButton.accept();
        leftMovingMenu.buttonArray.add(leftMovingMenuButton);
        //-----------------------------------------leftMovingMenu------------------------------------------------------/

        startMenu = new StartMenu();

        //adds some gameplay screens
        screenArray = new ArrayList<ForGameScreen>();
        screenArray.add(new StartView(this));
        screenArray.add(new FirstView(this));
        screenArray.add(new AddAdvertView(this));
        screenArray.add(new MyAdvertView(this));
        screenArray.add(new RegistrationView(this));
        screenArray.add(new MySettingsView(this));
        screenArray.add(new MyStatusView(this));
        screenArray.add(new MyPinView(this));

        orthoCamera = new OrthographicCamera();
        height = Gdx.graphics.getHeight();
        width = Gdx.graphics.getWidth();
        orthoCamera.setToOrtho(false, width, height);

        view = new StretchViewport(Engine.screenX, Engine.screenY, orthoCamera);

        Engine.inputListener.addProces(startMenu.loginButton);
        Engine.inputListener.addProces(startMenu);

        Gdx.input.setInputProcessor(Engine.inputListener);
    }

    @Override
    public void render() {
        orthoCamera.update();
        Gdx.gl.glEnable(GL20.GL_BLEND);
        Gdx.gl.glBlendFunc(GL20.GL_SRC_ALPHA, GL20.GL_ONE_MINUS_SRC_ALPHA);
        Gdx.gl.glClearColor(0,0,0,1);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT| GL20.GL_DEPTH_BUFFER_BIT);
        screenArray.get(screen).Display(view);
    }

    @Override
    public void resize(int width, int height) {
        orthoCamera.setToOrtho
        (false, view.getWorldWidth(), view.getWorldHeight());
        view.update(this.width = width,this.height = height);
        Engine.setHeight(view.getScreenHeight(),this.height);
        Engine.setWidth(view.getScreenWidth(), this.width);
    }
}
