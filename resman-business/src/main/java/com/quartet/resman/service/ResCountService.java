package com.quartet.resman.service;

import com.quartet.resman.entity.ResComment;
import com.quartet.resman.entity.ResCount;
import com.quartet.resman.repository.ResCommentDao;
//import com.quartet.resman.repository.ResCountDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2015/3/25.
 */
@Service
public class ResCountService {
//
//    @Resource
//    private ResCountDao resCountDao;
//
//    public ResCount getResCount(String uuid) {
//        ResCount count = resCountDao.findOne(uuid);
//        if (count==null) {
//            count = new ResCount();
//            count.setId(uuid);
//        }
//        return count;
//    }
//
//
//    public int addViewCount(String uuid) {
//        ResCount count = resCountDao.findOne(uuid);
//        if (count == null) {
//            count = new ResCount();
//            count.setId(uuid);
//        }
//        int tmp = count.getViewCount();
//        tmp++;
//        count.setViewCount(tmp);
//        count = resCountDao.save(count);
//        return count.getViewCount();
//    }
//
//
//    public int addDownCount(String uuid) {
//        ResCount count = resCountDao.findOne(uuid);
//        if (count == null) {
//            count = new ResCount();
//            count.setId(uuid);
//        }
//        int tmp = count.getDownCount();
//        tmp++;
//        count.setDownCount(tmp);
//        count = resCountDao.save(count);
//        return count.getDownCount();
//    }

}
