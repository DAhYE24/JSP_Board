<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*" %>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<script type="text/javascript">
	<%
		/* GET/POST ��� ������ ó�� */
		int idx = 0; // �Խñ� ��ȣ
		String command = null; // ���� ��� ����
		if(request.getParameter("idx") != null){
			idx = Integer.parseInt(request.getParameter("idx"));
		}
		if(request.getParameter("command") != null){
			command = request.getParameter("command");
		}
		
		/* command ���� ���� ��� ���� */
		if(command.equals("write")){ // ���(1) �Խñ� �ۼ�
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.writePost(vo);
		%>		
			alert("���� ��ϵǾ����ϴ�");
			location.href="boardList.jsp?pg=1"; <!-- �� ��� �� �Խ��� ù �������� �̵� -->
		<%
		}else if(command.equals("modify")){ // ���(2) �Խñ� ����
			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.modifyPost(vo, idx);
	%>
		alert("���� �����Ǿ����ϴ�");
		location.href="selectedPost.jsp?idx=<%= idx %>"; <!-- �� ���� �� �ش� �� �������� �̵� -->
	<%
		}else if(command.equals("check")){ // ���(3) ��й�ȣ Ȯ��	
			String pwd = null;
			String role = null; // ��й�ȣ Ȯ�� ��û�� ���� : �� ����(modify), �� ����(delete)
			if(request.getParameter("pwd") != null){
				pwd = request.getParameter("pwd");
			}
			if(request.getParameter("role") != null){
				role = request.getParameter("role");
			}
			
			boolean chk = dao.checkPassword(idx, pwd);
			if(chk == true){ // ��й�ȣ ����
				if(role.equals("modify")){ // �ش� �Խñ� ������ ���
					%>
					location.href="write.jsp?idx=" + <%= idx %>;
					<%
				}else if(role.equals("delete")){ // �ش� �Խñ� ������ ���
					dao.deletePost(idx);
					%>
					alert("�Խù��� �����մϴ�");
					location.href="boardList.jsp?pg=1";
					<%
				}
			}else if(chk == false){ // ��й�ȣ ����
				%>
				alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
				location.href="selectedPost.jsp?idx=" + <%= idx %>; // �ش� �Խñ۷� �̵�
				<%
			}
		}
		%>
</script>