package com.quartet.resman.service;

import com.quartet.resman.core.persistence.DynamicSpecifications;
import com.quartet.resman.core.persistence.SearchFilter;
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

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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

    public Page<QuestionVo> getAllPublishQuestionVo(Pageable page) {
        SearchFilter f1 = new SearchFilter("state", SearchFilter.Operator.EQ,"1");
        List<SearchFilter> filters = new ArrayList();
        filters.add(f1);
        return questionVoDao.findAll(DynamicSpecifications.bySearchFilter(filters, QuestionVo.class),page);
    }

    public Page<QuestionVo> getMyQuestionVo(Pageable page , Long ownerid ) {
        SearchFilter f1 = new SearchFilter("crtuser", SearchFilter.Operator.EQ,ownerid);
       // SearchFilter f2 = new SearchFilter("state", SearchFilter.Operator.EQ,"1");
        List<SearchFilter> filters = new ArrayList();
        filters.add(f1);
        //filters.add(f2);
        return questionVoDao.findAll(DynamicSpecifications.bySearchFilter(filters, QuestionVo.class),page);
    }

    public QuestionVo getQuestionVo(Long id )
    {
        return questionVoDao.getOne(id);
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
        question.addAnswer( answer  );
        answer.setQuesId(qid);
        //answer.setQuestion(question);
     //   questionDao.save( question );
        return true;
    }

   public void addAnswer(Answer answer)
   {
       answerDao.save(answer);
   }



    public void deleteAnswer( Long aid )
    {
        answerDao.delete( aid );
    }

    public Page<Answer> findAnswersByQuestion( Long qid ,Pageable page )
    {
       return answerDao.findByQuestion(qid, page );
    }


    public Answer getAnswer(Long aid )
    {
        return answerDao.getOne(aid);
    }


    public Page<Question> findQuestionByAnswerUser( Long userID ,Pageable page )
    {
        return questionDao.findQuestionByAnswerUser(userID, page);
    }
}
