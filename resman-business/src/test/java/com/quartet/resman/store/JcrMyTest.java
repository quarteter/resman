package com.quartet.resman.store;

import org.apache.jackrabbit.JcrConstants;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.extensions.jcr.JcrCallback;
import org.springframework.extensions.jcr.JcrTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import javax.jcr.*;
import java.io.*;

/**
 * @author xwang
 * @version 1.0
 *          ${tags}
 */
@ContextConfiguration(locations = "/spring-config-jcr-test.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class JcrMyTest {

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

    @Test
    public void folderTest() throws Exception {
     //  String path = addFolder("xwangfolder", "sub");
    //   System.out.println("add folder path:" + path);
        jcrTemplate.execute(new JcrCallback<Boolean>() {
                                @Override
                                public Boolean doInJcr(Session session) throws IOException, RepositoryException {





                                    Node node = session.getNode("/");
                                    traceNode(node);

                                    node = session.getNode("/xwangfolder/");

                                    traceNode(node);
                                    traveProperty(node);
                               //     node.setProperty(JcrConstants.JCR_CREATED ,"xwang");
                                  //  session.save();
                              //      traveProperty(node);




                                    node = session.getNode("/xwangfolder[2]");
                                    traceNode(node);

                                    node = session.getRootNode();
                                  //  node = node.getNode("xwangfolder/sub");
                                  // traceNode(node);

                                    NodeIterator iter =  node.getNodes("xwangfolder");
                                    while( iter.hasNext() )
                                    {
                                        node = iter.nextNode();
                                        traceNode(node);
                                    }
                                    return true;
                                }
                            }
        );
    }


    @Test
    public void testNode() throws Exception
    {
        jcrTemplate.execute(new JcrCallback<Object>() {
                                @Override
                                public Object doInJcr(Session session) throws IOException, RepositoryException {
                                    Node root = session.getRootNode();
                                    traceNode(root);
                                    NodeIterator nodeIterator =  root.getNodes();
                                    Node itemNode ;
                                    while(  nodeIterator.hasNext())
                                    {
                                        itemNode = nodeIterator.nextNode();
                                        traceNode(itemNode);
                                        System.out.println("List Node Property:");
                                        traveProperty( itemNode );
                                    }
                                    return 1L;
                                }
                            }
        );

    }

    private void traceNode(Node node )
    {
        try {
            String tip = String.format("node name:[%s] path:[%s] id:[%s] primary node type:[%s]", node.getName(), node.getPath(), node.getIdentifier() ,  node.getPrimaryNodeType().getName());
            System.out.println(tip);
        }
        catch(Exception e)
        {
            e.printStackTrace();;
        }
    }

    private void traveProperty( Node node )
    {
        try {

            PropertyIterator pIter = node.getProperties();
            Property itemProperty;
            while (pIter.hasNext()) {
                itemProperty = pIter.nextProperty();
                String tip = String.format("     prop name:[%s] , path:[%s] ,value:[%s] ", itemProperty.getName(), itemProperty.getPath(), itemProperty.getValue());
                System.out.println( tip );
            }
        }
        catch( Exception e)
        {
            e.printStackTrace();;
        }
    }

}
