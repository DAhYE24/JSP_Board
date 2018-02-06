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
		
		/* command ���� ���� ��� ���� */
		if(command.equals("write")){ // �Խñ� �ۼ�
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
		}else if(command.equals("modify")){ // �Խñ� ����
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
		}else if(command.equals("check")){ // ��й�ȣ Ȯ��	
			String pwd = null;
			String role = null;
			if(request.getParameter("pwd") != null){
				pwd = request.getParameter("pwd");
			}
			if(request.getParameter("role") != null){
				role = request.getParameter("role");
			}
			
			boolean chk = dao.checkPassword(idx, pwd);
			System.out.println(chk);
			if(chk == true){
				if(role.equals("modify")){
					%>
					location.href="write.jsp?idx=" + <%= idx %>;
					<%
				}else if(role.equals("delete")){
					dao.deletePost(idx);
					%>
					alert("�Խù��� �����մϴ�");
					location.href="boardList.jsp";
					<%
				}
			}else if(chk == false){
				%>
				alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
				location.href="selectedPost.jsp?idx=" + <%=idx%>;
				<%
			}
		}
		%>
</script>