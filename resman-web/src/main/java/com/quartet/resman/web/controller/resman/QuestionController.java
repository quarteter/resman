package com.quartet.resman.web.controller.resman;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.QuestionService;
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

import javax.annotation.Resource;
import java.util.*;

/**
 * User: xwang
 * Date: 15-1-14
 */
@Controller
@RequestMapping(value = "/res/question")
public class QuestionController {

    @Resource
    private UserService userService;
    @Resource
    private QuestionService questionService;

    @RequestMapping("list")
    public String listQuestion() {
        return "resman/question-list";
    }

    @RequestMapping(value = "query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> queryQuestion(String searchText, @PageableDefault Pageable page) {
        Page<Question> questionPage = null;
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("title", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification spec = DynamicSpecifications.bySearchFilter(filters, Notice.class);
            questionPage = questionService.getAllQuestion(spec, page);
        } else {
            questionPage = questionService.getAllQuestion(page);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("rows", questionPage.getContent());
        map.put("total", questionPage.getTotalElements());
        return map;
    }

    @RequestMapping("add")
    public String addQuestion() {
        return "resman/question-add";
    }

    @RequestMapping("edit/{id}")
    public String editQuestion(@PathVariable("id") Long id, Model model) {
        Question question = questionService.getQuestion(id);
        model.addAttribute("question", question);
        return "resman/question-edit";
    }

    /**
     * 对问题进行添加
     *
     * @param question
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addQuestion(Question question) {
        if (question != null) {
            ShiroUser user = userService.getCurrentUser();
            question.setCrtuser(user.getUserName());
            question.setCrtdate(new Date());
            questionService.saveQuestion(question);
        }
        return "redirect:/res/question/list";
    }

    /**
     * 对问题进行修改
     *
     * @param vo
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result updateQuestion(Question vo) {
        Result result = new Result();
        Question question = questionService.getQuestion(vo.getId());
        if (question == null) {
            String tip = String.format("更新问题失败，问题编号[%d]的数据不存在", vo.getId());
            result.setSuccess(false);
            result.setMsg(tip);
            return result;
        }

        if (question.getState().equals("1"))
          {
                String tip = String.format("该问题已经被审核发布，不能被修改!", vo.getId());
                result.setSuccess(false);
                result.setMsg(tip);
                return result;
            }
          question.setContent(vo.getContent());
            question.setTitle(vo.getTitle());
            questionService.saveQuestion(question);


         return result;
    }



    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result deleteQuestion(String ids) {
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
                    questionService.deleteQuestion(id);
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
    public Result auditQuestion(@PathVariable("id") Long id) {
        Result r = new Result();
        Question question = questionService.getQuestion(id);
        String state = question.getState();
        if (state.equals("1")) {
            r.setSuccess(false);
            r.setMsg("该问题已经被审核!");
        } else {
            question.setState("1");
            questionService.saveQuestion(question);
        }
        return r;
    }


    /**
     * 删除问题回答
     * @param aid
     * @return
     */
    @RequestMapping(value = "/deleteAnswer", method = RequestMethod.POST)
    @ResponseBody
    public Result deleteAnswer(Long aid) {
        Result r = new Result();
        if( aid == null )
        {
            r.setSuccess(false);
            r.setMsg("删除问题回答是主键不能为空！");
            return r;
        }
        try {
            questionService.deleteAnswer(aid);
        } catch (Throwable t) {
            r.setSuccess(false);
            r.setMsg("删除失败！");
            t.printStackTrace();
        }
        return r;
    }


}
