package com.quartet.resman.service;

import com.quartet.resman.entity.DocCourse;
import com.quartet.resman.entity.Document;
import com.quartet.resman.entity.Folder;
import com.quartet.resman.repository.DocCourseDao;
import com.quartet.resman.store.FileService;
import com.quartet.resman.store.FolderService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lcheng on 2015/5/1.
 */
@Service
public class CourseService {

    @Autowired
    private DocCourseDao courseDao;

    @Autowired
    private FolderService folderService;

    public void addOrUpdateDocCourse(Folder folder, DocCourse course) {
        if (folder.getUuid() != null) {
            folderService.updateFolder(folder);
        } else {
            folderService.addFolder(folder);
        }
        String uid = folder.getUuid();
        course.setDocUid(uid);

        courseDao.save(course);
    }

    public DocCourse getDocCourseByUid(String uid) {
        if (StringUtils.isNotEmpty(uid)) {
            List<DocCourse> courses = courseDao.findByDocUid(uid);
            return courses != null && courses.size() > 0 ? courses.get(0) : null;
        }
        return null;
    }

}
