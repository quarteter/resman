package com.quartet.resman.web.controller.resman;


import com.quartet.resman.entity.Comment;
import com.quartet.resman.entity.Result;
import com.quartet.resman.entity.User;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.CommentDao;
import com.quartet.resman.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.InputStream;
import java.util.*;

/**
 * User: xwang
 * 评论管理
 * Date: 15-3-22
 */
@Controller
@RequestMapping(value = "/res/comment")
public class CommentController {

    @Resource
    private CommentDao commentDao;

    @Resource
    private UserService userService;

    @RequestMapping(value = "query")
    @ResponseBody
    public Map<String, Object> query( Long resourceid, Comment.CommentType type, @PageableDefault Pageable page) {
        Page<Comment> comments = null;

        if( type == null )
            type = Comment.CommentType.Course;
        comments = commentDao.findByResourceidAndType( resourceid , type , page );
        Map<String, Object> map = new HashMap<>();
        map.put("rows", comments.getContent());
        map.put("total", comments.getTotalElements());
        return map;
    }

    @RequestMapping("save")
    @ResponseBody
    public Result save(Comment vo) {
        Result result = new Result();
        ShiroUser currentUser = userService.getCurrentUser();
        User user = userService.getUser( currentUser.getId() );
        Long id = vo.getId();
        Comment comment = vo;

        if( StringUtils.isEmpty(comment.getContent() ) ||  StringUtils.isEmpty(comment.getType() ) )
        {
            result.setSuccess(false);
            result.setMsg("信息不合法，必填项为空!");
            return result;
        }

        if (id == null) {
            comment.setType(vo.getType());
            comment.setResourceid( vo.getResourceid() );
        }
        else
        {
            comment = commentDao.getOne(id);
        }

        comment.setCrtdate(new Date());
        comment.setCrtuser( user );
        comment.setContent(vo.getContent());
        commentDao.save(comment);
        return result;
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public Result delete(String ids) {
        Result r = new Result();
        if (!StringUtils.isEmpty(ids)) {
            String[] ida = ids.split(",");
            try {
                for (String id : ida) {
                    commentDao.delete(Long.valueOf(id));
                }
            } catch (Throwable t) {
                r.setSuccess(false);
                r.setMsg("删除失败！");
                t.printStackTrace();
            }
        }
        return r;
    }

}
