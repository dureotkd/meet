package com.sbs.meet.intercepter;

import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sbs.meet.dto.Member;
import com.sbs.meet.service.MemberService;

@Component("beforeActionInterceptor") // 컴포넌트 이름 설정
public class BeforeActionInterceptor implements HandlerInterceptor {

	@Autowired
	private MemberService memberService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 기타 유용한 정보를 request에 담는다.
		Map<String, Object> param = new HashMap<>();

		Enumeration<String> parameterNames = request.getParameterNames();

		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			Object paramValue = request.getParameter(paramName);

			param.put(paramName, paramValue);
		}

		ObjectMapper mapper = new ObjectMapper();
		String paramJson = mapper.writeValueAsString(param);

		String requestUri = request.getRequestURI();
		String queryString = request.getQueryString();

		String requestUriQueryString = requestUri;
		if (queryString != null && queryString.length() > 0) {
			requestUriQueryString += "?" + queryString;
		}

		String encodedRequestUriQueryString = URLEncoder.encode(requestUriQueryString, "UTF-8");

		request.setAttribute("requestUriQueryString", requestUriQueryString);
		request.setAttribute("urlEncodedRequestUriQueryString", encodedRequestUriQueryString);
		request.setAttribute("param", param);
		request.setAttribute("paramJson", paramJson);

		boolean isAjax = requestUri.endsWith("Ajax");

		if (isAjax == false) {
			if (param.containsKey("ajax") && param.get("ajax").equals("Y")) {
				isAjax = true;
			}
		}

		request.setAttribute("isAjax", isAjax);

		// 설정 파일에 있는 정보를 request에 담는다.
		HttpSession session = request.getSession();
		
		Object obj = session.getAttribute("logiendMemberId");
		
		if ( obj == null ) {
			// 로그인 된 세션이 없는 경우.
			// 만들어 논 쿠키를 꺼내온다..
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			// loginCookie의 값을 꺼내오고 -> 즉 , 저장해논 세션 Id를 꺼내온다
			if ( loginCookie != null ) {
				String sessionId = loginCookie.getValue();
				Member member = memberService.checkUseWithSessionKey(sessionId);
				System.out.println("쿠키확인" + member);
				//  그런 사용자가 있다며 세션 생성
				if ( member != null ) {
					session.setAttribute("loginedMemberId",member.getId());
				}
			}
			// 세션 Id를 checkUseWithSessionKey에 전달해 이전에 로그인한적이 있는지 체크하는 메서드 
			// 유효시간이 > now() 인 즉 아직 유효시간이 지나지 않으면서 해당 sessionId 정보를 가지고 있는 사용자 정보를 반환해준다
			
		

		}
		

		
		


		// 로그인 여부에 관련된 정보를 request에 담는다.
		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;

		if (session.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			isLogined = true;
			loginedMember = memberService.getMemberById(loginedMemberId);
		}

		request.setAttribute("loginedMemberId", loginedMemberId);
		request.setAttribute("isLogined", isLogined);
		request.setAttribute("loginedMember", loginedMember);
		System.out.println("로그인정보 :"+loginedMember);
		
		
		
		
		

		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
