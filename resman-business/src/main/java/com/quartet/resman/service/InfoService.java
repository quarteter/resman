package com.quartet.resman.service;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
import com.quartet.resman.entity.Info;
import com.quartet.resman.repository.InfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lcheng on 2015/3/25.
 */
@Service
public class InfoService {

    @Autowired
    private InfoDao infoDao;

    public Page<Info> getInfo(Pageable page){
        return infoDao.findAll(page);
    }

    public Page<Info> getInfo(boolean publish, Pageable page){
        return infoDao.findByPublish(publish, page);
    }

    public Page<Info> getInfo(String type,Pageable page){
        return infoDao.findByType(type, page);
    }

    public Page<Info> getInfo(String type,boolean publish,Pageable page){
        return infoDao.findByTypeAndPublish(type, publish, page);
    }

    public Page<Info> getBannerInfo(String type,boolean publish,Pageable page){
        List<SearchFilter> filters = new ArrayList();
        SearchFilter f1 = new SearchFilter("type", SearchFilter.Operator.EQ,type);
        SearchFilter f2 = new SearchFilter("publish", SearchFilter.Operator.EQ,publish);
        SearchFilter f3 = new SearchFilter("bannerNews", SearchFilter.Operator.EQ,true);
        filters.add(f1);
        filters.add(f2);
        filters.add(f3);
        return infoDao.findAll(DynamicSpecifications.bySearchFilter(filters, Info.class), page);
    }

    public Page<Info> getBannerInfo(boolean publish,Pageable page){
        List<SearchFilter> filters = new ArrayList();
        SearchFilter f2 = new SearchFilter("publish", SearchFilter.Operator.EQ,publish);
        SearchFilter f3 = new SearchFilter("bannerNews", SearchFilter.Operator.EQ,true);
        filters.add(f2);
        filters.add(f3);
        return infoDao.findAll(DynamicSpecifications.bySearchFilter(filters, Info.class), page);
    }

    public Page<Info> getImageInfo(String type,boolean publish,Pageable page){
          return infoDao.findByTypeAndPublishHasImage( type ,publish ,page );
    }




    public Info getFirstBannerInfo(String type){
        Pageable p = new PageRequest(0,1,new Sort(Sort.Direction.DESC,"crtdate"));
        Page<Info> page = getBannerInfo(type, true, p);
        List<Info> content = page.getContent();
        if (content!=null && content.size()>0){
            Info info = content.get(0);
            info.getContent();
            return info;
        }
        return null;
    }

    public Info getPreOrNextInfo(Long id,String dire,String infoType){
        List<SearchFilter> filters = new ArrayList();
        SearchFilter f1 = null;
        if(dire.equalsIgnoreCase("pre")){
            f1 = new SearchFilter("id", SearchFilter.Operator.LT,id);
        } else if(dire.equalsIgnoreCase("next")){
            f1 = new SearchFilter("id", SearchFilter.Operator.GT,id);
        }
        SearchFilter f2 = new SearchFilter("publish", SearchFilter.Operator.EQ,true);
        SearchFilter f3 = new SearchFilter("type",SearchFilter.Operator.EQ, infoType);
        filters.add(f1);
        filters.add(f2);
        filters.add(f3);
        Pageable p = new PageRequest(0,1);
        Page<Info> data = infoDao.findAll(DynamicSpecifications.bySearchFilter(filters, Info.class), p);
        List<Info> list = data.getContent();
        if(list!=null && list.size()>0){
            return list.get(0);
        }
        return null;
    }

    public Info getInfo(Long id){
        return infoDao.findOne(id);
    }

    public Info getInfoEager(Long id){
        Info info = infoDao.getOne(id);
        info.getContent();
        return info;
    }

    public void updateInfoPublishState(Long id,boolean publish){
        infoDao.updateInfoPublishState(id, publish);
    }

    public void updateInfoReadCount(Long id){
       infoDao.updateInfoReadCount(id);
    }

    public void addInfo(Info info){
        infoDao.save(info);
    }

    public void deleteInfo(Long id){
        infoDao.delete(id);
    }
}
