package com.quartet.resman.vo;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.quartet.resman.web.vo.FileFuncDef;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 * @author: lcheng
 * @date: 2015/2/24
 * @version: 1.0
 */
public class FileManagerJsonMapperTest {

    @Test
    public void testJsonMapper() {
        ObjectMapper mapper = new ObjectMapper();
        InputStream is = getClass().getClassLoader().getResourceAsStream("fm-def.json");
        try {
//            List<FileFuncDef> defs = mapper.readValue(is, new TypeReference<List<FileFuncDef>>() {});
//            Assert.assertNotNull(defs);
//            FileFuncDef def = defs.get(0);
//            Assert.assertEquals("space",def.getName());
            Map<String,FileFuncDef> defs = mapper.readValue(is, new TypeReference<Map<String,FileFuncDef>>() {});
            Assert.assertNotNull(defs);
            FileFuncDef def = defs.get("space");
            Assert.assertEquals("space",def.getName());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
