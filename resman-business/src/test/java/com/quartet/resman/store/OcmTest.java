package com.quartet.resman.store;

import com.quartet.resman.entity.Folder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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
    private JcrAccessor jcrAccessor;

    @Before
    public void deleteAll() {
//        folderService.deleteFolder("/jpk");
        jcrAccessor.deleteNode("jpk");
        jcrAccessor.addFolder("jpk");
    }

    @Test
    public void testAddFolder() {

        Folder folder = new Folder("/jpk/kc1", "kc1", "lcheng", "0", "all");
        folderService.addFolder(folder);
        Collection<Folder> folders = folderService.getAllFolders();
        Assert.assertNotNull(folders);
        if (folders instanceof List){
            System.out.println(((List) folders).get(0).toString());
        }
    }
}
