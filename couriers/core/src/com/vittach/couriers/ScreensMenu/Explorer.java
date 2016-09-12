package com.vittach.couriers.ScreensMenu;

import java.util.ArrayList;
import com.badlogic.gdx.Gdx;
import com.vittach.couriers.myShell.MyFont;
import com.vittach.couriers.myShell.MyColor;
import com.vittach.couriers.myShell.MyImage;
import com.vittach.couriers.myShell.MyTimer;
import com.badlogic.gdx.files.FileHandle;
import com.vittach.couriers.myShell.ScreenButton;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.vittach.couriers.simpleEngine.Engine;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.vittach.couriers.controllers.InputListener;

public class Explorer extends InputListener {
    private MyColor ic;
    MyImage background;
    float scalex, scaley;
    SpriteBatch spritewnd;
    private Sprite sprite;
    private MyTimer scrols;
    public int DWNKey = -1;
    public ScreenButton delt;
    int biasy = 183, start, stepy;
    private Sprite dirimg, select;
    ArrayList<FileHandle> myfiles;
    private MyImage dirsel, ipaper;
    public ScreenButton back, load;
    private MyFont dirfont,butnfnt;
    private MyImage drawme,dirback;
    int old_y = -1, posy = -1, old;
    int itend = -1, biasx = 126, i;

    @Override
    public boolean keyDown(int ikey) {
        if (ikey == 19)scrol(old_y++);
        if (ikey == 20)scrol(old_y--);
        return true;
    }

    public void updateDir() {
        myfiles.clear();
        itend = (start = 0) -1;
        for (FileHandle file :
                Gdx.files.local("").list())
            if(file.name().contains(".JJ"))
                 myfiles.add(file);
        if (itend < 0) {
            itend = myfiles.size();
            if (itend > 3)
                itend = 3;
        }
    }

    public Explorer() {
        scrols = new MyTimer();
        dirsel = new MyImage();
        ipaper = new MyImage();
        drawme = new MyImage();
        butnfnt = new MyFont();
        dirfont = new MyFont();
        dirback = new MyImage();
        delt = new ScreenButton();
        back = new ScreenButton();
        load = new ScreenButton();
        back.choice=new MyImage();
        load.choice=new MyImage();
        delt.choice=new MyImage();

        background= new MyImage();
        ic = new MyColor(1,1,1,1);
        spritewnd=new SpriteBatch();
        dirfont.load("sephyra.ttf");
        butnfnt.load("cRAFter.ttf");
        dirfont.setPixelSizes(14);
        butnfnt.setPixelSizes(12);

        ipaper.load("ui/ipaper.png");
        background.load ("ui/zAgr.png");
        stepy = dirfont.get_size() + 2;
        dirback.load("ui/dirbackg.png");
        dirsel.load("ui/Dirselect.png");
        ipaper.blit(66, 102, dirback);
        background.blit(54, 27, ipaper);

        myfiles= new ArrayList<FileHandle>();
        back.choice.load("ui/startchoi.png");
        back.background.load("ui/startbuts.png");
        //back.backgr.blit(back.background);
        back.Position(Engine.screenX / 2 - back.background.getWidth() / 2, 68);
        back.font = butnfnt;
        back.textY = 19;
        back.textX = 90;
        back.itext = "mahae";

        delt.choice.load("ui/startchoi.png");
        delt.background.load("ui/startbuts.png");
        //delt.backgr.blit(delt.background);
        delt.Position(Engine.screenX / 2 - delt.background.getWidth() / 2, 98);
        delt.font = butnfnt;
        delt.textY = 19;
        delt.textX = 79;
        delt.itext = "seakiry";

        load.choice.load("ui/startchoi.png");
        load.background.load("ui/startbuts.png");
        //load.backgr.blit(load.background);
        load.Position(Engine.screenX / 2 - load.background.getWidth() / 2,184);
        load.font = butnfnt;
        load.textY = 19;
        load.textX = 74;
        load.itext = "hadpshja";

        select = dirsel.flip();
        select.setPosition(123, biasy - dirsel.getHigh() + 1);
        sprite = background.flip();
        updateDir();
        getCurDir();
    }

