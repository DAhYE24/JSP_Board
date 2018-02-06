<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<script type="text/javascript">
	<%
		int boardIdx = 0;
		String type = null;
		if(request.getParameter("boardIdx") != null){
			boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		}
		if(request.getParameter("type") != null){
			type = request.getParameter("type");
		}
		
		if(type.equals("delete")){
			dao.deletePost(boardIdx);
			%>
			location.href="ShowList.jsp";
			<%
		}
		
		/* type�� ���� ��� ���� */
		if(type.equals("write")){	/* �� �ۼ� */
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.writePost(vo);
	%>
		alert("���� ��ϵǾ����ϴ�");
		location.href="ShowList.jsp?pg=1";
	<%
		}else if(type.equals("modify")){
			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.modifyPost(vo, boardIdx);
	%>
		alert("���� �����Ǿ����ϴ�");
		location.href="ShowWriting.jsp?boardIdx=<%=boardIdx%>";
	<%
		}else if(type.equals("pwd")){	/* ��й�ȣ Ȯ��*/			
			String pwd = null;
			if(request.getParameter("password") != null){
				pwd = request.getParameter("password");
			}
			boolean chk = dao.checkPassword(boardIdx, pwd);
			if(chk == true){
				out.print(0);
			}else{
				out.print(1);
			}
		}
		%>
</script>