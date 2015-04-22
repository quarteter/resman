package com.quartet.resman.converter;

import com.quartet.resman.service.Config;
import com.quartet.resman.utils.ExecutionUtils;
import com.quartet.resman.utils.SysUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.Properties;

/**
 * Created by lcheng on 2015/4/21.
 */
public class VideoConvertTask implements Runnable {
    private static Logger logger = LoggerFactory.getLogger(VideoConvertTask.class);

    private String srcPath;
    private String outPath;
    private String srcType;//待转换的文件类型，FLV,RMVB,AVI...

    public VideoConvertTask(String srcType, String srcPath, String outPath) {
        this.srcType = srcType;
        this.srcPath = srcPath;
        this.outPath = outPath;
    }

    @Override
    public void run() {
        String command = getConvertCommand(srcType);
        if (command==null){
            throw new RuntimeException("can not find commands to convert the video...");
        }
        logger.debug("开始视频转换，源文件:{}",srcPath);
        try {
            ExecutionUtils.runCmd(command);
            logger.debug("视频文件转换结束，目标文件:{}",outPath);
            //TODO 更新Jackrabbit中的文件信息
        } catch (Exception e) {
            logger.error("视频文件转换出错，源文件:{}",srcPath);
        }
    }

    /**
     * 初步支持FLV，AVI，MP4 to MP4的转换
     * @param srcType
     * @return
     */
    private String getConvertCommand(String srcType){
        Properties p = SysUtils.getBean("command",Properties.class);
        String key = srcType+"2mp4",flvKey = srcType+"2flv";
        String ffmpeg = p.getProperty("ffmpeg.path") ;
        String command = p.getProperty(key,null);
        if (command==null){
            command = p.getProperty(flvKey,null);
        }
        if (command!=null){
            command = ffmpeg+" "+ command;
        }
        return command;
    }
}
