package com.quartet.resman.store;

import org.apache.jackrabbit.JcrConstants;
import org.apache.jackrabbit.commons.JcrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.extensions.jcr.JcrCallback;
import org.springframework.extensions.jcr.JcrTemplate;
import org.springframework.stereotype.Component;

import javax.jcr.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

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
                if (fileNode!=null){
                    return JcrUtils.readFile(fileNode);
                }
                return null;
            }
        });
    }

    public void readFile(final String path,final OutputStream os){
        jcrTemplate.execute(new JcrCallback<Boolean>() {
            @Override
            public Boolean doInJcr(Session session) throws IOException, RepositoryException {
                Node root = session.getRootNode();
                Node fileNode = root.getNode(path);
                if (fileNode!=null){
                    JcrUtils.readFile(fileNode,os);
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
}
