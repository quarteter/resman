package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.Document;
import com.quartet.resman.entity.Entry;
import com.quartet.resman.entity.Info;
import com.quartet.resman.entity.Question;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.NoticeDao;
import com.quartet.resman.repository.QuestionDao;
import com.quartet.resman.service.InfoService;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.utils.Constants;
import com.quartet.resman.web.vo.FileFuncDef;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * 前台页面控制器
 * User: xwang
 * Date: 2015-04-20
 */
@Controller
@RequestMapping(value = "front")
public class IndexController {

    //通知
    private final Integer c_notice_count = 6;
    private final Integer c_info_count = 5;
    private final Integer c_info_hotcount = 5;
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
    //banner
    private final Integer c_banners_count = 5;
    @Autowired
    QuestionDao questionDao;
    @Autowired
    private InfoService infoService;
    @Autowired
    private NoticeDao noticeDao;
    @Autowired
    private UserService userService;
    @Autowired
    private CommonFileController cfController;
    @Autowired
    private FileService fileService;

    @RequestMapping(value = "home")
    public String index(Model model) {
        init(model);
        return "front/index_new";
    }

    @RequestMapping(value = "getUserInfo", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public ShiroUser getUserInfo() {
        ShiroUser usr = userService.getCurrentUser();
        return usr;
    }


    private void init(Model model) {
        System.out.println("start init" + new Date().toString());
        getNotice(model);
        getSkillMatch(model);
        getTeacherStudentWorks(model);
        getTeacherGroup(model);
        System.out.println("getKnowledge" + new Date().toString());
        getKnowledge(model);
        getQuestion(model);
        getStrategy(model);
        System.out.println("getNews" + new Date().toString());
        getNews(model);
        getAchievement(model);

        System.out.println("getClassic" + new Date().toString());
        getClassic(model);
        System.out.println("getMaterial" + new Date().toString());
        getMaterial(model);
        System.out.println("getDocs" + new Date().toString());
        getDocs(model);
        System.out.println("getImgs" + new Date().toString());
        getImgs(model);

        System.out.println("getBanners" + new Date().toString());
        getBanners(model);
        System.out.println("finish init" + new Date().toString());
    }

    private void getBanners(Model model) {
        Pageable page = null;
        Sort sort = new Sort(Sort.Direction.DESC, "id");
        page = new PageRequest(0, c_banners_count, sort);
        List<Info> infoList = infoService.getBannerInfo(Constants.INFO_TYPE_NEWS, true, page).getContent();
        model.addAttribute("bannerinfo_list", infoList);
    }

    /**
     * 资源-精品课
     *
     * @param model
     */
    private void getClassic(Model model) {
        getResourceList(model, "classic", "classicList", "classicListCount");
    }

    /**
     * 资源-精品教材
     *
     * @param model
     */
    private void getMaterial(Model model) {
        getResourceList(model, "material", "materialList", "materialListCount");
    }

    /**
     * 资源-精品文档
     *
     * @param model
     */
    private void getDocs(Model model) {
        getResourceList(model, "docs", "docsList", "docsListCount");
    }

    /**
     * 资源-精品图库
     *
     * @param model
     */
    private void getImgs(Model model) {
        getResourceList(model, "imgs", "imgsList", "imgsListCount");
    }

    /**
     * 通知
     *
     * @param model
     */
    private void getNotice(Model model) {
        Pageable page = new PageRequest(0, c_notice_count, new Sort(Sort.Direction.DESC, "id"));
        //Page<Notice> notices = noticeDao.findByState("1", page );
        Page<Info> notices = infoService.getInfo(Constants.INFO_TYPE_NOTICE, true, page);
        model.addAttribute("notices_list", notices.getContent());
    }

    /**
     * 技能竞赛
     *
     * @param model
     */
    private void getSkillMatch(Model model) {
        List<Info> infoList = getInfoPublist(Constants.INFO_TYPE_SKILL, c_info_count, false, false);
        model.addAttribute("sikll_list", infoList);
        infoList = getInfoPublist(Constants.INFO_TYPE_SKILL, c_info_hotcount, true, true);
        if (infoList.size() >= 1) {
            model.addAttribute("skill_banner", infoList.remove(0));
        }
        model.addAttribute("sikll_hot", infoList);
    }

    /*
    * 师生作品
    * */
    private void getTeacherStudentWorks(Model model) {
        //列表
        List<Info> infoList = getInfoPublist(Constants.INFO_TYPE_TWORK, c_teacherworks_count, false, false);
        List<Info> infoListT = getInfoPublist(Constants.INFO_TYPE_SWORK, c_studentworks_count, false, false);
        infoList.addAll(infoListT);
        model.addAttribute("stworks_list", infoList);

        //hot
        infoList = getInfoPublist(Constants.INFO_TYPE_TWORK, c_teacherworks_hotcount, true, true);
        infoListT = getInfoPublist(Constants.INFO_TYPE_SWORK, c_studentworks_hotcount, true, true);
        infoList.addAll(infoListT);
        if (infoList.size() >= 1) {
            model.addAttribute("stworks_banner", infoList.remove(0));
        }
        model.addAttribute("stworks_hot", infoList);
    }

    /**
     * 师资团队
     *
     * @param model
     */
    private void getTeacherGroup(Model model) {
        List<Info> infoList = getInfoPublist(Constants.INFO_TYPE_TEACHERGROUP, c_info_count, false, false);
        model.addAttribute("teachergroup_list", infoList);
        infoList = getInfoPublist(Constants.INFO_TYPE_TEACHERGROUP, c_info_hotcount, true, true);
        if (infoList.size() >= 1) {
            model.addAttribute("teachergroup_banner", infoList.remove(0));
        }
        model.addAttribute("teachergroup_hot", infoList);
    }

    /**
     * 攻略
     *
     * @param model
     */
    private void getStrategy(Model model) {
        List<Info> infoList = getInfoPublist(Constants.INFO_TYPE_STRATEGY, c_strategy_count, false, false);
        model.addAttribute("strategy_list", infoList);
    }

    /**
     * 知识堂
     *
     * @param model
     */
    private void getKnowledge(Model model) {
        List<Info> infoList = getInfoPublist(Constants.INFO_TYPE_KNOWLEDGE, c_knowledge_count, false, false);
        model.addAttribute("knowledge_list", infoList);
    }


    /**
     * 问答
     *
     * @param model
     */
    private void getQuestion(Model model) {
        Pageable page = new PageRequest(0, c_question_count, new Sort(Sort.Direction.DESC, "id"));
        Page<Question> infoList = questionDao.findAll(page);
        model.addAttribute("question_list", infoList.getContent());
    }

    /**
     * 新闻
     *
     * @param model
     */
    private void getNews(Model model) {
        List<Info> infoList = getInfoPublist(Constants.INFO_TYPE_NEWS, c_news_count, false, false);
        model.addAttribute("news_list", infoList);
    }

    /**
     * 成果展示
     *
     * @param model
     */
    private void getAchievement(Model model) {
        List<Info> infoList = getInfoPublist(Constants.INFO_TYPE_ACHIVEMENT, c_achievement_count, false, false);
        model.addAttribute("achievement_list", infoList);
    }


    private List<Info> getInfoPublist(String type, Integer count, boolean bHot, boolean hasImage) {
        Pageable page = null;
        Page<Info> infoList = null;
        Sort sort = new Sort(Sort.Direction.DESC, "id");
        if (bHot) {
            sort.and(new Sort(Sort.Direction.DESC, "readCount"));
        }
        page = new PageRequest(0, count, sort);
        if (hasImage)
            infoList = infoService.getImageInfo(type, true, page);
            // infoList = infoService.getBannerInfo(type, true, page);
        else
            infoList = infoService.getInfo(type, true, page);
        List<Info> list = new ArrayList<Info>();
        list.addAll(infoList.getContent());
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


    /**
     * 资源获取公共函数
     *
     * @param model
     * @param restype
     */
    private void getResourceList(Model model, String restype, String restag, String restagCount) {

        FileFuncDef def = cfController.getFuncDefByName(restype);
        System.out.println("def " + def.getTitle());
        String rootPath = cfController.initRoot(def.getRootDir(), def.isRootDirPersonal()) + "/";
        System.out.println("rootPath " + rootPath);
        Map<String, Object> retVal = fileService.queryTop10File(rootPath);
        List<Entry> rows = (List<Entry>) retVal.get("rows");
//        List<Entry>  nodes = fileService.queryTop10File(rootPath).get("rows");

        List<Map<String, Object>> list = new ArrayList();

        if (rows != null && rows.size() > 0) {
            Map<String, Object> map = null;
            for (Entry node : rows) {
               
                if (!(node instanceof Document)) {
                    continue;
                }
                map = new HashMap();
                map.put("uuid", node.getUuid());
                map.put("name", node.getName());
                map.put("path", node.getPath());
                map.put("created", node.getCreated());
                map.put("createBy", node.getCreateBy());
                list.add(map);
            }
        }
        model.addAttribute(restag, list);
        model.addAttribute(restagCount, retVal.get("total"));
        System.out.println("model.addAttribute finished");
    }
}
