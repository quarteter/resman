package com.quartet.resman.store;

import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.Folder;
import org.apache.jackrabbit.ocm.exception.JcrMappingException;
import org.apache.jackrabbit.ocm.manager.ObjectContentManager;
import org.apache.jackrabbit.ocm.query.Filter;
import org.apache.jackrabbit.ocm.query.Query;
import org.apache.jackrabbit.ocm.query.QueryManager;
import org.apache.jackrabbit.ocm.query.impl.FilterImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.extensions.jcr.JcrCallback;
import org.springframework.extensions.jcr.JcrTemplate;
import org.springframework.extensions.jcr.jackrabbit.ocm.JcrMappingCallback;
import org.springframework.extensions.jcr.jackrabbit.ocm.JcrMappingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static com.google.common.base.Preconditions.checkNotNull;

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

    @Autowired
    private JcrTemplate jcrTemplate;

    public void addFolder(Folder folder) {
        mappingTemplate.insert(folder);
        mappingTemplate.save();
    }

    public void deleteFolder(String path) {
        boolean exist = mappingTemplate.itemExists(path);
        if (exist) {
            mappingTemplate.remove(path);
            mappingTemplate.save();
        }
    }

    public void deleteFolderByUuid(String uuid) {
        final Node node = mappingTemplate.getNodeByIdentifier(uuid);
        if (node != null) {
            mappingTemplate.execute(new JcrCallback<Object>() {
                @Override
                public Object doInJcr(Session session) throws IOException, RepositoryException {
                    node.remove();
                    return null;
                }
            });
        }
    }

    public void rename(String path, String newName) {
        try {
            if (path.startsWith("/")) {
                path = path.substring(1);
            }
            Node node = mappingTemplate.getRootNode().getNode(path);
            if (node != null) {
                mappingTemplate.rename(node, newName);
                mappingTemplate.save();
            }
        } catch (RepositoryException e) {
            e.printStackTrace();
        }
    }

    @Transactional(readOnly = true)
    public Folder getFolder(String path) {
        checkNotNull(path);
        Object obj = mappingTemplate.getObject(path);
        if (obj != null) {
            return (Folder) obj;
        }
        return null;
    }

    @Transactional(readOnly = true)
    public Folder getFolderByUUID(final String uuid) {
        checkNotNull(uuid);
        return mappingTemplate.execute(new JcrMappingCallback<Folder>() {
            @Override
            public Folder doInJcrMapping(ObjectContentManager manager) throws JcrMappingException {
                return (Folder) manager.getObjectByUuid(uuid);
            }
        });
    }

    /**
     * 性能考虑，没有使用OCM的自动Mapping功能。
     * OCM级联获取嵌套的子目录，当结构比较复杂时性能会成问题。
     *
     * @param path
     * @return
     */
    @Transactional(readOnly = true)
    public List<Entry> getChildren(final String path) {

        return mappingTemplate.execute(new JcrCallback<List<Entry>>() {
            @Override
            public List<Entry> doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                String tempPath = path;
                if (path.startsWith("/")) {
                    tempPath = path.substring(1);
                }
                Node node = root.getNode(tempPath);
                List<Entry> result = new ArrayList<Entry>();
                if (node != null) {
                    for (NodeIterator it = node.getNodes(); it.hasNext(); ) {
                        Node n = it.nextNode();
                        Entry entry = NodeMapper.mapEntry(n);
                        if (entry != null) {
                            result.add(entry);
                        }
                    }
                }
                return result;
            }
        });
    }

    /**
     * 按status 和 visibility 过滤查询子节点
     *
     * @param path
     * @param status
     * @param visibility
     * @return
     */
    @Transactional(readOnly = true)
    public List<Entry> getChildren(String path, String status, String visibility) {
        if (path != null && !path.endsWith("/")) {
            path = path + "/";
        }
        QueryManager qm = mappingTemplate.createQueryManager();
        Filter filter = qm.createFilter(Entry.class);
        filter.setScope(path);

        filter.addEqualTo("status", status);
        filter.addEqualTo("visibility", visibility);
        Query q = qm.createQuery(filter);
        return (List<Entry>) mappingTemplate.getObjects(q);
    }


}
