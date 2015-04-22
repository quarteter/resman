package com.quartet.resman.converter;

import com.quartet.resman.service.Config;
import com.quartet.resman.utils.ExecutionUtils;
import com.quartet.resman.utils.SysUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.MessageFormat;

/**
 * Created by lcheng on 2015/4/22.
 */
public class VideoImgExtractor {

    private static Logger logger = LoggerFactory.getLogger(VideoImgExtractor.class);

    private VideoImgExtractor(){}

    public static void  extract(String videoPath,String imgStorePath){
        Config config = SysUtils.getBean("config",Config.class);
        String command = config.getFFMPEGExtractImg();
        command = MessageFormat.format(command,videoPath,imgStorePath);
        try{
            logger.debug("开始提取视频({})图片", videoPath);
            ExecutionUtils.runCmd(command);
            logger.debug("提取视频图片({})成功,", imgStorePath);
        }catch (Throwable t){
            logger.debug("提取视频({})图片失败",videoPath);
        }

    }

    public static void main(String[] args) {
        String videoPath="c:/Android.mp4",imgStorePath = "c:/android.jpg";
        VideoImgExtractor.extract(videoPath,imgStorePath);
    }
}
