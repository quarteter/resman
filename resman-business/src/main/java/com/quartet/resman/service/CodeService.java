package com.quartet.resman.service;

import com.quartet.resman.entity.Code;
import com.quartet.resman.repository.CodeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lcheng on 2015/3/31.
 */
@Service
public class CodeService {

    @Autowired
    private CodeDao codeDao;

    public List<Code> getCode(String category){
        return codeDao.findByCategoryOrderBySeqNoAsc(category);
    }
}
