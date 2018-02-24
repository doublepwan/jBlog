package com.javaex.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UsersVo;

@Repository
public class UsersDao {

	@Autowired
	SqlSession sqlsession;

	public void join(UsersVo userVo) {
		sqlsession.insert("users.join", userVo);
	}

	public UsersVo login(String id, String password) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("password", password);

		return sqlsession.selectOne("users.login", map);
	}
	
	public UsersVo idCheck(String id) {
		UsersVo usersVo = sqlsession.selectOne("users.idCheck", id);
		return usersVo;
	}

	public int getUserNo(String id) {
		return sqlsession.selectOne("users.getUserNo", id);
	}

	public UsersVo getUser(String id) {
		UsersVo user = sqlsession.selectOne("users.getUser", id);
		return user;
	}

	public int blogMainUser(String id) {
		
		return sqlsession.selectOne("users.blogMainUser", id);
	}

}
