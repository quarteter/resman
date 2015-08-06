package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.HomeWork;
import com.quartet.resman.entity.HomeWorkRecord;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.HWRecordDao;
import com.quartet.resman.repository.HomeWorkDao;
import com.quartet.resman.repository.HomeWorkVoDao;
import com.quartet.resman.service.HomeWorkService;
import com.quartet.resman.service.UserService;
import com.quartet.resman.utils.Constants;
import com.quartet.resman.vo.HomeWorkVo;
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

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xwang on 2015/6/30.
 */
@Controller
@RequestMapping("/front")
public class FrontHomeWorkController {

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

    @RequestMapping(value = "homework")
    public String homeWork( @PageableDefault(size = 20, sort = "id",
            direction = Sort.Direction.DESC) Pageable page, Model model) {
        Page<HomeWork> homeWorkList = null;
        homeWorkList = hwDao.findAll( page );
        model.addAttribute("homework", homeWorkList.getContent());
        model.addAttribute("curPage", homeWorkList.getNumber());
        model.addAttribute("totalPage", homeWorkList.getTotalPages());
        model.addAttribute("totalCount", homeWorkList.getTotalElements());
        return "front/homework";
    }
    @RequestMapping(value = "homework/{id}")
    public String homeWorkDetail(@RequestParam(value="type", required=false,defaultValue = Constants.INFO_TYPE_NEWS ) String type  ,@PathVariable(value = "id") Long id, Model model) {
        ShiroUser user = userService.getCurrentUser();
        if( user == null )
            return "front/show_homework";

        HomeWork info = hwDao.getOne( id );
        model.addAttribute("homework", info);
        String infoType = type;
        HomeWork pre = homeWorkService.getPreOrNextInfo(info.getId(), "pre");
        HomeWork next = homeWorkService.getPreOrNextInfo(info.getId(), "next");
        if (pre != null) {
            model.addAttribute("pre", pre);
        }
        if (next != null) {
            model.addAttribute("next", next);
        }
        boolean isUploadHomework = false;
        boolean isScore = false;
        HomeWorkRecord item = homeWorkRecordDao.findByHkIdAndSubmitterId(id , user.getId() );
        String score = "还未评分";
        if( item != null )
        {
            isUploadHomework = true;
            model.addAttribute("uuid", item.getDocUid());
            model.addAttribute("filename", item.getFileName() );

            if( item.getScore() != null)
            {
                score = item.getScore().toString();
                isScore = true;
            }
            model.addAttribute("score", score );
        }

        model.addAttribute("isUploadHomework", isUploadHomework);
        model.addAttribute("isScore", isScore);
        model.addAttribute("score", score);
        return "front/show_homework";
    }


    @RequestMapping(value = "myhomework")
    public String myHomeWork( @PageableDefault(size = 20, sort = "id",
            direction = Sort.Direction.DESC) Pageable page, Model model) {
        Page<HomeWorkVo> homeWorkList = null;
        ShiroUser user = userService.getCurrentUser();
        if( user == null )
        {
            return "front/myhomework";
        }
        homeWorkList = hwVoDao.findBySubmitterId(user.getId(), page);
        model.addAttribute("homework", homeWorkList.getContent());
        model.addAttribute("curPage", homeWorkList.getNumber());
        model.addAttribute("totalPage", homeWorkList.getTotalPages());
        model.addAttribute("totalCount", homeWorkList.getTotalElements());
        return "front/myhomework";
    }

}
