package com.quartet.resman.web.controller.resman;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.AnswerDao;
import com.quartet.resman.repository.UserDao;
import com.quartet.resman.service.QuestionService;
import com.quartet.resman.service.UserService;
import com.quartet.resman.vo.QuestionVo;
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

    @Resource
    private UserDao userDao;

    @Resource
    private AnswerDao answerDao;

    @RequestMapping("list")
    public String listQuestion() {
        return "resman/question-list";
    }

    @RequestMapping(value = "query")
    @ResponseBody
    public Map<String, Object> queryQuestion(String searchText, @PageableDefault Pageable page) {
        Page<QuestionVo> questionPage = null;
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("title", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification spec = DynamicSpecifications.bySearchFilter(filters, Notice.class);
            questionPage = questionService.getAllQuestionVo(spec, page);
        } else {
            questionPage = questionService.getAllQuestionVo(page);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("rows", questionPage.getContent());
        map.put("total", questionPage.getTotalElements());
        return map;
    }

    @RequestMapping(value = "queryself")
    @ResponseBody
    public Map<String, Object> querySelfQuestion(String searchText, @PageableDefault Pageable page) {
        Page<QuestionVo> questionPage = null;
        ShiroUser user = userService.getCurrentUser();
        List<SearchFilter> filters = new ArrayList<>(1);
        //add self condition
        filters.add(new SearchFilter("crtuser.id", SearchFilter.Operator.EQ, user.getId()));

        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("title", SearchFilter.Operator.LIKE, searchText);
            filters.add(filter);
        }
        Specification spec = DynamicSpecifications.bySearchFilter(filters, Notice.class);
        questionPage = questionService.getAllQuestionVo(spec, page);
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
        ShiroUser usr = userService.getCurrentUser();
        if (question.getCrtuser().getId() != usr.getId() )
            return "resman/question-list";
        model.addAttribute("question", question);
        return "resman/question-edit";
    }

    @RequestMapping("view/{id}")
    public String view(@PathVariable("id") Long id, Model model) {
        Question question = questionService.getQuestion(id);
        ShiroUser usr = userService.getCurrentUser();
        model.addAttribute("question", question);
        return "resman/question-view";
    }

    /**
     * 对问题进行添加
     *
     * @param vo
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Result saveQuestion(Question vo) {
        Result result = new Result();
        Long id = vo.getId();
        Question question = null;
        ShiroUser user = userService.getCurrentUser();

        question = new Question();
        question.setState("0");
        question.setCrtdate(new Date());
        question.setCrtuser( userDao.getOne( user.getId() ) );
        question.setTitle(vo.getTitle());
        question.setContent(vo.getContent());
        questionService.saveQuestion(question);
        return result;
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
        ShiroUser user = userService.getCurrentUser();
        Question question = questionService.getQuestion(vo.getId());
        if (question == null) {
            String tip = String.format("更新问题失败，问题编号[%d]的数据不存在", vo.getId());
            result.setSuccess(false);
            result.setMsg(tip);
            return result;
        }
        if (question.getState().equals("1")) {
            String tip = String.format("该问题已经被审核发布，不能被修改!", vo.getId());
            result.setSuccess(false);
            result.setMsg(tip);
            return result;
        }

        if (question.getCrtuser().getId() != user.getId() ) {
            result.setSuccess(false);
            result.setMsg("只能修改自己发布的问题！");
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

    //以下是问题回答相关接口
    /**
     * 删除问题回答
     *
     * @param aid
     * @return
     */
    @RequestMapping(value = "/deleteAnswer")
    @ResponseBody
    public Result deleteAnswer(Long aid) {
        Result r = new Result();
        if (aid == null) {
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


    /**
     * 对回答行修改
     *
     * @param  vo
     * @return
     */
    @RequestMapping(value = "/updateAnswer")
    @ResponseBody
    public Result updateAnswer( Answer vo) {
        Result result = new Result();
        ShiroUser user = userService.getCurrentUser();
        Answer answer = answerDao.findOne(vo.getId());
        if( answer == null )
        {
            String tip = String.format("内部错误：ID为[%d]的问答不存在!",vo.getId());
            result.setMsg(tip);
            result.setSuccess(false);
            return result;
        }
        if (answer.getCrtuser().getId() !=  user.getId() ) {
            result.setSuccess(false);
            result.setMsg("只能修改自己发布的回答！");
            return result;
        }
        answer.setCrtdate(new Date());
        answer.setContent(vo.getContent());
        answerDao.save(answer);
        return result;
    }


    /**
     * 添加回答
     *
     * @param qid 问题ID
     * @param  vo
     * @return
     */
    @RequestMapping(value = "/addAnswer")
    @ResponseBody
    public Result addAnswer(Long qid , Answer vo) {
        Result result = new Result();
        ShiroUser user = userService.getCurrentUser();
        vo.setCrtdate(new Date());
        vo.setCrtuser(userDao.findOne(user.getId()));
        questionService.addAnswer( qid , vo );
        return result;
    }


    /**
     * 获取指定提问的所欲回答
     *
     * @param  qid
     * @return
     */
    @RequestMapping(value = "/queryAnswer")
    @ResponseBody
    public Map<String, Object> queryAnswer(Long qid, @PageableDefault Pageable page) {
      /*  List<Answer> answerPage = null;
        answerPage = answerDao.findByQuestion( qid );
        Map<String, Object> map = new HashMap<>();
        map.put("rows", answerPage.size());
        map.put("total", answerPage );*/
        Page<Answer> answerPage = null;
        answerPage = answerDao.findByQuestion( qid ,page);
        Map<String, Object> map = new HashMap<>();
        map.put("rows", answerPage.getContent() );
        map.put("total", answerPage.getTotalElements() );
        return map;
    }

}
