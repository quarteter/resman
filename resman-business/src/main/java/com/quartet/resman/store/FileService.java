package com.quartet.resman.store;

import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.File;
import com.quartet.resman.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.apache.jackrabbit.JcrConstants;
import org.apache.jackrabbit.commons.JcrUtils;
import org.apache.jackrabbit.ocm.query.Filter;
import org.apache.jackrabbit.ocm.query.Query;
import org.apache.jackrabbit.ocm.query.QueryManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.extensions.jcr.JcrCallback;
import org.springframework.extensions.jcr.jackrabbit.ocm.JcrMappingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.jcr.*;
import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

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

    public void addFile(File file) {
        mappingTemplate.insert(file);
        mappingTemplate.save();
    }

    /**
     * 根据路径以及相关属性查找文件。
     * 请根据实际情况设置parentPath的值，如/jpk//,/jpk/
     *
     * @param parentPath
     * @param nodeNameLike
     * @param status
     * @param visibility
     * @return
     */
    @Transactional(readOnly = true)
    public List<File> queryFile(String parentPath, String nodeNameLike, String status, String visibility) {
        QueryManager qm = mappingTemplate.createQueryManager();
        String expression = "jcr:like(fn:name(),'%" + nodeNameLike + "%')";
        Filter filter = qm.createFilter(File.class);
        filter.setScope(parentPath);
        filter.addJCRExpression(expression);
        if (StringUtils.isNotEmpty(status)) {
            filter.addEqualTo("status", status);
        }
        if (StringUtils.isNotEmpty(visibility)) {
            filter.addEqualTo("visibility", visibility);
        }
        Query q = qm.createQuery(filter);
        q.addOrderByAscending("created");
        return (List<File>) mappingTemplate.getObjects(q);
    }

    public void deleteFile(String filePath) {
        mappingTemplate.remove(filePath);
        mappingTemplate.save();
    }

    public void rename(String path, String newName) {
        if (path.startsWith("/")) {
            path = path.substring(1);
        }
        try {
            Node node = mappingTemplate.getRootNode().getNode(path);
            if (node != null) {
                mappingTemplate.rename(node, newName);
                mappingTemplate.save();
            }
        } catch (RepositoryException e) {
            e.printStackTrace();
        }
    }

    public InputStream readFile(final String filePath) {
        return mappingTemplate.execute(new JcrCallback<InputStream>() {
            @Override
            public InputStream doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node node = root.getNode(filePath);
                String nodeType = node.getPrimaryNodeType().getName();
                if (nodeType.equals(JcrConstants.NT_FILE) ||
                        nodeType.equals(JcrConstants.NT_RESOURCE)) {
                    return JcrUtils.readFile(node);
                } else if (nodeType.equals(Constants.NT_FILE)) {
                    Node contentNode = node.getNode("{" + Constants.NS_RESMAN + "}/fileStream");
                    Property p = contentNode.getProperty("{" + Constants.NS_RESMAN + "}" + "/content");
                    final Binary binary = p.getBinary();
                    return new FilterInputStream(binary.getStream()) {
                        public void close() throws IOException {
                            super.close();
                            binary.dispose();
                        }
                    };
                }
                return null;
            }
        });
    }

    public void readFile(String filePath, OutputStream os) {
        try (InputStream input = readFile(filePath)) {
            byte[] buffer = new byte[16384];

            for (int n = input.read(buffer); n != -1; n = input.read(buffer)) {
                os.write(buffer, 0, n);
            }
        } catch (IOException e) {
             e.printStackTrace();
        }
    }
}
