package com.quartet.resman.web.controller.resman;


import com.quartet.resman.entity.Comment;
import com.quartet.resman.entity.Result;
import com.quartet.resman.entity.User;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.CommentDao;
import com.quartet.resman.service.UserService;
import com.quartet.resman.web.vo.CommentVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;
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
    public Map<String, Object> query(String resourceid, String type, @PageableDefault Pageable page) {
        Page<Comment> comments = null;
        Comment.CommentType eType = getEType(type);
        comments = commentDao.findByResourceidAndType(resourceid, eType, page);
        Map<String, Object> map = new HashMap<>();
        map.put("rows", comments.getContent());
        map.put("total", comments.getTotalElements());
        return map;
    }

    @RequestMapping(value = "get")
    @ResponseBody
    public Page<Comment> getComment(String resUid, @PageableDefault(size = 5,
            sort = "crtdate", direction = Sort.Direction.DESC) Pageable page) {
        Page<Comment> result = commentDao.findByResourceid(resUid, page);
        return result;
    }


    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(CommentVo vo) {
        Result result = new Result();
        ShiroUser currentUser = userService.getCurrentUser();
        User user = userService.getUser(currentUser.getId());
        Long id = vo.getId();
        vo.setCrtdate(new Date());
        Comment comment = transfer(vo);
        comment.setCrtuser(user);
        if (StringUtils.isEmpty(comment.getContent()) || StringUtils.isEmpty(comment.getType())) {
            result.setSuccess(false);
            result.setMsg("信息不合法，必填项为空!");
            return result;
        }

        if (id != null) {
            comment = commentDao.getOne(id);
        }
        commentDao.save(comment);
        result.setSuccess(true);
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

    private Comment.CommentType getEType(String _type) {
        Comment.CommentType eType = Comment.CommentType.from(_type);
        if (eType == null)
            eType = Comment.CommentType.Course;
        return eType;
    }

    private Comment transfer(CommentVo _vo) {
        Comment comment = new Comment();
        comment.setResourceid(_vo.getResourceid());
        comment.setCrtdate(_vo.getCrtdate());
        comment.setContent(_vo.getContent());
        comment.setId(_vo.getId());
        comment.setType(getEType(_vo.getType()));
        // comment.setCrtuser( userService.getUser(_vo.getId() ));
        return comment;
    }
}
