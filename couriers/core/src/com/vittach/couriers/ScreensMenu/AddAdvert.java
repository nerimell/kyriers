package com.vittach.couriers.ScreensMenu;

import java.util.*;

import com.badlogic.gdx.Gdx;
import com.vittach.couriers.myShell.*;
import com.badlogic.gdx.scenes.scene2d.ui.*;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Actor;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.scenes.scene2d.ui.List;
import com.vittach.couriers.simpleEngine.Engine;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.ethernet.httpRequest;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ProcessorInput;
import com.badlogic.gdx.scenes.scene2d.utils.ChangeListener;
import com.badlogic.gdx.scenes.scene2d.utils.TextureRegionDrawable;

/**
 * Created by User on 05.09.2016.
 */
public class AddAdvert extends Stage implements ProcessorInput {

    public int DWNKey= -1;

    private MyFont font;
    private MyFont textFont;
    private MyFont fontScreen;

    private MyColor textColor;
    private MyColor redColor;
    private MyColor blackColor;

    private MyImage cursor;
    private MyImage textarea;
    private MyImage iSElector;
    private MyImage textfield;
    private MyImage combofield;
    private MyImage background;

    private TextArea noteField;
    private TextField dotAField;
    private TextField dotBField;
    private TextField titleField;

    private boolean comboBoxVisible;

    private SelectBox dotASelectBox;
    private SelectBox dotBSelectBox;

    private Sprite sprite;
    private Sprite navbarSprite;
    private SpriteBatch spriteBatch;

    public MovingMenu leftMovingMenu;

    public ScreenButton combobuttonA;
    public ScreenButton combobuttonB;
    public ScreenButton navBarButton;
    public ScreenButton postInfoButton;

    private List listDay1;
    private List listDay2;
    private List listYear1;
    private List listYear2;
    private List listHour1;
    private List listHour2;
    private List listMonth1;
    private List listMonth2;
    private List listMinute1;
    private List listMinute2;
    private ScrollPane daysScroll1;
    private ScrollPane daysScroll2;
    private ScrollPane yearsScroll1;
    private ScrollPane yearsScroll2;
    private ScrollPane hoursScroll1;
    private ScrollPane hoursScroll2;
    private ScrollPane monthsScroll1;
    private ScrollPane monthsScroll2;
    private ScrollPane minutesScroll1;
    private ScrollPane minutesScroll2;

    private Calendar mycalendar;

    private List.ListStyle listStyle;
    ArrayList<String> listSelectBox;
    ArrayList<String> listForScrolls;
    ArrayList<String> listForCombBox;

    @Override
    public void setIDOffset(int id){}

