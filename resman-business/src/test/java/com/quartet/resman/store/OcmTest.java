package com.quartet.resman.store;

import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.File;
import com.quartet.resman.entity.FileStream;
import com.quartet.resman.entity.Folder;
import com.quartet.resman.vo.NodeVo;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.jcr.RepositoryException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@ContextConfiguration(locations = "/spring-config-jcr-test.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class OcmTest {

    @Autowired
    private FolderService folderService;
    @Autowired
    private FileService fileService;
    @Autowired
    private JcrAccessor jcrAccessor;

    private static String FILE_PATH = "D:/cluster.log";

    @Before
    public void deleteAll() {
        jcrAccessor.deleteNode("jpk");
        jcrAccessor.addFolder("jpk");
    }

    @Test
    public void testAddFolder() {

        Folder folder = new Folder("/jpk/kc1", "kc1", "lcheng", "0", "all");
        Folder folder1 = new Folder("/jpk/kc1/gs1", "gs1", "lcheng", "0", "all");
        Folder folder2 = new Folder("/jpk/kc1/gs2", "gs2", "lcheng", "0", "all");
        Folder folder3 = new Folder("/jpk/kc1/gs3", "gs3", "lcheng", "0", "all");
        folderService.addFolder(folder);
        folderService.addFolder(folder1);
        folderService.addFolder(folder2);
        folderService.addFolder(folder3);

        java.io.File f = new java.io.File(FILE_PATH);
        try(InputStream is = new FileInputStream(f)){
//            File file = new File("/jpk/kc1/cluster.log","lcheng",is,f.length());
            File file = new File("/jpk/kc1/cluster.log","lcheng",new FileStream(is),f.length());
            fileService.addFile(file);
        }catch (IOException e) {
            e.printStackTrace();
        }

        Folder fd = folderService.getFolder("/jpk/kc1");
        List<Entry> entries = fd.getEntries();
        Assert.assertNotNull(entries);
        Assert.assertEquals(4,entries.size());

        for (Entry entry : entries){
            if (entry instanceof File){
//                InputStream is = ((File) entry).getContent();
                FileStream fs = ((File) entry).getFileStream();
                if (fs!=null){
                    InputStream is = fs.getContent();
                    if (is!=null){
                        System.out.println("is not null...");
                    }
                }else{
                    System.out.println("fs is null...");
                }
            }
            System.out.println(entry);
        }
    }
}
