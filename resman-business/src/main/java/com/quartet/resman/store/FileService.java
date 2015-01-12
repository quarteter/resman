package com.quartet.resman.store;

import com.quartet.resman.entity.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.extensions.jcr.jackrabbit.ocm.JcrMappingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Service
@Transactional(propagation = Propagation.REQUIRED)
public class FileService {

    @Autowired
    private JcrMappingTemplate mappingTemplate;

    public void addFile(File file){
        mappingTemplate.insert(file);
        mappingTemplate.save();
    }

    //public
}