    @Override
    public boolean touchUp(int x, int y, int id, int b) {
        super.touchUp(x,y,id,b);

        if (navBarButton.MyTouch_Down(x,y))
        {
            Gdx.input.setOnscreenKeyboardVisible(false);
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

        //if leftMovingMenu is closing
        if(leftMovingMenu.movingMenuDirection<0) {
            if (combobuttonA.MyTouch_Down(x, y)) {
                if (comboBoxVisible==false) {
                    comboBoxVisible = true;
                    dotASelectBox.showList();
                } else {
                    comboBoxVisible = false;
                    dotASelectBox.hideList();
                }
            }

            if (combobuttonB.MyTouch_Down(x, y)) {
                if (comboBoxVisible==false) {
                    comboBoxVisible = true;
                    dotBSelectBox.showList();
                } else {
                    comboBoxVisible = false;
                    dotBSelectBox.hideList();
                }
            }

            if (postInfoButton.MyTouch_Down(x, y)) {
                Map parameters=new HashMap();
                parameters.put("username", MyEngine.user.getUserName());
                parameters.put("password", MyEngine.user.getPassword());
                parameters.put("dateToDeliver", getData2());
                parameters.put("description", getNote());
                parameters.put("dateToGet", getData1());
                parameters.put("source", getDotA());
                parameters.put("title", getTitle());
                parameters.put("point", getDotB());

                httpRequest request = new httpRequest("http://tz.app-labs.ru/app/submitNewPost");
                request.sendRequest(parameters, "POST");
            }
        }

        if (leftMovingMenu.buttonArray.get(0).MyTouch_Down(x, y) == true) {
            leftMovingMenu.hideMovingMenu();
            DWNKey=1;
        }
        if (leftMovingMenu.buttonArray.get(1).MyTouch_Down(x, y) == true) {
            leftMovingMenu.hideMovingMenu();
            DWNKey=2;
        }
        return true;
    }

    private void setNumbersOfDayInYear() {
        int daysInMonth = mycalendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        listForScrolls.clear();
        for(int i=1;i<=daysInMonth;i++)listForScrolls.add(String.valueOf(i));
        listDay1 = new List(listStyle);
        listDay2 = new List(listStyle);
        listDay1.setItems(listForScrolls.toArray());
        listDay2.setItems(listForScrolls.toArray());
        daysScroll1.setWidget(listDay1);
        daysScroll2.setWidget(listDay2);
    }

    public AddAdvert(MovingMenu leftMovingMenu, Sprite navbarSprite, ScreenButton navBarButton) {
        this.navbarSprite= navbarSprite;
        this.navBarButton= navBarButton;
        listForCombBox = new ArrayList<String>();

        font = new MyFont();
        font.load("arial.ttf");
        font.setPixelSizes(40);

        textFont = new MyFont();
        textFont.load("arial.ttf");
        textFont.setPixelSizes(28);
        textColor= new MyColor(1,1,1,1);

        redColor = new MyColor(1, 0, 0, 1);
        blackColor = new MyColor(0, 0, 0, 1);

        fontScreen = new MyFont();
        fontScreen.load("arial.ttf");
        fontScreen.setPixelSizes(30);

        sprite = new Sprite();
        spriteBatch = new SpriteBatch();

        cursor = new MyImage();
        cursor.load("ui/cursor.png");

        textarea = new MyImage();
        textarea.load("ui/textArea.png");

        iSElector = new MyImage();
        iSElector.load("ui/iselector.png");

        textfield = new MyImage();
        textfield.load("ui/textField.png");

        combofield = new MyImage();
        combofield.load("ui/combobox.png");

        background = new MyImage();
        background.load("ui/background.png");

        this.leftMovingMenu = leftMovingMenu;

        SelectBox.SelectBoxStyle boxStyle = new SelectBox.SelectBoxStyle();
        boxStyle.font = textFont.get_font();
        boxStyle.fontColor = textColor.color();
        boxStyle.background = new TextureRegionDrawable(combofield.flip());
        boxStyle.scrollStyle = new ScrollPane.ScrollPaneStyle();
        boxStyle.scrollStyle.background=new TextureRegionDrawable(combofield.flip());
        boxStyle.listStyle = new List.ListStyle();
        boxStyle.listStyle.font = textFont.get_font();
        boxStyle.listStyle.fontColorSelected = textColor.color();
        boxStyle.listStyle.fontColorUnselected = textColor.color();
        boxStyle.listStyle.selection = new TextureRegionDrawable(combofield.flip());
        boxStyle.listStyle.background= new TextureRegionDrawable(combofield.flip());

        listSelectBox = new ArrayList<String>();
        String[] citiesArray = new String[]{"Slow", "Medium", "Fast", "Fastest", "Lastest"};
        for(String str:citiesArray)
            listSelectBox.add(str);
        dotASelectBox = new SelectBox(boxStyle);
        dotBSelectBox = new SelectBox(boxStyle);
        dotASelectBox.setItems(listSelectBox.toArray());
        dotBSelectBox.setItems(listSelectBox.toArray());




        listStyle = new List.ListStyle();
        listStyle.font = textFont.get_font();
        listStyle.fontColorSelected = textColor.color();
        listStyle.fontColorUnselected = textColor.color();
        listStyle.selection = new TextureRegionDrawable(combofield.flip());
        listStyle.background = new TextureRegionDrawable(combofield.flip());

        listForScrolls = new ArrayList<String>();
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        listForScrolls.add(String.valueOf(currentYear));
        listForScrolls.add(String.valueOf(currentYear+1));
        listYear1 = new List(listStyle);
        listYear2 = new List(listStyle);
        listYear1.setItems(listForScrolls.toArray());
        listYear2.setItems(listForScrolls.toArray());

        listForScrolls.clear();
        for(int i = 1; i < 13; i = i + 1)
            listForScrolls.add(String.valueOf(i));
        listMonth1 = new List(listStyle);
        listMonth2 = new List(listStyle);
        listMonth1.setItems(listForScrolls.toArray());
        listMonth2.setItems(listForScrolls.toArray());

        mycalendar = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR),Calendar.getInstance().get(Calendar.MONTH),1);
        int daysInMonth = mycalendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        listForScrolls.clear();
        for(int i=1;i<=daysInMonth;i++)
            listForScrolls.add(String.valueOf(i));
        listDay1 = new List(listStyle);
        listDay2 = new List(listStyle);
        listDay1.setItems(listForScrolls.toArray());
        listDay2.setItems(listForScrolls.toArray());

