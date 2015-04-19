package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.Code;
import com.quartet.resman.entity.Info;
import com.quartet.resman.entity.Result;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.CodeService;
import com.quartet.resman.service.InfoService;
import com.quartet.resman.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/3/25.
 */
@Controller
@RequestMapping("/info")
public class InfoController {

    private static final String IMG_SAVE_PATH = "ueditor/jsp/upload/image";
    private static final String CODE_INFO = "info";

    @Autowired
    private InfoService infoService;
    @Autowired
    private UserService userService;
    @Autowired
    private CodeService codeService;

    @RequestMapping("/list")
    public ModelAndView list(@RequestParam(required = false) String type,
                             @PageableDefault(size = 20,sort = {"crtdate"}, direction = Sort.Direction.DESC) Pageable page) {
        ModelAndView mv = new ModelAndView("resman/info-list");
        Page<Info> data = null;
        if (StringUtils.isNotEmpty(type)){
            data = infoService.getInfo(type,page);
            mv.addObject("type",type);
        }else{
            data = infoService.getInfo(page);
        }
        mv.addObject("news", data.getContent());
        mv.addObject("totalPages", data.getTotalPages());
        mv.addObject("curPage", data.getNumber());
        List<Code> codes = codeService.getCode(CODE_INFO);
        mv.addObject("infoType",codes);
        Map<String,String> typeMap = new HashMap<>();
        for (Code code : codes){
            typeMap.put(code.getCode(),code.getName());
        }
        mv.addObject("typeMap",typeMap);
        return mv;
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView addNews() {
        ModelAndView mv = new ModelAndView("resman/info-add");
        mv.addObject("infoType",codeService.getCode(CODE_INFO));
        return mv;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addNews(Info news) {
        if (news != null) {
            ShiroUser user = userService.getCurrentUser();
            String userName = user.getUserName();
            news.setCrtuser(userName);
            news.setCrtdate(new Date());
            news.setReadCount(0L);
            infoService.addInfo(news);
            return "redirect:/info/list?type="+news.getType();
        }
        return "redirect:/info/list";
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(Long id){
        ModelAndView mv = new ModelAndView("resman/info-edit");
        Info info = infoService.getInfoEager(id);
        mv.addObject("info",info);
        mv.addObject("infoType",codeService.getCode(CODE_INFO));
        return mv;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result updateInfoPublishState(Long id,String publish){
        boolean p = Boolean.valueOf(publish);
        Result result = null;
        try{
            infoService.updateInfoPublishState(id,p);
            result = new Result(true,"");
        }catch (Throwable t){
            t.printStackTrace();
            result = new Result(false,"");
        }
        return result;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result deleteNews(Long id) {
        Result result = null;
        try {
            infoService.deleteInfo(id);
            result = new Result(true, "");
        } catch (Exception e) {
            e.printStackTrace();
            result = new Result(false, "");
        }
        return result;
    }

    @RequestMapping(value = "/imgUpload")
    @ResponseBody
    public Result bannerImgUpload(HttpServletRequest request,@RequestParam("fileData") MultipartFile uploadFile){
        Result result = null;
        String originFileName = uploadFile.getOriginalFilename();
        int dotIdx = originFileName.lastIndexOf(".");
        String name=originFileName, sufix = "";
        Random  random = new Random();
        int rint = random.nextInt(1000);
        if (dotIdx > 0){
            sufix = originFileName.substring(dotIdx);
            name = originFileName.substring(0,dotIdx)+"_"+String.valueOf(rint)+sufix;
        }else{
            name = name +"_"+String.valueOf(rint);
        }
        String savePath = request.getServletContext().getRealPath("/");
        savePath = savePath.replace("\\","/")+IMG_SAVE_PATH+"/";
        String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
        savePath += date;

        Path sp = Paths.get(savePath);
        if(!Files.exists(sp)){
            try {
                Files.createDirectories(sp);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        String filePath = savePath+"/"+name;
        File f = new File(filePath);
        try {
            uploadFile.transferTo(f);
            String returnPath = "/"+IMG_SAVE_PATH+"/"+date+"/"+name;
            result = new Result(true,returnPath);
        } catch (IOException e) {
            e.printStackTrace();
            result = new Result(false,"");
        }
        return result;
    }
}
