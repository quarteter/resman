package com.quartet.resman;

import com.quartet.resman.converter.VideoConvertTask;
import com.quartet.resman.converter.VideoImgExtractor;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@ContextConfiguration(locations = "/spring-config.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class AppTest {

    @Test
    public void testExtractImg(){
        String videoPath="c:/Android.mp4",imgStorePath = "c:/android.jpg";
        VideoImgExtractor.extract(videoPath, imgStorePath);
    }

    @Test
    public void testVideoConvertTask(){
        Thread t = new Thread(new VideoConvertTask("i121","avi","c:/a.avi","c:/b.mp4","c:/c.jpg"));
        t.start();
        try {
            t.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
