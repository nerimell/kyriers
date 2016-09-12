package com.vittach.couriers.simpleEngine;

import java.io.IOException;
import java.util.ArrayList;

import com.badlogic.gdx.Gdx;
import com.vittach.couriers.ScreensMenu.*;
import com.vittach.couriers.menuViewers.*;
import com.vittach.couriers.myShell.MyFont;
import com.vittach.couriers.myShell.MyImage;
import com.vittach.couriers.myShell.MovingMenu;
import com.badlogic.gdx.graphics.GL20;
import com.vittach.couriers.myShell.ScreenButton;
import com.vittach.couriers.LoadAndSave;
import com.vittach.couriers.account.User;
import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.vittach.couriers.interfaces.ForGameScreen;
import com.badlogic.gdx.utils.viewport.StretchViewport;

public class MyEngine extends ApplicationAdapter {

    private MyImage navbarMenu;
    private Sprite navbarSprite;
    private ScreenButton navBarButton;

    private MyFont font;
    private MovingMenu leftMovingMenu;
    ScreenButton leftMovingMenuButton;

    public Explorer open;
    public Viewport view;
    public static int idev = 1;
    public FirstMenu firstMenu;
    public StartMenu startMenu;
    public AddAdvert addAdvert;
    public MyAdvert myAdvert;
    OrthographicCamera orthoCamera;
    public static LoadAndSave file;
    public static User user = new User();
    ArrayList<ForGameScreen> screenArray;
    public int screen = 0, width, height;

    @Override
    public void dispose() {
        font.dispose();
        myAdvert.dispose();
        addAdvert.dispose();
        firstMenu.dispose();
        startMenu.dispose();
        navbarMenu.dispose();
        navBarButton.dispose();
        leftMovingMenu.dispose();
        leftMovingMenuButton.dispose();
    }

    public MyEngine(int deve) {idev = deve;}

    @Override
    public void create() {
        //-----------------------------------------navBarMenu-----------------------------------------------------------
        navbarMenu = new MyImage();
        navbarMenu.load("ui/navbarMenu.png");

        navbarSprite = navbarMenu.flip();
        navbarSprite.setY(Engine.screenY - navbarMenu.getHigh());

        navBarButton = new ScreenButton();
        navBarButton.background.load("ui/iselect.png");
        //navBarButton.backgr.blit(navBarButton.background);
        navBarButton.Position(10, Engine.screenY - navBarButton.background.getHigh() - 10);
        navBarButton.accept();
        //-----------------------------------------navBarMenu----------------------------------------------------------/





        //-----------------------------------------leftMovingMenu-------------------------------------------------------
        font = new MyFont();
        font.load("arial.ttf");
        font.setPixelSizes(40);

        leftMovingMenu=new MovingMenu();
        leftMovingMenu.velocity = 80;
        leftMovingMenu.background.load("ui/movingMenu.png");
        leftMovingMenu.x=-leftMovingMenu.background.getWidth();
        leftMovingMenuButton = new ScreenButton();
        leftMovingMenuButton.choice = new MyImage();
        leftMovingMenuButton.choice.load("ui/choice.png");
        leftMovingMenuButton.background.load("ui/button.png");
        leftMovingMenuButton.font= font;
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
        leftMovingMenuButton.font= font;
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
        leftMovingMenuButton.font= font;
        leftMovingMenuButton.textY = 50;
        leftMovingMenuButton.textX = 20;
        leftMovingMenuButton.itext = "Статистика";
        leftMovingMenuButton.Position(leftMovingMenu.x, Engine.screenY - 340);
        leftMovingMenuButton.accept();
        leftMovingMenu.buttonArray.add(leftMovingMenuButton);

        leftMovingMenuButton = new ScreenButton();
        leftMovingMenuButton.choice = new MyImage();
        leftMovingMenuButton.choice.load("ui/choice.png");
        leftMovingMenuButton.background.load("ui/button.png");
        leftMovingMenuButton.font= font;
        leftMovingMenuButton.textY = 50;
        leftMovingMenuButton.textX = 20;
        leftMovingMenuButton.itext = "Новое объявление";
        leftMovingMenuButton.Position(leftMovingMenu.x, Engine.screenY - 410);
        leftMovingMenuButton.accept();
        leftMovingMenu.buttonArray.add(leftMovingMenuButton);
        //-----------------------------------------leftMovingMenu------------------------------------------------------/

        firstMenu = new FirstMenu(leftMovingMenu, navbarSprite, navBarButton);
        addAdvert = new AddAdvert(leftMovingMenu, navbarSprite, navBarButton);
        myAdvert = new MyAdvert(leftMovingMenu, navbarSprite, navBarButton);
        try {
            startMenu = new StartMenu();
        } catch (IOException e) {
            e.printStackTrace();
        }
        //adds some gameplay screens
        screenArray = new ArrayList<ForGameScreen>();
        screenArray.add(new StartView(this));
        screenArray.add(new FirstView(this));
        screenArray.add(new AddAdvertView(this));
        screenArray.add(new MyAdvertView(this));
        screenArray.add(new LoadSave(this));

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
        Gdx.gl.glEnable(3042);
        Gdx.gl.glBlendFunc(770, 771);
        Gdx.gl.glClearColor(0,0,0,1);
            Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT | GL20.GL_DEPTH_BUFFER_BIT);
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