        listForScrolls.clear();
        for(int i = 0; i < 24; i = i + 1)
            listForScrolls.add(String.valueOf(i));
        listHour1 = new List(listStyle);
        listHour2 = new List(listStyle);
        listHour1.setItems(listForScrolls.toArray());
        listHour2.setItems(listForScrolls.toArray());

        listForScrolls.clear();
        for(int i = 0; i < 60; i = i + 10)
            listForScrolls.add(String.valueOf(i));
        listMinute1 = new List(listStyle);
        listMinute2 = new List(listStyle);
        listMinute1.setItems(listForScrolls.toArray());
        listMinute2.setItems(listForScrolls.toArray());




        yearsScroll1 = new ScrollPane(listYear1);
        yearsScroll1.setSmoothScrolling(false);
        yearsScroll1.setTransform(true);

        monthsScroll1 = new ScrollPane(listMonth1);
        monthsScroll1.setSmoothScrolling(false);
        monthsScroll1.setTransform(true);

        daysScroll1 = new ScrollPane(listDay1);
        daysScroll1.setSmoothScrolling(false);
        daysScroll1.setTransform(true);

        hoursScroll1 = new ScrollPane(listHour1);
        hoursScroll1.setSmoothScrolling(false);
        hoursScroll1.setTransform(true);

        minutesScroll1 = new ScrollPane(listMinute1);
        minutesScroll1.setSmoothScrolling(false);
        minutesScroll1.setTransform(true);




        yearsScroll2 = new ScrollPane(listYear2);
        yearsScroll2.setSmoothScrolling(false);
        yearsScroll2.setTransform(true);

        monthsScroll2 = new ScrollPane(listMonth2);
        monthsScroll2.setSmoothScrolling(false);
        monthsScroll2.setTransform(true);

        daysScroll2 = new ScrollPane(listDay2);
        daysScroll2.setSmoothScrolling(false);
        daysScroll2.setTransform(true);

        hoursScroll2 = new ScrollPane(listHour2);
        hoursScroll2.setSmoothScrolling(false);
        hoursScroll2.setTransform(true);

        minutesScroll2 = new ScrollPane(listMinute2);
        minutesScroll2.setSmoothScrolling(false);
        minutesScroll2.setTransform(true);




        listYear1.addListener(new ChangeListener() {
            @Override
            public void changed(ChangeEvent event, Actor actor) {
                mycalendar = new GregorianCalendar(Integer.parseInt(listYear1.getSelected().toString()),Integer.parseInt(listMonth1.getSelected().toString())-1, 1);
                setNumbersOfDayInYear();
            }
        });

