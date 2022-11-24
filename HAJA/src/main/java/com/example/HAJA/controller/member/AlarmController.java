package com.example.HAJA.controller.member;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.HAJA.controller.board.BoardController;
import com.example.HAJA.model.member.dto.AlarmDTO;
import com.example.HAJA.service.member.AlarmService;
import com.example.HAJA.service.pager.Pager;

@RestController
@RequestMapping("alarm/*")
public class AlarmController {
	private static final Logger logger = LoggerFactory.getLogger(AlarmController.class);
	
	@Inject
	AlarmService alarmService;
	
	@RequestMapping("recentAlarmUpdate.do")
	public AlarmUpdateDTO recentAlarmUpdate(HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		List<AlarmDTO> list = alarmService.list3(userid);
		
		AlarmUpdateDTO alarmUpdateDto = new AlarmUpdateDTO();
		alarmUpdateDto.setAlarmCnt(alarmService.countNview(userid));
		alarmUpdateDto.setList(list);
		
		session.setAttribute("alarmNviewCnt", alarmUpdateDto.getAlarmCnt());
		return alarmUpdateDto;
	}
	
	// recentAlarmUpdate.do DTO
	public class AlarmUpdateDTO {
		int alarmCnt;
		List<AlarmDTO> list;
		public int getAlarmCnt() {
			return alarmCnt;
		}
		public void setAlarmCnt(int alarmCnt) {
			this.alarmCnt = alarmCnt;
		}
		public List<AlarmDTO> getList() {
			return list;
		}
		public void setList(List<AlarmDTO> list) {
			this.list = list;
		}
	}
	
	@RequestMapping("alarmList")
	public ModelAndView alarmList() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("haja/member/alarm_list");
		return mav;
	}
	
	@RequestMapping("alarmList.do")
	public AlarmListDTO alarmList(
			@RequestParam(defaultValue = "1") int curPage,
			HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		int count = alarmService.count(userid);
		
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<AlarmDTO> list = alarmService.listAll(userid, start, end);
		
		AlarmListDTO alarmListDto = new AlarmListDTO();
		alarmListDto.setAlarmCnt(alarmService.countNview(userid));
		alarmListDto.setList(list);
		alarmListDto.setPager(pager);
		
		session.setAttribute("alarmNviewCnt", alarmListDto.getAlarmCnt());
		return alarmListDto;
	}
	
	// alarmList.do DTO
	public class AlarmListDTO {
		int alarmCnt;
		List<AlarmDTO> list;
		Pager pager;
		public int getAlarmCnt() {
			return alarmCnt;
		}
		public void setAlarmCnt(int alarmCnt) {
			this.alarmCnt = alarmCnt;
		}
		public List<AlarmDTO> getList() {
			return list;
		}
		public void setList(List<AlarmDTO> list) {
			this.list = list;
		}
		public Pager getPager() {
			return pager;
		}
		public void setPager(Pager pager) {
			this.pager = pager;
		}
	}
	
	@RequestMapping("delete.do")
	public ResponseEntity<String> delete(HttpSession session, int ano) throws Exception {
		String userid = (String) session.getAttribute("userid");
		String findId = alarmService.findUserid(ano);
		findId = (findId == null) ? "" : findId;
		
		if (userid == null || !userid.equals(findId)) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		alarmService.delete(ano);
		session.setAttribute("alarmNviewCnt", alarmService.countNview(userid));
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
