package com.quartet.resman.service;

import com.quartet.resman.repository.HWRecordDao;
import com.quartet.resman.repository.HomeWorkDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by lcheng on 2015/6/20.
 */
@Service
public class HomeWorkService {
    @Autowired
    private HomeWorkDao hwDao;
    @Autowired
    private HWRecordDao hwRecordDao;


    public void deleteHomeworks(Long[] ids){
        for (Long id : ids){
            hwRecordDao.deleteHomeworkRecords(id);
            hwDao.delete(id);
        }
    }
}
