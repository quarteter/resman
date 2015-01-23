package com.quartet.resman.store;

import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.Document;
import com.quartet.resman.entity.Folder;
import com.quartet.resman.utils.Constants;
import org.apache.commons.beanutils.BeanUtils;

import javax.jcr.*;
import java.lang.reflect.InvocationTargetException;

/**
 * Created by lcheng on 2015/1/11.
 */
public class NodeMapper {

    public static <T> T mapNode(Node node, Class<T> klass) {
        try {
            T t = klass.newInstance();
            for (PropertyIterator iterator = node.getProperties(); iterator.hasNext(); ) {
                Property p = iterator.nextProperty();
                String name = p.getName();
                int idx = name.lastIndexOf(":");
                if (idx >= 0) {
                    name = name.substring(idx + 1);
                }

                BeanUtils.setProperty(t, name, getValue(p));
            }
            BeanUtils.setProperty(t,"path",node.getPath());
            BeanUtils.setProperty(t,"uuid",node.getIdentifier());
            return t;
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (RepositoryException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Entry mapEntry(Node node) {
        try {
            String nt = node.getPrimaryNodeType().getName();
            if (nt.equals(Constants.NT_FOLDER)) {
                return mapNode(node, Folder.class);
            } else if (nt.equals(Constants.NT_FILE)) {
                return mapNode(node, Document.class);
            } else if (nt.equals(Constants.NT_ENTRY)) {
                return mapNode(node, Entry.class);
            } else {
                return null;
            }
        } catch (RepositoryException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static Object getValue(Property p) {
        try {
            int type = p.getType();
            switch (type) {
                case PropertyType.STRING:
                    return p.getString();
                case PropertyType.DATE:
                    return p.getDate();
                case PropertyType.LONG:
                    return p.getLong();
                case PropertyType.BOOLEAN:
                    return p.getBoolean();
                case PropertyType.DOUBLE:
                    return p.getDouble();
            }
        } catch (RepositoryException e) {

        }
        return null;
    }
}
