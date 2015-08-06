package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.Answer;
import com.quartet.resman.entity.HomeWork;
import com.quartet.resman.entity.HomeWorkRecord;
import com.quartet.resman.entity.Question;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.HWRecordDao;
import com.quartet.resman.repository.HomeWorkDao;
import com.quartet.resman.repository.HomeWorkVoDao;
import com.quartet.resman.service.HomeWorkService;
import com.quartet.resman.service.UserService;
import com.quartet.resman.utils.Constants;
import com.quartet.resman.vo.HomeWorkVo;
import com.quartet.resman.vo.QuestionVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.quartet.resman.service.QuestionService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;

/**
 * Created by xwang on 2015/6/30.
 */
@Controller
@RequestMapping("/front")
public class FrontQuestionController {

    @Autowired
    private HomeWorkDao hwDao;

    @Autowired
    private HomeWorkVoDao hwVoDao;

    @Resource
    private HomeWorkService homeWorkService;

    @Resource
    private HWRecordDao homeWorkRecordDao;

    @Resource
    private HomeWorkVoDao homeWorkVoDao;

    @Resource
    private UserService userService;

    @Resource
    private QuestionService questionService;

    /**
     * 是否可以编辑问题,自己编写的问题并且未审核时，可以修改
     * @param question
     * @return
     */
    private boolean canEditQuestion(  QuestionVo question )
    {
        ShiroUser user = userService.getCurrentUser();
        if( user == null )
        {
            return false;
        }
        if( question.getRescount() == 0  )
        {
            return true;
        }
      /*  if(question.getState().isEmpty() ||
                question.getState().compareTo("0") == 0
                )
        {
            return true;
        }*/
        return false;
    }


    /**
     * 显示所有问题
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "question")
    public String questionVO( @PageableDefault(size = 20, sort = "id",
            direction = Sort.Direction.DESC) Pageable page, Model model) {
        Page<QuestionVo> questionList = questionService.getAllPublishQuestionVo(page);
        model.addAttribute("question", questionList.getContent());
        model.addAttribute("curPage", questionList.getNumber());
        model.addAttribute("totalPage", questionList.getTotalPages());
        model.addAttribute("totalCount", questionList.getTotalElements());
        return "front/questionvo";
    }

    @RequestMapping(value = "myquestion")
    public String myQuestionVO( @PageableDefault(size = 20, sort = "id",
            direction = Sort.Direction.DESC) Pageable page, Model model) {
        ShiroUser user = userService.getCurrentUser();
        if( user == null )
            return "front/myquestionvo";
        Page<QuestionVo> questionList = questionService.getMyQuestionVo(page, user.getId());
        model.addAttribute("question", questionList.getContent());
        model.addAttribute("curPage", questionList.getNumber());
        model.addAttribute("totalPage", questionList.getTotalPages());
        model.addAttribute("totalCount", questionList.getTotalElements());
        return "front/myquestionvo";
    }

    /**
     * 显示问答详情
     * @param page
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "ques/{id}")
    public String showQuestion(@PageableDefault(size = 20, sort = "id",
            direction = Sort.Direction.DESC) Pageable page ,@PathVariable(value = "id") Long id, Model model) {
        QuestionVo question = questionService.getQuestionVo( id );
        model.addAttribute("question", question);
        Page<Answer> answerList = questionService.findAnswersByQuestion(id,page);
        model.addAttribute("answer", answerList.getContent());
        model.addAttribute("curPage", answerList.getNumber());
        model.addAttribute("totalPage", answerList.getTotalPages());
        model.addAttribute("totalCount", answerList.getTotalElements());
        model.addAttribute("canedit",canEditQuestion(question) );
        return "front/answer";
    }



    @RequestMapping(value = "question/add")
    public String questionAdd(Question vo) {
        return "front/add_question";
    }

    @RequestMapping(value = "question/save")
    public String questionSave(Question vo) {
        String retPage = "redirect:../myquestion";
        ShiroUser user = userService.getCurrentUser();
        if( user == null )
        {
            return "redirect:add";
        }
        vo.setState("1");
        vo.setAnswers(new ArrayList<Answer>());
        vo.setCrtdate(new Date());
        vo.setCrtuser( userService.getUser(user.getId()));
        questionService.saveQuestion(vo);
        return retPage;
    }


    @RequestMapping(value = "question/edit/{id}")
    public String questionEdit(@PathVariable(value = "id") Long id , Model model) {
        Question question = questionService.getQuestion(id);
        if( question != null )
        {
            model.addAttribute("question",question);
        }
        return "front/edit_question";
    }

    @RequestMapping(value = "question/update")
    public String questionUpdate(Question vo) {
        String retPage = "redirect:../myquestion";
        ShiroUser user = userService.getCurrentUser();
        Question dbQuestion = questionService.getQuestion(vo.getId());
        QuestionVo qVo = questionService.getQuestionVo(vo.getId());
        if( !canEditQuestion(qVo) )
        {
            return retPage;
        }

        if( user == null || dbQuestion == null )
        {
            return retPage;
        }
        dbQuestion.setTitle(vo.getTitle());
        dbQuestion.setContent( vo.getContent() );

       questionService.saveQuestion(dbQuestion);
        return retPage;
    }

}
