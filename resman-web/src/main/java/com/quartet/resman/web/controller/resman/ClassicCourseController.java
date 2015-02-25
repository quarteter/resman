package com.quartet.resman.web.controller.resman;

import com.quartet.resman.entity.*;
import com.quartet.resman.rbac.ShiroUser;
import com.quartet.resman.service.Config;
import com.quartet.resman.service.UserService;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import com.quartet.resman.utils.Constants;
import com.quartet.resman.utils.Types;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Controller
@RequestMapping(value = "/res/course/classic")
public class ClassicCourseController {

    @Autowired
    private UserService userService;
    @Autowired
    private FileService fileService;
    @Autowired
    private FolderService folderService;
    @Autowired
    private Config paramService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "resman/classic-list";
    }


}
