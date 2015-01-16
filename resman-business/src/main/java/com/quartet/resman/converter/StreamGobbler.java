package com.quartet.resman.converter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * 输出
 */
public class StreamGobbler extends Thread {
    private static Logger logger = LoggerFactory.getLogger(StreamGobbler.class);
    private InputStream is;
    private String type;

    public StreamGobbler(InputStream is, String type) {
        this.is = is;
        this.type = type;
    }

    public void run() {
        try {
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String line = null;
            while ((line = br.readLine()) != null) {
                if (type.equals("Error")) {
                    logger.info("Error	:" + line);
                } else {
                    logger.info("文件转换:" + line);
                }
            }
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }
}
   