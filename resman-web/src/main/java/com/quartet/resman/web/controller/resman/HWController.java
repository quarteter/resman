package com.quartet.resman.web.controller.resman;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.repository.HWRecordDao;
import com.quartet.resman.repository.HomeWorkDao;
import com.quartet.resman.service.HomeWorkService;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.FileUtils;
import com.quartet.resman.utils.Types;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.*;

/**
 * Created by lcheng on 2015/6/20.
 */
@Controller
@RequestMapping(value = "/res/hw")
public class HWController {
    @Autowired
    private HomeWorkDao hwDao;
    @Autowired
    private HWRecordDao hwRecordDao;
    @Autowired
    private FolderService folderService;
    @Autowired
    private FileService fileService;
    @Autowired
    private UserService userService;
    @Autowired
    private HomeWorkService hwService;

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String list(){
        return "resman/hw-list";
    }

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> query(String searchText,@PageableDefault(size = 10,
            sort = "publishDate",direction = Sort.Direction.DESC) Pageable page){
        Map<String,Object> result = new HashMap<>();
        Page<HomeWork> data = null;
        if (StringUtils.isNotEmpty(searchText)) {
            SearchFilter filter = new SearchFilter("name", SearchFilter.Operator.LIKE, searchText);
            List<SearchFilter> filters = new ArrayList<>(1);
            filters.add(filter);
            Specification spec = DynamicSpecifications.bySearchFilter(filters, User.class);
            data = hwDao.findAll(spec,page);
        } else {
            data = hwDao.findAll(page);
        }
        result.put("rows", data.getContent());
        result.put("total", data.getTotalElements());
        return result;
    }

    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String add(){
        return "resman/hw-add";
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public String add(HomeWork hw){
        //Result result = null;
        try{
            if (hw!=null){
                ShiroUser user = userService.getCurrentUser();
                hw.setPublishDate(new Date());
                hwDao.save(hw);
                String path = "/hw/"+hw.getName();
                Folder hwfolder = new Folder(path,user.getUserName(), Types.Folders.Homework.getValue());
                folderService.addFolder(hwfolder);
            }
            //result = new Result(true,"");
        }catch (Exception e){
            //result = new Result(false,"");
        }
        return "redirect:/res/hw/list";
    }

    @RequestMapping(value = "/edit",method = RequestMethod.GET)
    public String edit(Long id,Model model){
        HomeWork hw = hwDao.findOne(id);
        model.addAttribute("hw",hw);
        return "resman/hw-edit";
    }

    @RequestMapping(value = "/del",method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@RequestParam(value = "ids[]") Long[] ids){
        Result result = null;
        try{
            hwService.deleteHomeworks(ids);
            result = new Result(true,"");
        }catch (Exception e){
            result = new Result(false,"");
        }
        return result;
    }


    @RequestMapping(value="/records/{hkId}",method = RequestMethod.GET)
    public String record(@PathVariable("hkId") Long hkId,Model model){
        model.addAttribute("hkId",hkId);
        return "resman/hw-record-list";
    }

    @RequestMapping(value = "/records/query/{hkId}",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> recordQuery(@PathVariable("hkId")Long hkId,String searchText){
        Map<String,Object> result = new HashMap<>();
        List<HomeWorkRecord> records = new ArrayList<>();
        if(StringUtils.isNotEmpty(searchText)){
            records = hwRecordDao.findByHkIdAndSubmitterLike(hkId,searchText);
        }else{
            records = hwRecordDao.findByHkId(hkId);
        }
        result.put("rows",records);
        return result;
    }

    @RequestMapping(value = "/records/submit",method = RequestMethod.POST)
    public String submitHomework(Long hwId,MultipartFile file){
        ShiroUser user = userService.getCurrentUser();
        User u = userService.getUser(user.getId());
        HomeWork hw = hwDao.findOne(hwId);
        String fileName = file.getOriginalFilename();
        try{
            InputStream in = file.getInputStream();
            String filePath = "/hw/"+hw.getName();
            String mimeType = FileUtils.getFileExtension(fileName).toLowerCase();
            Folder f = folderService.getFolder(filePath);
            if (f==null){
                f = new Folder(filePath,user.getUserName(),Types.Folders.Homework.getValue());
                folderService.addFolder(f);
            }
            filePath = filePath+"/"+fileName;
            Document doc = new Document(filePath + fileName, user.getUserName(), new FileStream(in), file.getSize());
            doc.setMimeType(mimeType);
            fileService.addFile(doc);
            IOUtils.closeQuietly(in);

            HomeWorkRecord record = new HomeWorkRecord();
            record.setDocUid(doc.getUuid());
            record.setHkId(hwId);
            record.setFileName(fileName);
            record.setSubmitDate(new Date());
            record.setSubmitter(u.getName());
            record.setSubmitterId(user.getId());
            hwRecordDao.save(record);

        }catch (Exception e){
            e.printStackTrace();
        }
        return "dddd";
    }

    @RequestMapping(value = "/record/score",method = RequestMethod.POST)
    @ResponseBody
    public Result recordScore(Long id,float score){
        Result result = null;
        try{
            hwRecordDao.updateScore(id,score);
            result = new Result(true,"");
        }catch(Exception e){
            e.printStackTrace();
            result = new Result(false,"");
        }
        return result;
    }
}
