package com.quartet.resman.store;

import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.Document;
import com.quartet.resman.entity.FileStream;
import com.quartet.resman.entity.Folder;
import com.quartet.resman.utils.Types;
import org.junit.*;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sun.net.www.MimeTable;

import java.io.FileInputStream;
import java.io.FileOutputStream;
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
        folderService.addFolder(new Folder("/jpk", "lcheng", "0", "", Types.Folders.ClassicCourse.getValue()));
        Folder folder = new Folder("/jpk/kc1", "lcheng", "0", "a", type);
        Folder folder1 = new Folder("/jpk/kc1/gs1", "lcheng", "0", "a", type);
        Folder folder2 = new Folder("/jpk/kc1/gs2", "lcheng", "0", "a", type);
        Folder folder3 = new Folder("/jpk/kc1/gs3", "lcheng", "0", "a", type);

        Folder folder31 = new Folder("/jpk/kc1/gs3/g1", "lcheng", "0", "a", type);
        Folder folder32 = new Folder("/jpk/kc1/gs3/g2", "lcheng", "0", "a", type);
        Folder folder33 = new Folder("/jpk/kc1/gs3/g3", "lcheng", "0", "a", type);

        folderService.addFolder(folder);
        folderService.addFolder(folder1);
        folderService.addFolder(folder2);
        folderService.addFolder(folder3);

        folderService.addFolder(folder31);
        folderService.addFolder(folder32);
        folderService.addFolder(folder33);

        java.io.File f = new java.io.File(FILE_PATH);
        try (InputStream is = new FileInputStream(f)) {
            MimeTable mt = MimeTable.getDefaultTable();
            String type = mt.getContentTypeFor("F:/mydoc.txt");
            System.out.println(">>> type is :"+type);
            Document document = new Document("/jpk/kc1/cluster.log", "lcheng", new FileStream(is), f.length());
            fileService.addFile(document);
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
        List<Entry> data = folderService.getChildren("/jpk/kc1", Types.Status.UnReviewed.getValue(), Types.Visibility.All.getValue());
        Assert.assertNotNull(data);
        Assert.assertEquals(4, data.size());
    }

    @Test
    public void testQueryFile() {
        List<Document> result = fileService.queryFile("/jpk//", "cluster",
                Types.Status.UnReviewed.getValue(), Types.Visibility.All.getValue());
        Assert.assertNotNull(result);
        Assert.assertEquals(1,result.size());
    }

    @Test
    public void testReadFile(){
        InputStream is = fileService.readFile("/jpk/kc1/cluster.log");
        Assert.assertNotNull(is);
        try(FileOutputStream fos = new FileOutputStream(new java.io.File("D:/cluster-download.log"))){
            int read = -1;
            byte[] buf = new byte[1024*10];
            while((read=is.read(buf))>0){
                fos.write(buf,0,read);
            }
        }catch (IOException e){

        }
    }
    @Test
    public void testGetFileByUUID(){
        List<Document> result = fileService.queryFile("/jpk//", "cluster",
                Types.Status.UnReviewed.getValue(), Types.Visibility.All.getValue());
        Assert.assertNotNull(result);
        Assert.assertEquals(1,result.size());
        Document document = result.get(0);
        String uuid = document.getUuid();
        Document another = fileService.getFileInfoByUUID(uuid);
        Assert.assertNotNull(another);
        Assert.assertEquals(uuid,another.getUuid());
    }

    @Test
    public void testGetChildrenFolder(){
        List<Entry> folders = folderService.getChildrenFolders("/jpk");
        Assert.assertTrue(folders.size()>0);
    }
}
