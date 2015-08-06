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
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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

    /**
     * 管理员查看
     * @return
     */
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
        Specification spec = DynamicSpecifications.bySearchFilter(filters, QuestionVo.class);
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
        question.setState("1");
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

    public Result checkAuth(Long opItemUserID )
    {
        Result r = new Result();
        ShiroUser user = userService.getCurrentUser();
        if( user == null )
        {
            r.setSuccess(false);
            r.setMsg("用户未登录，请先登录系统！");
            return r;
        }

        if( user.getId() != opItemUserID && user.getRoleId()  != 1L )
        {
            r.setSuccess(false);
            r.setMsg("只能删除属于自己的数据！");
            return r;
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
        Answer answer = questionService.getAnswer(aid);

        if (aid == null) {
            r.setSuccess(false);
            r.setMsg("删除问题回答是主键不能为空！");
            return r;
        }
        r = checkAuth(answer.getCrtuser().getId());
        if( !r.isSuccess() )
            return r;

        try {
            questionService.deleteAnswer(aid);
        } catch (Throwable t) {
            r.setSuccess(false);
            r.setMsg("删除失败！");
            t.printStackTrace();
        }
        return r;
    }


    @RequestMapping(value = "/updateAnswerPage")
    public String updateAnswerPage(  Long aid , Long page , Model model )
    {
        if( page == null ) page = 0L;
        Answer answer = questionService.getAnswer(aid);
        model.addAttribute("answer" ,answer );
        model.addAttribute("page", page );
        return "resman/question-answer-edit";
    }
    /**
     * 对回答行修改
     *
     * @param  vo
     * @return
     */
    @RequestMapping(value = "/updateAnswer")
    @ResponseBody
    public Result updateAnswer( Answer vo ,Long page ) {
        Result result = new Result();
        Answer answer = answerDao.findOne(vo.getId());
        if( answer == null )
        {
            String tip = String.format("内部错误：ID为[%d]的问答不存在!",vo.getId());
            result.setMsg(tip);
            result.setSuccess(false);
            return result;
        }
        result =  checkAuth(answer.getCrtuser().getId());
        if( !result.isSuccess() )
            return result;
        answer.setCrtdate(new Date());
        answer.setContent(vo.getContent());
        answerDao.save(answer);
        return result;
    }


    /**
     * 添加回答
     *
     * @param qid 问题ID
     * @return
     */
    @RequestMapping(value = "/addAnswer")
    public String addAnswer(Long qid , Long page , Answer answer ) {
        if( page == null )
            page = 0L;
        String retPage = String.format("redirect:teacher/view/%d?page=%d",qid,page);
        ShiroUser user = userService.getCurrentUser();
        answer.setCrtdate(new Date());
        answer.setCrtuser(userDao.findOne(user.getId()));
        answer.setQuesId(qid);
        questionService.addAnswer(answer);
        return retPage;
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


    /**
     * 教师查看所有问题列表
     * @return
     */
    @RequestMapping("teacher/list")
    public String teacherListQuestion() {
        return "resman/question-teacher-list";
    }


    @RequestMapping("teacher/view/{id}")
    public ModelAndView teacherViewQuestion(@PathVariable("id") Long id,
                             @PageableDefault(size = 20,sort = {"crtdate"}, direction = Sort.Direction.DESC) Pageable page) {
        ModelAndView mv = new ModelAndView("resman/question-teacher-view");
        QuestionVo question = questionService.getQuestionVo(id);
        mv.addObject("question",question);
        Long userid = 0L;
        ShiroUser user = userService.getCurrentUser();
        if( user != null )
            userid = user.getId();
        Page<Answer> answerList = questionService.findAnswersByQuestion(id,page);
        mv.addObject("answer", answerList.getContent());
        mv.addObject("totalPages", answerList.getTotalPages());
        mv.addObject("curPage", answerList.getNumber());
        mv.addObject("user",userid);
        return mv;
    }



    /**
     * 教师查看自己回答过的问题列表
     * @return
     */
    @RequestMapping("teacher/myAnswerList")
    public String teacherListMyAnswerQuestion() {
        return "resman/question-teacher-mylist";
    }



    @RequestMapping(value = "teacher/queryMyAnswerList")
    @ResponseBody
    public Map<String, Object> queryMyAnswerQuestion(String searchText,  @PageableDefault(size = 20,sort = {"crtdate"}, direction = Sort.Direction.DESC) Pageable page) {
        Page<Question> questionPage = null;
        ShiroUser user = userService.getCurrentUser();
        questionPage = questionService.findQuestionByAnswerUser( user.getId() , page );
        /*
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("title", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification spec = DynamicSpecifications.bySearchFilter(filters, Question.class);
            questionPage = questionService.findQuestionByAnswerUser( user.getId() , page );
        } else {
            questionPage = questionService.findQuestionByAnswerUser( user.getId() , page );
        }*/
        Map<String, Object> map = new HashMap<>();
        map.put("rows", questionPage.getContent());
        map.put("total", questionPage.getTotalElements());
        return map;
    }




}