        listMonth1.addListener(new ChangeListener() {
            @Override
            public void changed(ChangeEvent event, Actor actor) {
                mycalendar = new GregorianCalendar(Integer.parseInt(listYear1.getSelected().toString()),Integer.parseInt(listMonth1.getSelected().toString())-1, 1);
                setNumbersOfDayInYear();
            }
        });

        listYear2.addListener(new ChangeListener() {
            @Override
            public void changed(ChangeEvent event, Actor actor) {
                mycalendar = new GregorianCalendar(Integer.parseInt(listYear2.getSelected().toString()),Integer.parseInt(listMonth2.getSelected().toString())-1, 1);
                setNumbersOfDayInYear();
            }
        });

        listMonth2.addListener(new ChangeListener() {
            @Override
            public void changed(ChangeEvent event, Actor actor) {
                mycalendar = new GregorianCalendar(Integer.parseInt(listYear2.getSelected().toString()),Integer.parseInt(listMonth2.getSelected().toString())-1, 1);
                setNumbersOfDayInYear();
            }
        });



        dotASelectBox.addListener(new ChangeListener() {
            @Override
            public void changed(ChangeEvent event, Actor actor) {
                dotAField.setText(dotASelectBox.getSelected().toString());
            }
        });

        dotBSelectBox.addListener(new ChangeListener() {
            @Override
            public void changed(ChangeEvent event, Actor actor) {
                dotBField.setText(dotBSelectBox.getSelected().toString());
            }
        });

        TextField.TextFieldStyle
                textFieldStyle = new TextField.TextFieldStyle(
                textFont.get_font(), textColor.color(),
                new TextureRegionDrawable(cursor.flip()),
                new TextureRegionDrawable(iSElector.flip()),
                new TextureRegionDrawable(textfield.flip())
        );

        TextField.TextFieldStyle
                textAreaStyle = new TextField.TextFieldStyle(
                textFont.get_font(), textColor.color(),
                new TextureRegionDrawable(cursor.flip()),
                new TextureRegionDrawable(iSElector.flip()),
                new TextureRegionDrawable(textarea.flip())
        );

