package com.vittach.couriers;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.files.FileHandle;

import java.io.*;

public class LoadAndSave
    implements Serializable {
    transient String filename;

    public LoadAndSave() {

    }

    public void Save_World() {
        try {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ObjectOutput out = new ObjectOutputStream(bos);
            out.writeObject(this);
            byte[]Bytes=bos.toByteArray();

            FileHandle file = Gdx.files.external(filename);
            //false = overwrite,true = add new data to file
            file.writeBytes(Bytes, false);

            out.close();
            bos.close();

        } catch (IOException exeption) {
            exeption.printStackTrace();
        }
    }

    public void Load_World() {
        try {
            ByteArrayInputStream bis;
            FileHandle file = Gdx.files.external(filename);
            bis=new ByteArrayInputStream(file.readBytes());

            ObjectInput in = new ObjectInputStream(bis);
            LoadAndSave world=(LoadAndSave)in.readObject();

            bis.close();
            in.close();

        } catch (IOException exeption){
            exeption.printStackTrace();
        } catch (ClassNotFoundException exeption){
            exeption.printStackTrace();
        }
    }

    public void Set_Name(String name) {
        filename = name;
    }
}
