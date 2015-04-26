package com.quartet.resman.converter;

import com.quartet.resman.entity.Document;
import com.quartet.resman.service.Config;
import com.quartet.resman.utils.SysUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by lcheng on 2015/4/24.
 */
public class VideoRelatedActions {

    private VideoRelatedActions() {
    }

    public static void deleteVideoFiles(Document doc) {
        if (doc == null)
            return;
        String origin = doc.getOriginStorePath();
        deleteFile(origin);

        Config config = SysUtils.getBean("config",Config.class);
        String root = config.getVideoPath(),videoPath = root + doc.getStoredPath();
        deleteFile(videoPath);
    }

    public static String getVideoOriginalPath(String fileName) {
        Config config = SysUtils.getBean("config", Config.class);
        String jkDir = config.getRepDir();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String date = format.format(new Date());
        String path = jkDir + "/" + date;
        path = decoratePath(path, fileName);
        return path;
    }

    public static String getVideoConvertedPath(String fileName) {
        Config config = SysUtils.getBean("config", Config.class);
        String root = config.getVideoPath();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String date = format.format(new Date());
        String path = root + "/" + date;
        path = decoratePath(path, fileName);
        return path;
    }

    public static String getVideoImgPath(String webRoot, String fileName) {
        String savePath = webRoot;
        savePath = savePath.replace("\\", "/") + "ueditor/vimgs/";
        String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
        savePath += date;
        Path sp = Paths.get(savePath);
        if (!Files.exists(sp)) {
            try {
                Files.createDirectories(sp);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (fileName != null) {
            int idx = fileName.lastIndexOf(".");
            if (idx != -1) {
                savePath = savePath + "/" + fileName.substring(0, idx) + "-" +
                        System.currentTimeMillis() + ".jpg";
            } else {
                savePath = savePath + "/" + fileName + "-" + System.currentTimeMillis() + ".jps";
            }
        } else {
            savePath = savePath + "/" + System.currentTimeMillis() + ".jpg";
        }
        return savePath;
    }

    public static String decoratePath(String dir, String fileName) {
        Path p = Paths.get(dir);
        if (!Files.exists(p)) {
            try {
                Files.createDirectories(p);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        if (fileName != null) {
            int idx = fileName.lastIndexOf(".");
            if (idx != -1) {
                dir = dir + "/" + fileName.substring(0, idx) + "-" +
                        System.currentTimeMillis() + fileName.substring(idx);
            } else {
                dir = dir + "/" + fileName + "-" + System.currentTimeMillis();
            }
        }
        return dir;
    }

    private static void deleteFile(String path) {
        Path p = Paths.get(path);
        try {
            Files.deleteIfExists(p);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String extractImgPath(String imgPath){
        if(StringUtils.isNotEmpty(imgPath)){
            int idx = imgPath.indexOf("ueditor");
            if (idx!=-1){
                return "/"+imgPath.substring(idx);
            }
            return imgPath;
        }
        return null;
    }
}