        noteField = new TextArea("", textAreaStyle);
        noteField.setTextFieldListener(new TextField.TextFieldListener(){
            @Override
            public void keyTyped(TextField textField1, char key) {
                if (noteField.getText().length() <2) {
                    noteField.setText(" " + key);
                    noteField.setCursorPosition(2);
                }
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        dotAField = new TextField("", textFieldStyle);
        dotAField.setTextFieldListener(new TextField.TextFieldListener(){
            @Override
            public void keyTyped(TextField textField1, char key) {
                if (dotAField.getText().length() <2) {
                    dotAField.setText(" " + key);
                    dotAField.setCursorPosition(2);
                }
                listForCombBox.clear();
                for(String str : listSelectBox)
                if(String.valueOf(key).compareTo(str.toLowerCase()) <= 0)
                    listForCombBox.add(str);
                Collections.sort(listForCombBox);
                if(listForCombBox.size()> 0)
                    dotASelectBox.setItems(listForCombBox.toArray());
                dotASelectBox.showList();
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        dotBField = new TextField("", textFieldStyle);
        dotBField.setTextFieldListener(new TextField.TextFieldListener() {
            @Override
            public void keyTyped(TextField textField1, char key) {
                if (dotBField.getText().length() <2) {
                    dotBField.setText(" " + key);
                    dotBField.setCursorPosition(2);
                }
                listForCombBox.clear();
                for(String str : listSelectBox)
                if(String.valueOf(key).compareTo(str.toLowerCase()) <= 0)
                    listForCombBox.add(str);
                Collections.sort(listForCombBox);
                if(listForCombBox.size()> 0)
                    dotBSelectBox.setItems(listForCombBox.toArray());
                dotBSelectBox.showList();
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        titleField = new TextField("", textFieldStyle);
        titleField.setTextFieldListener(new TextField.TextFieldListener() {
            @Override
            public void keyTyped(TextField textField1, char key) {
                if (titleField.getText().length() <2) {
                    titleField.setText(" " + key);
                    titleField.setCursorPosition(2);
                }
                if(key=='\n')textField1.getOnscreenKeyboard().show(false);
            }
        });

        //--------------------------------------postInfoButton----------------------------------------------------------
        postInfoButton = new ScreenButton();
        postInfoButton.choice = new MyImage();
        postInfoButton.choice.load("ui/choicepost.png");
        postInfoButton.background.load("ui/buttonpost.png");
        postInfoButton.font= font;
        postInfoButton.textY = 50;
        postInfoButton.textX = 80;
        postInfoButton.itext = "Отправить данные";
        postInfoButton.Position(Engine.screenX / 2 - postInfoButton.background.getWidth() / 2, 20);
        postInfoButton.accept();
        //--------------------------------------postInfoButton---------------------------------------------------------/

        //--------------------------------------combobuttonA------------------------------------------------------------
        combobuttonA = new ScreenButton();
        combobuttonA.background.load("ui/combobutton.png");
        combobuttonA.Position(Engine.screenX-combobuttonA.background.getWidth(), Engine.screenY-225);
        combobuttonA.accept();
        //--------------------------------------combobuttonA-----------------------------------------------------------/

        //--------------------------------------combobuttonB------------------------------------------------------------
        combobuttonB = new ScreenButton();
        combobuttonB.background.load("ui/combobutton.png");
        combobuttonB.Position(Engine.screenX-combobuttonB.background.getWidth(), Engine.screenY-275);
        combobuttonB.accept();
        //--------------------------------------combobuttonB-----------------------------------------------------------/





        background.fontPrint(fontScreen, 20, Engine.screenY - 80, "Я такой-то", blackColor);
        background.fontPrint(fontScreen, 20, Engine.screenY - 150, "Заголовок", blackColor);
        background.fontPrint(fontScreen, 20, Engine.screenY - 200, "из точки А",blackColor);
        background.fontPrint(fontScreen, 20, Engine.screenY - 250, "в точку Б", blackColor);
        background.fontPrint(fontScreen, 65, 340, "Забрать в", blackColor);
        background.fontPrint(fontScreen, 340, 340,"Доставь к", blackColor);

        background.fontPrint(fontScreen, 10, 300, "Год",redColor);
        background.fontPrint(fontScreen, 75, 300, "М", redColor);
        background.fontPrint(fontScreen, 120, 300, "Д", redColor);
        background.fontPrint(fontScreen, 165, 300, "Ч", redColor);
        background.fontPrint(fontScreen, 210, 300, "М", redColor);

        background.fontPrint(fontScreen, 284, 300, "Год",redColor);
        background.fontPrint(fontScreen, 349, 300, "М", redColor);
        background.fontPrint(fontScreen, 394, 300, "Д", redColor);
        background.fontPrint(fontScreen, 439, 300, "Ч", redColor);
        background.fontPrint(fontScreen, 484, 300, "М",redColor);





        noteField.setMessageText(" введите примечание");
        noteField.setPosition(Engine.screenX/2-textarea.getWidth()/2, 360);
        noteField.setSize(textarea.getWidth(), textarea.getHigh());

        dotASelectBox.setPosition(172, Engine.screenY - 225);
        dotASelectBox.setSize(combofield.getWidth(), combofield.getHigh());

        dotBSelectBox.setPosition(172, Engine.screenY - 275);
        dotBSelectBox.setSize(combofield.getWidth(), combofield.getHigh());

        dotAField.setMessageText(" Введите пункт отправки");
        dotAField.setPosition(172, Engine.screenY - 225);
        dotAField.setSize(textfield.getWidth(), textfield.getHigh());

        dotBField.setMessageText(" Введите пункт доставки");
        dotBField.setPosition(172, Engine.screenY - 275);
        dotBField.setSize(textfield.getWidth(), textfield.getHigh());

        titleField.setMessageText(" Введите заголовок");
        titleField.setPosition(172, Engine.screenY - 175);
        titleField.setSize(textfield.getWidth(),textfield.getHigh());




        yearsScroll1.setPosition(10, 115);
        yearsScroll1.setSize(65, textfield.getHigh() * 4);

        monthsScroll1.setPosition(75, 115);
        monthsScroll1.setSize(45, textfield.getHigh()* 4);

        daysScroll1.setPosition(120, 115);
        daysScroll1.setSize(45, textfield.getHigh() * 4);

        hoursScroll1.setPosition(165, 115);
        hoursScroll1.setSize(45, textfield.getHigh() * 4);

        minutesScroll1.setPosition(210, 115);
        minutesScroll1.setSize(45, textfield.getHigh()*4);




        yearsScroll2.setPosition(284, 115);
        yearsScroll2.setSize(65, textfield.getHigh() * 4);

        monthsScroll2.setPosition(349, 115);
        monthsScroll2.setSize(45, textfield.getHigh()* 4);

        daysScroll2.setPosition(394, 115);
        daysScroll2.setSize(45, textfield.getHigh() * 4);

        hoursScroll2.setPosition(439, 115);
        hoursScroll2.setSize(45, textfield.getHigh() * 4);

        minutesScroll2.setPosition(484, 115);
        minutesScroll2.setSize(45, textfield.getHigh()*4);




        sprite = background.flip();

        addActor(titleField);
        addActor(dotASelectBox);
        addActor(dotAField);
        addActor(dotBSelectBox);
        addActor(dotBField);
        addActor(noteField);
        addActor(minutesScroll1);
        addActor(minutesScroll2);
        addActor(monthsScroll2);
        addActor(monthsScroll1);
        addActor(daysScroll2);
        addActor(daysScroll1);
        addActor(hoursScroll2);
        addActor(hoursScroll1);
        addActor(yearsScroll1);
        addActor(yearsScroll2);
    }

    public void Display(Viewport view) {

        view.apply();
        spriteBatch.setProjectionMatrix(view.getCamera().combined);

        spriteBatch.begin();
        sprite.draw(spriteBatch);
        navbarSprite.draw(spriteBatch);
        navBarButton.draw(spriteBatch);
        combobuttonA.draw(spriteBatch);
        combobuttonB.draw(spriteBatch);
        postInfoButton.draw(spriteBatch);
        spriteBatch.end();

        setViewport(view);
        act();
        draw();

        spriteBatch.begin();
        leftMovingMenu.draw(spriteBatch);
        spriteBatch.end();
    }

    public String getTitle() {
        int length = titleField.getText().length();
        return length > 0 ? titleField.getText().substring(1, length): "";
    }

    public String getData1() {
        return listYear1.getSelected().toString()+"-"+listMonth1.getSelected().toString()+"-"+listDay1.getSelected().toString()+" "+listHour1.getSelected().toString()+":"+listMinute1.getSelected().toString();
    }

    public String getData2() {
        return listYear2.getSelected().toString()+"-"+listMonth2.getSelected().toString()+"-"+listDay2.getSelected().toString()+" "+listHour2.getSelected().toString()+":"+listMinute2.getSelected().toString();
    }

    public String getDotA() {
        int length =dotAField.getText().length();
        return length > 0 ? dotAField.getText().substring(1,length): "";
    }

    public String getDotB() {
        int length =dotBField.getText().length();
        return length > 0 ? dotBField.getText().substring(1,length): "";
    }

    public String getNote() {
        int length =noteField.getText().length();
        return length > 0 ? noteField.getText().substring(1,length): "";
    }

    public void dispose() {
        postInfoButton.dispose();
        combobuttonA.dispose();
        combobuttonB.dispose();
        spriteBatch.dispose();
        background.dispose();
        combofield.dispose();
        iSElector.dispose();
        textfield.dispose();
        textarea.dispose();
        cursor.dispose();
    }
}