    @Override
    public boolean
    touchDown(int x,int y,int id,int b) {
        scaley =Engine.height / (float)Engine.screenY;
        scalex =Engine.width /(float)Engine.screenX;
        if (myfiles.size() > 0) {
            if(delt.MyTouch_Down(x,y))delMaps();
            if(load.MyTouch_Down(x,y))DWNKey= 1;
        }
        if (back.MyTouch_Down(x, y)) DWNKey = 2;
        y  = Engine.Height - y - (Engine.Height - Engine.height) / 2;
        x -= (Engine.Width - Engine.width) / 2;
        id = (itend <= 3) ? itend : 3;
        for (i = 0; i < id; i++)
            if (y >=(-i - 1)* stepy * scaley + biasy * scaley &&
                    y <= -i * stepy * scaley + biasy * scaley &&
                    x >= 64 * scalex && x <= 416 * scalex) {
                select.setPosition(123, (-i - 1) * stepy + biasy);
                old = i + start;
                break;
            }
        posy = old_y = y;
        return true;
    }

    @Override
    public boolean touchDragged(int xpos, int ypos, int TID) {
        ypos = Engine.Height - ypos - (Engine.Height -Engine.height)/2;
        xpos -= (Engine.Width - Engine.width) / 2;
        if (xpos >= select.getX() * scalex && xpos <=biasx+dirsel.
            getWidth() * scalex && ypos <= biasy * scaley&&ypos >=
            biasy * scaley - scaley *dirsel.getHigh()*3)posy=ypos;
        return true;
    }

    public void getCurDir() {
        drawme.clear();
        int j = 0;
        for (i = start; i < itend; i++, j++) {
            drawme.fontPrint(dirfont, biasx, biasy - 2 - j *stepy,
            i + ") "+ myfiles.get(i).name().replace(".JJ",""),ic);
            drawme.fontPrint(dirfont, Engine.screenX / 2, biasy- 2 -
            j * stepy, "~" + (System.currentTimeMillis() -myfiles.
            get(i).lastModified()) / 3600000 + " hrs ago",ic);
        }
        if(itend < 3 && old > 0){
            i = --old - start;
            select.setPosition(123, (-i - 1) * stepy + biasy);
        }
        dirimg = drawme.flip();
    }

    public void Display(Viewport iview) {
        if (Math.abs(posy - old_y)>= dirsel.getHigh())scrol(posy);
        iview.apply();
        spritewnd.setProjectionMatrix(iview.getCamera().combined);
        spritewnd.begin();
        sprite.draw(spritewnd);
        dirimg.draw(spritewnd);
        if (select.getY() < biasy&&select.getY()>= dirsel.getHigh()*-3+biasy)
            select.draw(spritewnd);
        spritewnd.end();
        /*
        back.draw(iview);
        load.draw(iview);
        delt.draw(iview);
        */
    }

    public void scrol(int ypos) {
        if (!scrols.isActive()) {
            if (ypos > old_y) {
                if (itend < myfiles.size()) {
                    start += 1;
                    itend += 1;
                    select.setPosition(123,select.getY()+select.getHeight());
                }
            } else if (start > 0) {
                start -= 1;
                itend -= 1;
                select.setPosition(123 , select.getY() - select.getHeight());
            }
            scrols.start(200);
            old_y = ypos;
            getCurDir();
        }
    }

    public String getName() {
    return myfiles.get(old).name();
    }

    public void delMaps() {
        myfiles.get (old).delete();
        updateDir();
        getCurDir();
    }

    public void dispose() {
        background.dispose();
        spritewnd. dispose();
        dirback.dispose();
        dirfont.dispose();
        dirsel.dispose();
        ipaper.dispose();
        drawme.dispose();
        back.dispose();
        load.dispose();
        delt.dispose();
    }
}
