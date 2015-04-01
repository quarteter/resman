package com.quartet.resman.service;

import com.quartet.resman.entity.Info;
import com.quartet.resman.repository.InfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

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
        return infoDao.findByType(type,page);
    }

    public Page<Info> getInfo(String type,boolean publish,Pageable page){
        return infoDao.findByTypeAndPublish(type,publish,page);
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
        infoDao.updateInfoPublishState(id,publish);
    }

    public void addInfo(Info info){
        infoDao.save(info);
    }

    public void deleteInfo(Long id){
        infoDao.delete(id);
    }
}
