package com.quartet.resman.store;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import java.io.*;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@ContextConfiguration(locations = "/spring-config-jcr-test.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class JcrAccessorTest {
    @Autowired
    private JcrAccessor accessor;

    @Test
    public void testAddFolder(){
        accessor.deleteNode("精品课");
        String p1 = accessor.addFolder("精品课");
        String p2 = accessor.addFolder("精品课","高等数学");
        Assert.notNull(p1);
        Assert.notNull(p2);
        accessor.deleteNode("精品课");
    }

    @Test
    public void testAddFile(){
        accessor.deleteNode("精品课");
        String p1 = accessor.addFolder("精品课");
        String p2 = accessor.addFolder("精品课","高等数学");
        try(InputStream is = new FileInputStream(new File("D:/cluster.log"))){
             String path = accessor.addFile("精品课/高等数学",is,"cluster.log","");
            System.out.println(path);
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    @Test
    public void testAddAndReadFile(){
        accessor.deleteNode("精品课");
        String p1 = accessor.addFolder("精品课");
        String p2 = accessor.addFolder("精品课","高等数学");
        try(InputStream is = new FileInputStream(new File("D:/cluster.log"))){
            String path = accessor.addFile("精品课/高等数学",is,"cluster.log","");
            System.out.println(path);
        } catch (IOException e){
            e.printStackTrace();
        }
        InputStream is = accessor.readFile("精品课/高等数学/cluster.log");

        byte[] buffer = new byte[1024];
        int read =-1;
        try(OutputStream os = new FileOutputStream(new File("D:/readOut.log"))){
            while((read = is.read(buffer))>0){
                os.write(buffer,0,read);
            }
            is.close();
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    @Test
    public void testAddAndReadFile2(){
        accessor.deleteNode("精品课");
        String p1 = accessor.addFolder("精品课");
        String p2 = accessor.addFolder("精品课","高等数学");
        try(InputStream is = new FileInputStream(new File("D:/cluster.log"))){
            String path = accessor.addFile("精品课/高等数学",is,"cluster.log","");
            System.out.println(path);
        } catch (IOException e){
            e.printStackTrace();
        }
        try(OutputStream os = new FileOutputStream(new File("D:/readOut.log"))){
            accessor.readFile("精品课/高等数学/cluster.log",os);
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    @Test
    public void testGetChildren(){
        accessor.deleteNode("精品课");
        String p1 = accessor.addFolder("精品课");
        String p2 = accessor.addFolder("精品课","高等数学");
        p2 = accessor.addFolder("精品课","代数");
        p2 = accessor.addFolder("精品课","大学化学");
        p2 = accessor.addFolder("精品课","理论力学");
        try(InputStream is = new FileInputStream(new File("D:/cluster.log"))){
            String path = accessor.addFile("精品课",is,"cluster.log","");
            System.out.println(path);
        } catch (IOException e){
            e.printStackTrace();
        }
        accessor.getChildren("精品课");
    }

    @Test
    public void testQueryFile(){
        accessor.deleteNode("精品课");
        String p1 = accessor.addFolder("精品课");
        String p2 = accessor.addFolder("精品课","高等数学");
        p2 = accessor.addFolder("精品课","代数");
        p2 = accessor.addFolder("精品课","大学化学");
        p2 = accessor.addFolder("精品课","理论力学");
        try(InputStream is = new FileInputStream(new File("D:/cluster.log"))){
            accessor.addFile("精品课/代数", is, "cluster.log", "");
        } catch (IOException e){
            e.printStackTrace();
        }
        accessor.queryFile("cluster");
    }
}
