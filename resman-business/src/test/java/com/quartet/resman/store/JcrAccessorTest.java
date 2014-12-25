package com.quartet.resman.store;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@ContextConfiguration(locations = "/spring-config.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class JcrAccessorTest {
    @Autowired
    private JcrAccessor accessor;

    @Test
    public void testAddFolder(){
        String p1 = accessor.addFolder("精品课");
        String p2 = accessor.addFolder("/精品课","高等数学");
        Assert.notNull(p1);
        Assert.notNull(p2);
    }
}
