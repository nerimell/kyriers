package com.vittach.couriers.myShell;
import com.badlogic.gdx.graphics.Pixmap;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.Pixmap.Format;
import com.vittach.couriers.simpleEngine.Engine;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.glutils.FrameBuffer;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;

public class MyImage {
    private int rotatn = 0;
    private FrameBuffer frame;
    private SpriteBatch frwindow;
    private OrthographicCamera camera;

    public MyImage clone(MyImage img){
        frame = img.frame;
        rotatn = img.rotatn;
        frwindow = img.frwindow;
        return this;
    }

    public void blit(int x,int y,MyImage img,int m, int n, int w, int h) {
        TextureRegion regon;
        Sprite sprt;
        frame.begin();
        frwindow.begin();
        if (w != 0 && h != 0) {
            regon= new TextureRegion(img.flip().getTexture(), m, n, w, h);
            sprt = new Sprite(regon);
            sprt.setPosition(x, y);
            sprt.rotate(img.rotatn);
            sprt.flip(false, true);
            sprt.draw(frwindow);
        } else {
            sprt = img.flip();
            sprt.setPosition(x, y);
            sprt.draw(frwindow);
        }
        frwindow.end();
        frame.end();
    }

    public MyImage() {
        frwindow = new SpriteBatch();
        int widt = Engine.screenX, hei = Engine.screenY;
        frame = new FrameBuffer(Format.RGBA8888, widt, hei, true);
        camera = new OrthographicCamera();
        setCam(widt, hei);
    }

    public void load(String path) {
        Texture blank = new Texture(path);
        frame = new FrameBuffer
        (Format.RGBA8888,blank.getWidth(),blank.getHeight(),true);
        setCam(blank.getWidth(), blank.getHeight());
        frame.begin();
        frwindow.begin();
        frwindow.draw(blank, 0.0f, 0);
        frwindow.end();
        frame.end();
        blank.dispose();
    }

    public Sprite flip() {
        Sprite buffer = new Sprite(frame.getColorBufferTexture());
        buffer.rotate(rotatn);
        buffer.flip(false, true);
        return buffer;
    }

    public void fontPrint
        (MyFont font, int x, int y, String text, MyColor color) {
        BitmapFont fnt = font.get_font();
        fnt.setColor(color.color());
        frame.begin();
        frwindow.begin();
        fnt.draw(frwindow, text, x, y);
        frwindow.end();
        frame.end();
    }

    public void clear(MyColor clr) {
        ShapeRenderer shape = new ShapeRenderer();
        frame.begin();
        shape.begin(ShapeRenderer.ShapeType.Filled);
        shape.setColor(clr.color());
        shape.rect(0.0f,0.0f,frame.getWidth(),frame.getHeight());
        shape.end();
        frame.end();
        shape.dispose();
    }

    private void setCam(int wid, int hei) {
        camera.setToOrtho(false, wid, hei);
        frwindow.setProjectionMatrix (camera.combined);
    }

    public int get_Pixel(int x, int y) {
        Pixmap TexurePix=frame.getColorBufferTexture().
                getTextureData().consumePixmap();
        return TexurePix.getPixel(x, y);
    }

    public void clear() {
        clear(new MyColor(0f, 0, 0, 0));
        //createEmpty(frame.getWidth(),frame.getHeight());
    }

    public void createEmpty(int wid, int hgh) {
        setCam(wid, hgh);
        frame.dispose();
        frame = new FrameBuffer(Format.RGBA8888, wid, hgh, true);
    }

    public void blit(int x,int y,MyImage img) {
        blit(x, y, img, 0, 0, 0, 0);
    }

    public void blit(MyImage img) {
        blit(0, 0, img);
    }

    public void rotate(int degree){
        rotatn = degree;
    }

    public int getHigh() {
    return frame.getHeight();
    }

    public int getWidth() {
    return frame.getWidth ();
    }

    public void dispose() {
        frame.dispose();
        frwindow.dispose();
    }
}