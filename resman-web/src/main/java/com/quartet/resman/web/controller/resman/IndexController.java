package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.Info;
import com.quartet.resman.entity.Notice;
import com.quartet.resman.entity.Question;
import com.quartet.resman.repository.NoticeDao;
import com.quartet.resman.repository.QuestionDao;
import com.quartet.resman.service.InfoService;
import com.quartet.resman.service.QuestionService;
import com.quartet.resman.utils.Constants;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 前台页面控制器
 * User: xwang
 * Date: 2015-04-20
 */
@Controller
@RequestMapping(value = "front")
public class IndexController {

    @Autowired
    private InfoService infoService;

    @Autowired
    QuestionDao questionDao;

    @Autowired
    private NoticeDao noticeDao;


    //通知
    private final Integer c_notice_count = 6;

    private final Integer c_info_count = 5;
    private final Integer c_info_hotcount =5;

    //学生作品
    private final Integer c_studentworks_count = 2;
    private final Integer c_studentworks_hotcount = 2;

    //教师作品
    private final Integer c_teacherworks_count = 3;
    private final Integer c_teacherworks_hotcount = 3;



    //攻略
    private final Integer c_strategy_count = 2;
    private final Integer c_strategy_hotcount = 1;

    //知识堂
    private final Integer c_knowledge_count = 6;
    //问答
    private final Integer c_question_count = 6;

    //成果
    private final Integer c_achievement_count = 7;

    //新闻
    private final Integer c_news_count = 7;

    @RequestMapping(value = "home")
    public String index (Model model) {
        init(model);
        return "front/index";
    }
    private void init(Model model)
    {
        getNotice(model);
        getSkillMatch(model);
        getTeacherStudentWorks(model);
        getTeacherGroup(model);
        getKnowledge(model);
        getQuestion(model);
        getStrategy(model);
        getNews(model);
        getAchievement(model);
    }

    /**
     * 通知
     * @param model
     */
    private void getNotice( Model model )
    {
        Pageable page =new PageRequest(0, c_notice_count , new Sort(Sort.Direction.DESC , "id")  );
        Page<Notice> notices = noticeDao.findByState("1", page );
        model.addAttribute("notices_list", notices.getContent());
    }

    /**
     * 技能竞赛
     * @param model
     */
    private void getSkillMatch(Model model)
    {
        List<Info> infoList  = getInfoPublist( Constants.INFO_TYPE_SKILL , c_info_count , false , false  );
        model.addAttribute("sikll_list",infoList);
        infoList  = getInfoPublist( Constants.INFO_TYPE_SKILL , c_info_hotcount , true , true  );
        if( infoList.size() >= 1 ) {
            model.addAttribute("skill_banner", infoList.remove(0));
        }
        model.addAttribute("sikll_hot",infoList);
     }

    /*
    * 师生作品
    * */
    private void getTeacherStudentWorks(Model model)
    {
        //列表
        List<Info> infoList  = getInfoPublist( Constants.INFO_TYPE_TWORK , c_teacherworks_count , false , false  );
        List<Info> infoListT = getInfoPublist( Constants.INFO_TYPE_SWORK , c_studentworks_count , false , false  );
        infoList.addAll(infoListT);
        model.addAttribute("stworks_list",infoList);

        //hot
        infoList  = getInfoPublist( Constants.INFO_TYPE_TWORK , c_teacherworks_hotcount , true , true  );
        infoListT  = getInfoPublist( Constants.INFO_TYPE_SWORK , c_studentworks_hotcount , true , true  );
        infoList.addAll( infoListT );
        if( infoList.size() >= 1 ) {
            model.addAttribute("stworks_banner", infoList.remove(0));
        }
        model.addAttribute("stworks_hot",infoList);
    }

    /**
     * 师资团队
     * @param model
     */
    private void getTeacherGroup(Model model)
    {
        List<Info> infoList  = getInfoPublist(Constants.INFO_TYPE_TEACHERGROUP, c_info_count, false, false);
        model.addAttribute("teachergroup_list",infoList);
        infoList  = getInfoPublist( Constants.INFO_TYPE_TEACHERGROUP , c_info_hotcount , true , true  );
        if( infoList.size() >= 1 ) {
            model.addAttribute("teachergroup_banner", infoList.remove(0));
        }
        model.addAttribute("teachergroup_hot",infoList);
    }

    /**
     * 攻略
     * @param model
     */
    private void getStrategy(Model model)
    {
        List<Info> infoList  = getInfoPublist( Constants.INFO_TYPE_STRATEGY , c_strategy_count , false , false  );
        model.addAttribute("strategy_list",infoList);
    }

    /**
     * 知识堂
     * @param model
     */
    private void getKnowledge(Model model)
    {
        List<Info> infoList  = getInfoPublist( Constants.INFO_TYPE_KNOWLEDGE , c_knowledge_count , false , false  );
        model.addAttribute("knowledge_list",infoList);
    }


    /**
     * 问答
     * @param model
     */
    private void getQuestion(Model model)
    {
        Pageable page = new PageRequest(0, c_question_count ,new Sort(Sort.Direction.DESC, "id") );
        Page<Question> infoList  = questionDao.findAll(page);
        model.addAttribute("question_list",infoList.getContent());
    }

    /**
     * 新闻
     * @param model
     */
    private void getNews(Model model)
    {
        List<Info> infoList  = getInfoPublist( Constants.INFO_TYPE_NEWS , c_news_count , false , false  );
        model.addAttribute("news_list",infoList);
    }

    /**
     * 成果展示
     * @param model
     */
    private void getAchievement(Model model)
    {
        List<Info> infoList  = getInfoPublist( Constants.INFO_TYPE_ACHIVEMENT , c_achievement_count , false , false  );
        model.addAttribute("achievement_list",infoList);
    }


    private List<Info> getInfoPublist(  String type , Integer count , boolean bHot ,boolean banner )
    {
        Pageable page = null;
        Page<Info> infoList = null;
        Sort sort =  new Sort(Sort.Direction.DESC, "id");
        if( bHot ) {
            sort.and(  new Sort(Sort.Direction.DESC, "readCount") );
        }
        page =  new PageRequest(0, count ,sort );
        if( banner )
            infoList = infoService.getBannerInfo(type, true, page);
        else
            infoList = infoService.getInfo(type, true, page);
        List<Info> list = new ArrayList<Info>();
        list.addAll( infoList.getContent() );
        return list;
    }


    /**
     * 信息发布公共函数
     */
   /* private Page<Info> getInfoPublist(  String type , Integer count , boolean bHot ,boolean banner )
    {
        Pageable page = null;
        Page<Info> infoList = null;
        Sort sort =  new Sort(Sort.Direction.DESC, "id");
        if( bHot ) {
            sort.and(  new Sort(Sort.Direction.DESC, "readCount") );
        }
        page =  new PageRequest(0, count ,sort );
        if( banner )
            infoList = infoService.getBannerInfo(type, true, page);
        else
            infoList = infoService.getInfo(type, true, page);
        return infoList;
    }
    */
}
