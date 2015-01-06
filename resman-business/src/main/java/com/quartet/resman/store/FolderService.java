package com.quartet.resman.store;

import com.quartet.resman.entity.Folder;
import org.apache.jackrabbit.ocm.query.Filter;
import org.apache.jackrabbit.ocm.query.Query;
import org.apache.jackrabbit.ocm.query.QueryManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.extensions.jcr.jackrabbit.ocm.JcrMappingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Service
@Transactional(propagation = Propagation.REQUIRED)
public class FolderService {

    @Autowired
    private JcrMappingTemplate mappingTemplate;

    public void addFolder(Folder folder) {
        mappingTemplate.insert(folder);
        mappingTemplate.save();
    }

    public void deleteFolder(String path){
        boolean exist = mappingTemplate.itemExists(path);
        if (exist){
            mappingTemplate.remove(path);
        }
    }

    @Transactional(readOnly = true)
    public Collection<Folder> getAllFolders() {
        QueryManager qm = mappingTemplate.createQueryManager();
        Filter filter = qm.createFilter(Folder.class);
        Query query = qm.createQuery(filter);
        return  mappingTemplate.getObjects(query);
    }
}
