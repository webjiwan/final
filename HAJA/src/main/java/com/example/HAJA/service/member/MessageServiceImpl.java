package com.example.HAJA.service.member;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.HAJA.model.member.dao.MessageDAO;
import com.example.HAJA.model.member.dto.MessageDTO;

@Service
public class MessageServiceImpl implements MessageService {

	@Inject
	MessageDAO messageDao;
	
	@Override
	public void create(MessageDTO dto) throws Exception {
		messageDao.create(dto);
	}

	@Override
	public int countNview(String receive) throws Exception {
		return messageDao.countNview(receive);
	}

	@Override
	public List<MessageDTO> list3(String receive) throws Exception {
		List<MessageDTO> list = messageDao.list3(receive);
		messageDao.yviewList3(receive);
		return list;
	}

	@Override
	public int count(String receive) throws Exception {
		return messageDao.count(receive);
	}

	@Override
	public List<MessageDTO> listAll(String receive, int start, int end) throws Exception {
		messageDao.yviewListAll(receive, start, end);
		return messageDao.listAll(receive, start, end);
	}

	@Override
	public void delete(int mno) throws Exception {
		messageDao.delete(mno);
	}

	@Override
	public String findReceive(int mno) throws Exception {
		return messageDao.findReceive(mno);
	}

}
