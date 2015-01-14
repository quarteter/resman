package com.quartet.resman.service;

import com.quartet.resman.entity.Answer;
import com.quartet.resman.entity.Question;
import com.quartet.resman.repository.AnswerDao;
import com.quartet.resman.repository.QuestionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

/**
 * Created by XWANG on 2015/1/14.
 */
public class QuestionService {
    @Autowired
    QuestionDao questionDao;

    @Autowired
    AnswerDao  answerDao;

    public Page<Question> getAllQuestion(Pageable page) {
        return questionDao.findAll(page);
    }

    public Page<Question> getAllQuestion(Specification spec, Pageable page) {
        return questionDao.findAll(spec, page);
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
        questionDao.save( question );
        return true;
    }

    public void deleteAnswer( Long aid )
    {
        answerDao.delete( aid );
    }

}
