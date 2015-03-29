package com.quartet.resman.service;

        import com.quartet.resman.entity.ResComment;
        import com.quartet.resman.repository.ResCommentDao;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.data.domain.Page;
        import org.springframework.data.domain.Pageable;
        import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/3/25.
 */
@Service
public class ResCommentService {

    @Autowired
    private ResCommentDao resCommentDao;

    public Page<ResComment> getResComments(Pageable page){
        return resCommentDao.findAll(page);
    }

    public void addComment(ResComment resComment){
        resCommentDao.save(resComment);
    }

    public void deleteComment(Long id){
        resCommentDao.delete(id);
    }
}
