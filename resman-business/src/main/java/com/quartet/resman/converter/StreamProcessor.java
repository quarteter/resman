package com.quartet.resman.converter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * Created by lcheng on 2015/4/23.
 */
public class StreamProcessor extends Thread{

    private static Logger log = LoggerFactory.getLogger(StreamProcessor.class);

    private InputStream is;
    private boolean stdOut;
    private String type;

    public StreamProcessor(InputStream is, boolean stdOut, String type) {
        this.is = is;
        this.stdOut = stdOut;
        this.type = type;
    }

    @Override
    public void run() {
        try (InputStreamReader isr = new InputStreamReader(is);
             BufferedReader reader = new BufferedReader(isr)) {
            String line = null;
            while ((line = reader.readLine()) != null) {
                if (stdOut) {
                    System.out.println(line);
                } else {
                    if (type.equals("error")) {
                        log.error(line);
                    } else {
                        log.debug(line);
                    }
                }
            }
        } catch (Exception e) {

        }
    }
}
