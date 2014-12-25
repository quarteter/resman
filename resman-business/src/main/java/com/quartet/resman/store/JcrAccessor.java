package com.quartet.resman.store;

import org.apache.jackrabbit.JcrConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.extensions.jcr.JcrCallback;
import org.springframework.extensions.jcr.JcrTemplate;
import org.springframework.stereotype.Component;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Component
public class JcrAccessor {

    @Autowired
    private JcrTemplate jcrTemplate;

    public String addFolder(final String name) {
        return jcrTemplate.execute(new JcrCallback<String>() {
            @Override
            public String doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node node = root.addNode(name, JcrConstants.NT_FOLDER);
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
                    return node.getPath();
                }
                return null;
            }
        });
    }

//    public void getChildren(String parent){
//         Node root = jcrTemplate.getRootNode();
//
//    }

    public String addFile(final String folder, final InputStream is, final String fileName, final String mimeType) {
        return jcrTemplate.execute(new JcrCallback<String>() {
            @Override
            public String doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node parentNode = root.getNode(folder);
                if (parentNode != null) {
                    Node fileNode = parentNode.addNode(fileName, JcrConstants.NT_FILE);
                    fileNode.setProperty(JcrConstants.JCR_MIMETYPE, mimeType);
                    fileNode.setProperty(JcrConstants.JCR_DATA, session.getValueFactory().createBinary(is));
                    return fileNode.getPath();
                }
                return null;
            }
        });
    }
}
