package com.quartet.resman.converter;

import com.quartet.resman.entity.Document;
import com.quartet.resman.service.Config;
import com.quartet.resman.store.FileService;
import com.quartet.resman.utils.ExecutionUtils;
import com.quartet.resman.utils.SysUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.Properties;

/**
 * Created by lcheng on 2015/4/21.
 */
public class VideoConvertTask implements Runnable {
    private static Logger logger = LoggerFactory.getLogger(VideoConvertTask.class);

    private String docUid;
    private String srcPath;
    private String outPath;
    private String srcType;//待转换的文件类型，FLV,RMVB,AVI...
    private String imgPath; //图片提取后保存的路径

    public VideoConvertTask(String docUid, String srcType, String srcPath,
                            String outPath, String imgPath) {
        this.docUid = docUid;
        this.srcType = srcType;
        this.srcPath = srcPath;
        this.outPath = outPath;
        this.imgPath = imgPath;
    }

    @Override
    public void run() {
        String command = getConvertCommand(srcType);
        if (command == null) {
            throw new RuntimeException("can not find commands to convert the video...");
        }
        try {

            extract(srcPath, imgPath);

            logger.debug("开始视频转换，源文件:{}", srcPath);
            ExecutionUtils.runCmd(command, getConvertTimeOut());
            logger.debug("视频文件转换结束，目标文件:{}", outPath);

//            FileService fileService = SysUtils.getBean("fileService", FileService.class);
//            Document doc = fileService.getFileInfoByUUID(this.docUid);
//            doc.setImgPath(imgPath);
//            doc.setStoredPath(getPlayPath());
//            doc.setConverted(true);
//            fileService.updateFile(doc);

        } catch (Exception e) {
            logger.error("视频文件转换出错，源文件:{}", srcPath);
        }
    }

    /**
     * 初步支持FLV，AVI，MP4 to MP4的转换
     *
     * @param srcType
     * @return
     */
    private String getConvertCommand(String srcType) {
        Properties p = SysUtils.getBean("command", Properties.class);
        String key = srcType + "2mp4", flvKey = srcType + "2flv";
        String ffmpeg = p.getProperty("ffmpeg.path");
        String command = p.getProperty(key, null);
        if (command == null) {
            command = p.getProperty(flvKey, null);
        }
        if (command != null) {
            command = ffmpeg + " " + command;
            command = MessageFormat.format(command, srcPath, outPath);
        }
        return command;
    }

    private int getConvertTimeOut() {
        Properties p = SysUtils.getBean("command", Properties.class);
        String timeout = p.getProperty("ffmpeg.convert.timeout", "60");
        return Integer.parseInt(timeout);
    }

    private void extract(String videoPath, String imgStorePath) {
        Properties p = SysUtils.getBean("command", Properties.class);
        String ffmpeg = p.getProperty("ffmpeg.path");
        String command = p.getProperty("ffmpeg.extractImg");
        command = ffmpeg + " " + MessageFormat.format(command, videoPath, imgStorePath);
        try {
            logger.debug("开始提取视频({})图片", videoPath);
            ExecutionUtils.runCmd(command);
            logger.debug("提取视频图片({})成功,", imgStorePath);
        } catch (Throwable t) {
            logger.debug("提取视频({})图片失败", videoPath);
        }
    }

    private String getPlayPath() {
        Config config = SysUtils.getBean("config", Config.class);
        String root = config.getVideoPath();
        if(outPath.contains(root)){
           return outPath.substring(root.length());
        }
        return outPath;
    }
}
