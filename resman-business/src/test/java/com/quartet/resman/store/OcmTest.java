package com.quartet.resman.store;

import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.File;
import com.quartet.resman.entity.FileStream;
import com.quartet.resman.entity.Folder;
import com.quartet.resman.utils.Types;
import org.junit.*;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
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
    private String type = Types.Folders.ClassicCourse.getValue();

    @Before
    public void init() {
        folderService.deleteFolder("/jpk");
        folderService.addFolder(new Folder("/jpk", "lcheng", "0", "all", Types.Folders.ClassicCourse.getValue()));
        Folder folder = new Folder("/jpk/kc1", "lcheng", "0", "all", type);
        Folder folder1 = new Folder("/jpk/kc1/gs1", "lcheng", "0", "all", type);
        Folder folder2 = new Folder("/jpk/kc1/gs2", "lcheng", "0", "all", type);
        Folder folder3 = new Folder("/jpk/kc1/gs3", "lcheng", "0", "all", type);

        Folder folder31 = new Folder("/jpk/kc1/gs3/g1", "lcheng", "0", "all", type);
        Folder folder32 = new Folder("/jpk/kc1/gs3/g2", "lcheng", "0", "all", type);
        Folder folder33 = new Folder("/jpk/kc1/gs3/g3", "lcheng", "0", "all", type);

        folderService.addFolder(folder);
        folderService.addFolder(folder1);
        folderService.addFolder(folder2);
        folderService.addFolder(folder3);

        folderService.addFolder(folder31);
        folderService.addFolder(folder32);
        folderService.addFolder(folder33);

        java.io.File f = new java.io.File(FILE_PATH);
        try (InputStream is = new FileInputStream(f)) {
            File file = new File("/jpk/kc1/cluster.log", "lcheng", new FileStream(is), f.length());
            fileService.addFile(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @After
    public void clear() {
        folderService.deleteFolder("/jpk");
    }

    @Test
    public void testAddFolder() {
        Folder folder = new Folder("/jpk/kc1/gs1/g1", "lcheng", type);
        folderService.addFolder(folder);

        List<Entry> entries = folderService.getChildren("/jpk/kc1");
        Assert.assertNotNull(entries);
        Assert.assertEquals(4, entries.size());

        Folder get = folderService.getFolder("/jpk/kc1/gs1/g1");
        Assert.assertNotNull(get);
        Assert.assertEquals("/jpk/kc1/gs1/g1", get.getPath());
        Assert.assertEquals("lcheng", get.getCreateBy());
        Assert.assertEquals(Types.Status.UnReviewed.getValue(), get.getStatus());
        Assert.assertEquals(Types.Folders.ClassicCourse.getValue(), get.getType());
    }

    @Test
    public void testRename() {
        folderService.rename("/jpk/kc1", "kc1-change");
        Folder folder = folderService.getFolder("/jpk/kc1-change");
        Assert.assertNotNull(folder);
        Assert.assertEquals("/jpk/kc1-change", folder.getPath());
    }

    @Test
    public void testGetChildren() {
        List<Entry> data = folderService.getChildren("/jpk/kc1",Types.Status.UnReviewed.getValue(), Types.Visibility.All.getValue());
        Assert.assertNotNull(data);
        Assert.assertEquals(3,data.size());
    }
}