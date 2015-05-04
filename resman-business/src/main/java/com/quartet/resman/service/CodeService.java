package com.quartet.resman.service;

import com.quartet.resman.entity.Code;
import com.quartet.resman.repository.CodeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lcheng on 2015/3/31.
 */
@Service
public class CodeService {

    @Autowired
    private CodeDao codeDao;

    public Code getCode(Long id){
        return codeDao.findOne(id);
    }

    public List<Code> getCode(String category){
        return codeDao.findByCategoryOrderBySeqNoAsc(category);
    }

    public Page<Code> getCode(Pageable page){
        return codeDao.findAll(page);
    }

    public Page<Code> getCode(Specification<Code> spec,Pageable page){
        return codeDao.findAll(spec, page);
    }

    public void addCode(Code code){
        codeDao.save(code);
    }

    public void deleteCode(Long id){
        codeDao.delete(id);
    }

    public void deleteCode(List<Long> ids){
        for (Long id : ids){
            deleteCode(id);
        }
    }

    public Code getInfoCode(  String _codeType )
    {
        return codeDao.findByCategoryAndCode("info",_codeType);
    }
}
