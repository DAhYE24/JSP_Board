<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<script type="text/javascript">
	<%
	System.out.println("�� �� �� ����??");
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
		}else if(type.equals("pwd")){
			String pwd = null;
			String next = null;			
			if(request.getParameter("password") != null){
				pwd = request.getParameter("password");
			}
			if(request.getParameter("next") != null){
				next = request.getParameter("next");
			}
			System.out.println("�����մϴ�");
			/* ��й�ȣ �´��� Ȯ��*/
			boolean chk = dao.checkPassword(boardIdx, pwd);
			System.out.println(chk);
			if(chk == true){
			}else{%>
				self.window.alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
				location.href="javascript:history.back()";
			<%}
		}%>
</script>