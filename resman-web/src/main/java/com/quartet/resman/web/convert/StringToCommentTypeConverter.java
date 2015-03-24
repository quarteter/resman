package com.quartet.resman.web.convert;

import com.quartet.resman.entity.Comment;
import org.springframework.core.convert.converter.Converter;

/**
 * Created by XWANG on 2015/3/24.
 */
public class StringToCommentTypeConverter implements Converter<String, Comment.CommentType> {
    public StringToCommentTypeConverter()
    {
        System.out.println("------------StringToCommentTypeConverter register---------------");
    }
    @Override
    public Comment.CommentType convert(String source) {
        if (source == null) {
            return null;
        }
        return Comment.CommentType.from( source );
    }
}
