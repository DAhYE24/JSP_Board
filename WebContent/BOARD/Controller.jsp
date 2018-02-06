<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<script type="text/javascript">
	<%
		/* �޾ƿ��� �� ���� */
		int idx = 0;
		String command = null;
		if(request.getParameter("idx") != null){
			idx = Integer.parseInt(request.getParameter("idx"));
		}
		if(request.getParameter("command") != null){
			command = request.getParameter("command");
		}
		
		if(command.equals("delete")){
			dao.deletePost(idx);
			%>
			location.href="boardList.jsp";
			<%
		}
		
		/* command�� ���� ��� ���� */
		if(command.equals("write")){	/* �� �ۼ� */
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.writePost(vo);
	%>
		alert("���� ��ϵǾ����ϴ�");
		location.href="boardList.jsp?pg=1";
	<%
		}else if(command.equals("modify")){
			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.modifyPost(vo, idx);
	%>
		alert("���� �����Ǿ����ϴ�");
		location.href="selectedPost.jsp?idx=<%=idx%>";
	<%
		}else if(command.equals("pwd")){	/* ��й�ȣ Ȯ��*/			
			String pwd = null;
			if(request.getParameter("password") != null){
				pwd = request.getParameter("password");
			}
			boolean chk = dao.checkPassword(idx, pwd);
			if(chk == true){
				out.print(0);
			}else{
				out.print(1);
			}
		}
		%>
</script>