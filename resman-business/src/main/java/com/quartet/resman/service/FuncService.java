package com.quartet.resman.service;

import com.quartet.resman.entity.Func;
import com.quartet.resman.repository.FuncDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
@Service
public class FuncService {

    @Autowired
    private FuncDao funcDao;

    public List<Func> getRootFunc() {
        return funcDao.findByLevelOrderBySeqNoAsc(0);
    }


    public Page<Func> getFuncByParent(Long uid, Pageable page) {
        return funcDao.findByParent(uid, page);
    }

    public List<Func> getFuncByParent(Long pid) {
        return funcDao.findByParentOrderByLevelAscSeqNoAsc(pid);
    }

    public Page<Func> getFuncByParentAndLeaf(Long pid,Pageable page){
        return funcDao.findByParentAndLeafTrueOrderBySeqNoAsc(pid,page);
    }

    public void addFunc(Func func) {
        funcDao.save(func);
    }

    public void delFunc(Long uid) {
        funcDao.delete(uid);
    }
}
