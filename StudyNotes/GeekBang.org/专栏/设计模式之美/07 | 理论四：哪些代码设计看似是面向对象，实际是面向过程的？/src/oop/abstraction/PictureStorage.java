package oop.abstraction;

public class PictureStorage implements IPictureStorage {
    // ...省略其他属性...
    @Override
    public void savePicture(Picture picture) {

    }

    @Override
    public Image getPicture(String pictureId) {
        return null;
    }

    @Override
    public void deletePicture(String pictureId) {

    }

    @Override
    public void modifyMetaInfo(String pictureId, PictureMetaInfo metaInfo) {

    }
}
