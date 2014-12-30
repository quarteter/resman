package com.quartet.resman.store;

import com.quartet.resman.vo.NodeVo;
import org.apache.jackrabbit.JcrConstants;
import org.apache.jackrabbit.commons.JcrUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.extensions.jcr.JcrCallback;
import org.springframework.extensions.jcr.JcrTemplate;
import org.springframework.stereotype.Component;

import javax.jcr.*;
import javax.jcr.query.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Component
public class JcrAccessor {

    private static Logger log = LoggerFactory.getLogger(JcrAccessor.class);

    @Autowired
    private JcrTemplate jcrTemplate;

    public String addFolder(final String name) {
        return jcrTemplate.execute(new JcrCallback<String>() {
            @Override
            public String doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node node = root.addNode(name, JcrConstants.NT_FOLDER);
                session.save();
                return node.getPath();
            }
        });
    }

    public String addFolder(final String parent, final String name) {
        return jcrTemplate.execute(new JcrCallback<String>() {
            @Override
            public String doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node parentNode = root.getNode(parent);
                if (parentNode != null) {
                    Node node = parentNode.addNode(name, JcrConstants.NT_FOLDER);
                    session.save();
                    return node.getPath();
                }
                return null;
            }
        });
    }

    public String addFile(final String folder, final InputStream is, final String fileName, final String mimeType) {
        return jcrTemplate.execute(new JcrCallback<String>() {
            @Override
            public String doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node parentNode = root.getNode(folder);
                if (parentNode != null) {
                    Node fileNode = parentNode.addNode(fileName, JcrConstants.NT_FILE);
                    Node resNode = fileNode.addNode(JcrConstants.JCR_CONTENT, JcrConstants.NT_RESOURCE);
                    resNode.setProperty(JcrConstants.JCR_MIMETYPE, mimeType);
                    resNode.setProperty(JcrConstants.JCR_DATA, session.getValueFactory().createBinary(is));
                    session.save();
                    return fileNode.getPath();
                }
                return null;
            }
        });
    }

    public InputStream readFile(final String path) {
        return jcrTemplate.execute(new JcrCallback<InputStream>() {
            @Override
            public InputStream doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node fileNode = root.getNode(path);
                if (fileNode != null) {
                    return JcrUtils.readFile(fileNode);
                }
                return null;
            }
        });
    }

    public void readFile(final String path, final OutputStream os) {
        jcrTemplate.execute(new JcrCallback<Boolean>() {
            @Override
            public Boolean doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node fileNode = root.getNode(path);
                if (fileNode != null) {
                    JcrUtils.readFile(fileNode, os);
                }
                return true;
            }
        });
    }

    public void deleteNode(final String path) {
        jcrTemplate.execute(new JcrCallback<Boolean>() {
            @Override
            public Boolean doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                NodeIterator iterator = root.getNodes(path);
                while (iterator.hasNext()) {
                    iterator.nextNode().remove();
                }
                session.save();
                return true;
            }
        });
    }

    public List<NodeVo> getChildren(final String parentPath) {

        return jcrTemplate.execute(new JcrCallback<List<NodeVo>>() {
            @Override
            public List<NodeVo> doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node parent = root.getNode(parentPath);
                List<NodeVo> result = new ArrayList<>();
                if (parent != null) {
                    NodeIterator iterator = parent.getNodes();
                    while (iterator.hasNext()) {
                        Object obj = iterator.next();
                        if (obj instanceof Node) {
                            Node next = (Node) obj;
                            String name = next.getName();
                            String type = next.getPrimaryNodeType().getName();
                            String path = next.getPath();
                            NodeVo vo = new NodeVo(name, type, path);
                            result.add(vo);
                        }
                    }
                }
                return result;
            }
        });
    }

    public List<NodeVo> queryFile(final String fileName) {
        return jcrTemplate.execute(new JcrCallback<List<NodeVo>>() {
            @Override
            public List<NodeVo> doInJcr(Session session) throws IOException, RepositoryException {
                String sql = "select * from [nt:file] where LOCALNAME() like '%" + fileName + "%'";
                QueryManager qm = session.getWorkspace().getQueryManager();
                Query query = qm.createQuery(sql, Query.JCR_SQL2);
                QueryResult queryResult = query.execute();
                List<NodeVo> result = new ArrayList<>();
                String[] columns = queryResult.getColumnNames();
                for (RowIterator ri = queryResult.getRows(); ri.hasNext(); ) {
                    Row row = ri.nextRow();
                    Node node = row.getNode();
                    String name = node.getName();
                    String path = node.getPath();
                    String type = node.getPrimaryNodeType().getName();
                    result.add(new NodeVo(name, path, type));
                }
                return result;
            }
        });
    }
}
