package com.quartet.resman.web.controller.resman;

import com.quartet.resman.converter.DocConverter;
import com.quartet.resman.core.MimeTypeConfig;
import com.quartet.resman.entity.Document;
import com.quartet.resman.service.Config;
import com.quartet.resman.service.ResCountService;
import com.quartet.resman.store.FileService;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

/**
 * 文档相关操作
 * User: qfxu
 * Date: 15-1-22
 */
@Controller
@RequestMapping("res/document")
public class DocumentController {

    @Resource
    private FileService fileService;

    @Resource
    private DocConverter docConverter;

    @Resource
    private ResCountService resCountService;

    @Resource
    private Config config;

    /**
     * 下载文件
     *
     * @param uuid
     * @param response
     * @throws Exception
     */
    @RequestMapping("download")
    public void download(String uuid, HttpServletResponse response) throws Exception {
        resCountService.addDownCount(uuid);
        Document doc = fileService.getFileInfoByUUID(uuid);
        InputStream in = fileService.readFile(doc.getPath());
        if (in == null)
            return;
        response.reset();
        Cookie cookie = new Cookie(uuid,"complete");
        cookie.setPath("/");
        response.addCookie(cookie);
        response.setContentType("application/x-download");
        response.setCharacterEncoding("UTF-8");
        String fileDisplay = URLEncoder.encode(doc.getName(), "UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=" + fileDisplay);
        // 输出资源内容到相应对象
        byte[] b = new byte[1024];
        int len;
        OutputStream out = response.getOutputStream();
        while ((len = in.read(b, 0, 1024)) != -1) {
            out.write(b, 0, len);
        }

        IOUtils.closeQuietly(in);
        IOUtils.closeQuietly(out);
    }

    @RequestMapping("/view")
    public String view(String uuid, Model model) {
        resCountService.addViewCount(uuid);
        model.addAttribute("uuid", uuid);
        Document doc = fileService.getFileInfoByUUID(uuid);
        String mimeType = doc.getMimeType();
        if (docConverter.convertibleToSwf(mimeType)) {
            return "public/swfView";
        } else if (MimeTypeConfig.convertibleToPlay(mimeType)) {
            model.addAttribute("name", doc.getName());
            return "public/mediaPlay";
        } else {
            return "public/resDown";
        }
    }

    /**
     * 预览SWF文件
     *
     * @param uuid
     * @param response
     * @throws Exception
     */
    @RequestMapping("/swfView")
    public void swfView(String uuid, HttpServletResponse response) throws Exception {
        Document info = fileService.getFileInfoByUUID(uuid);
        String swfPath = config.getCachSWF() + java.io.File.separator + info.getUuid() + "." + MimeTypeConfig.EXT_SWF;

        InputStream in = null;
        OutputStream out = response.getOutputStream();
        java.io.File file = new java.io.File(swfPath);
        if (!file.exists()) {
            in = this.getClass().getResourceAsStream("/error.swf");
        } else {
            in = new FileInputStream(file);
        }
        response.reset();
        response.setCharacterEncoding("UTF-8");
        // 输出资源内容到相应对象
        byte[] b = new byte[1024];
        int len;
        while ((len = in.read(b, 0, 1024)) != -1) {
            out.write(b, 0, len);
        }
        IOUtils.closeQuietly(in);
        IOUtils.closeQuietly(out);
    }

    @RequestMapping("play")
    public void play(String uuid, HttpServletResponse response) throws Exception{
        Document info = fileService.getFileInfoByUUID(uuid);
        InputStream in = fileService.readFile(info.getPath());
        OutputStream out = response.getOutputStream();
        if (in == null) {
           return;
        }
        response.reset();
        response.setCharacterEncoding("UTF-8");
        // 输出资源内容到相应对象
        byte[] b = new byte[1024];
        int len;
        while ((len = in.read(b, 0, 1024)) != -1) {
            out.write(b, 0, len);
        }
        IOUtils.closeQuietly(in);
        IOUtils.closeQuietly(out);
    }
}
