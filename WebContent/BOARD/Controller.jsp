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
		
		/* type�� ���� ��� ���� */
		if(type.equals("delete")){	/* �� ���� */
			dao.deleteWrite(boardIdx);	
	%>
	alert("���� �����Ǿ����ϴ�");
	location.href="ShowList.jsp";	
	<%
		}else if(type.equals("write")){	/* �� �ۼ� */
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.insertWrite(vo);
	%>
	alert("���� ��ϵǾ����ϴ�");
	location.href="ShowList.jsp?pg=1";
	<%
		}
	%>
</script>