package com.quartet.resman.service;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.HomeWork;
import com.quartet.resman.entity.Info;
import com.quartet.resman.repository.HWRecordDao;
import com.quartet.resman.repository.HomeWorkDao;
import com.quartet.resman.repository.HomeWorkVoDao;
import com.quartet.resman.vo.HomeWorkVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lcheng on 2015/6/20.
 */
@Service
public class HomeWorkService {
    @Autowired
    private HomeWorkDao hwDao;
    @Autowired
    private HWRecordDao hwRecordDao;

    @Autowired
    private HomeWorkVoDao hwVODao;

    public void deleteHomeworks(Long[] ids){
        for (Long id : ids){
            hwRecordDao.deleteHomeworkRecords(id);
            hwDao.delete(id);
        }
    }


    public HomeWork getPreOrNextInfo(Long id,String dire){
        List<SearchFilter> filters = new ArrayList();
        SearchFilter f1 = null;
        if(dire.equalsIgnoreCase("pre")){
            f1 = new SearchFilter("id", SearchFilter.Operator.LT,id);
        } else if(dire.equalsIgnoreCase("next")){
            f1 = new SearchFilter("id", SearchFilter.Operator.GT,id);
        }
      //  SearchFilter f2 = new SearchFilter("publish", SearchFilter.Operator.EQ,true);
     //   SearchFilter f3 = new SearchFilter("type",SearchFilter.Operator.EQ, infoType);
        filters.add(f1);
       // filters.add(f2);
       // filters.add(f3);
        Pageable p = new PageRequest(0,1);
        Page<HomeWork> data = hwDao.findAll(DynamicSpecifications.bySearchFilter(filters, HomeWork.class), p);
        List<HomeWork> list = data.getContent();
        if(list!=null && list.size()>0){
            return list.get(0);
        }
        return null;
    }

}
