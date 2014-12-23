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

    public Page<Func> getFuncByParentAndLeaf(Long pid, Pageable page) {
        return funcDao.findByParentAndLeafTrueOrderBySeqNoAsc(pid, page);
    }

    public void addFunc(Func func) {
        funcDao.save(func);
    }

    public void adjustFuncSeqNo(Long srcId, Long targetId, String type) {
        Func src = funcDao.getOne(srcId);
        Func target = funcDao.getOne(targetId);
        Long parent = target.getParent();
        Integer srcSeqNo = src.getSeqNo();
        Integer targetSeqNo = target.getSeqNo();
        Integer srcLevel = src.getLevel();
        Integer targetLevel = target.getLevel();
        if (srcLevel != targetLevel) {
            return;
        }
        if (type.equals("prev")) {
            if (srcSeqNo > targetSeqNo) {
                funcDao.updateSeqNoPre(parent, targetSeqNo, srcSeqNo);
            } else {
                funcDao.updateSeqNoPre(parent, targetSeqNo);
            }
            src.setSeqNo(targetSeqNo);
            funcDao.save(src);
        } else if (type.equals("next")) {
            if (srcSeqNo > targetSeqNo) {
                funcDao.updateSeqNoNext(parent, targetSeqNo, srcSeqNo);
            } else {
                funcDao.updateSeqNoNext(parent, targetSeqNo);
            }
            src.setSeqNo(targetSeqNo + 5);
            funcDao.save(src);

        }
    }

    public void delFunc(Long uid) {
        funcDao.delete(uid);
    }
}
