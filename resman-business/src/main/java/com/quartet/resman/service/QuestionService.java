package com.quartet.resman.service;

import com.quartet.resman.entity.Answer;
import com.quartet.resman.entity.Question;
import com.quartet.resman.repository.AnswerDao;
import com.quartet.resman.repository.QuestionDao;
import com.quartet.resman.repository.QuestionVoDao;
import com.quartet.resman.vo.QuestionVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * Created by XWANG on 2015/1/14.
 */
@Service
public class QuestionService {
    @Autowired
    QuestionDao questionDao;

    @Autowired
    QuestionVoDao questionVoDao;

    @Autowired
    AnswerDao  answerDao;

    public Page<QuestionVo> getAllQuestionVo(Pageable page) {
        return questionVoDao.findAll(page);
    }

    public Page<QuestionVo> getAllQuestionVo(Specification spec, Pageable page) {
        return questionVoDao.findAll(spec, page);
    }

    public Question getQuestion(Long qid) {
        return questionDao.findOne(qid);
    }

       public Question saveQuestion( Question question )
    {
        return questionDao.save( question );
    }

    public void deleteQuestion( Long qid )
    {
        questionDao.delete(qid);
    }

    public boolean addAnswer(Long qid , Answer answer)
    {
        Question question = getQuestion( qid );
        if( question == null )
        {
            String tip = String.format("内部错误：ID为[%d]的问答不存在!",qid);
            return false;
        }
        question.addAnswer( answer );
        answer.setQuestion(question);
     //   questionDao.save( question );
        return true;
    }



    public void deleteAnswer( Long aid )
    {
        answerDao.delete( aid );
    }

}
