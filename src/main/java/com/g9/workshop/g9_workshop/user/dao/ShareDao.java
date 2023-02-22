package com.g9.workshop.g9_workshop.user.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
@Component
public class ShareDao {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public Object getList(String sqlMapId, Object dataMap) {
        Object result = sqlSessionTemplate.selectList(sqlMapId, dataMap);
        return result;
    }

    public Object getOne(String sqlMapId, Object dataMap) {
        Object result = sqlSessionTemplate.selectOne(sqlMapId, dataMap);
        return result;
    }

    // 갯수로 리턴된다 (update delete)
    public Object update(String sqlMapId, Object dataMap) {
        Object result = sqlSessionTemplate.update(sqlMapId, dataMap);
        return result;
    }

    public Object deleteOne(String sqlMapId, Object dataMap) {
        Object result = sqlSessionTemplate.delete(sqlMapId, dataMap);
        return result;
    }

    public Object insert(String sqlMapId, Object dataMap) {
        Object result = sqlSessionTemplate.insert(sqlMapId, dataMap);
        return result;
    }

}