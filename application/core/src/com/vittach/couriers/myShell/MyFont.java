package com.vittach.couriers.myShell;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.freetype.FreeTypeFontGenerator;

@Deprecated
public class MyFont {
    private int fsize;
    private BitmapFont font;
    private FreeTypeFontGenerator fontload;
    final String FONT_CHARS = "абвгдеёжзийклмнопрстуфхцчшщъыьэюяabcdefghijklmnopqrstuvwxyzАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789][_!$%#@|\\/?-+=()*&.;:,{}\"´`'<>";

    public void load(String icurrentpath) {
        fontload= new FreeTypeFontGenerator
        (Gdx.files.internal(icurrentpath));
    }

    public void setPixelSizes(int size) {
        FreeTypeFontGenerator.FreeTypeFontParameter param;
        param = new FreeTypeFontGenerator.FreeTypeFontParameter();
        param.characters = FONT_CHARS;
        param.size = fsize = size;
        font=fontload.generateFont(param);
    }

    public MyFont equal(MyFont f){
        fsize = f.fsize;
        font = f.font;
        return this;
    }

    public BitmapFont get_font() {
        return font;
    }

    public void dispose() {
        fontload.dispose();
    }

    public int get_size() {
        return fsize;
    }
}