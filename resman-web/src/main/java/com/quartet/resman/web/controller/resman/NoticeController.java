package com.quartet.resman.web.controller.resman;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.Notice;
import com.quartet.resman.entity.Result;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.NoticeDao;
import com.quartet.resman.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

/**
 * User: qfxu
 * Date: 15-1-8
 */
@Controller
@RequestMapping(value = "/res/notice")
public class NoticeController {

    @Resource
    private NoticeDao noticeDao;

    @Resource
    private UserService userService;

    @RequestMapping("list")
    public String list() {
        return "resman/notice-list";
    }

    @RequestMapping(value = "query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> query(String searchText, @PageableDefault Pageable page) {
        Page<Notice> notices = null;
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("title", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification spec = DynamicSpecifications.bySearchFilter(filters, Notice.class);
            notices = noticeDao.findAll(spec, page);
        } else {
            notices = noticeDao.findAll(page);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("rows", notices.getContent());
        map.put("total", notices.getTotalElements());
        return map;
    }

    @RequestMapping("add")
    public String add() {
        return "resman/notice-add";
    }

    @RequestMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model) {
        Notice notice = noticeDao.findOne(id);
        model.addAttribute("notice", notice);
        return "resman/notice-edit";
    }

    @RequestMapping("save")
    @ResponseBody
    public Result save(Notice vo) {
        Result result = new Result();
        Long id = vo.getId();
        Notice notice = null;
        if (id == null) {
            notice = new Notice();
            notice.setState("0");
            notice.setCrtdate(new Date());
            ShiroUser user = userService.getCurrentUser();
            notice.setCrtuser(user.getUserName());
        } else {
            notice = noticeDao.getOne(id);
        }
        notice.setTitle(vo.getTitle());
        notice.setContent(vo.getContent());
        noticeDao.save(notice);
        return result;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(String ids) {
        Result r = new Result();
        if (StringUtils.isNotEmpty(ids)) {
            String[] ida = ids.split(",");
            List<Long> idList = new ArrayList<>();
            for (int i = 0; i < ida.length; i++) {
                Long uid = Long.valueOf(ida[i]);
                idList.add(uid);
            }
            try {
                for (Long id : idList)
                    noticeDao.delete(id);
            } catch (Throwable t) {
                r.setSuccess(false);
                r.setMsg("删除失败！");
                t.printStackTrace();
            }
        }
        return r;
    }

    @RequestMapping(value = "/audit/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Result audit(@PathVariable("id")Long id) {
        Result r = new Result();
        Notice notice = noticeDao.findOne(id);
        String state = notice.getState();
        if(state.equals("1")){
            r.setSuccess(false);
            r.setMsg("该公告已经发布");
        }else{
            notice.setState("1");
            noticeDao.save(notice);
        }
        return r;
    }
}
