<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<%
	// [������ ��]
	// ���� ���������� ������ �Ѿ���� �����ϱ�
	// ��й�ȣ�� �����ϸ� ������
	// modifyWrite() �����ϰ� �˸�â �� �Ŀ� ShowWriting.jsp�� �̵�
	int boardIdx = 0;
	BoardVO vo = new BoardVO();
	if(request.getParameter("boardIdx") != null){
		boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
	}
	if(boardIdx != 0){
		vo = dao.getWriteInfo(boardIdx);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>
	<% if(boardIdx == 0){ %>�۾���
	<% }else{ %>�����ϱ�<%} %>
</title>
<script type="text/javascript">
	function checkBlank() {
		var form = document.writeform;
		if (!form.title.value) {
			alert("������ �����ּ���");
			form.title.focus();
			return;
		}
		if (!form.name.value) {
			alert("�̸��� �����ּ���");
			form.name.focus();
			return;
		}
		if (!form.password.value) {
			alert("��й�ȣ�� �����ּ���");
			form.password.focus();
			return;
		}		
		if (!form.memo.value) {
			alert("������ �����ּ���");
			form.memo.focus();
			return;
		}
		form.submit();
	}
</script>
</head>
<body>
<form name=writeform method=post action="Controller.jsp?type=write">
	<h4 style="padding-left:180px">
		<!-- TODO : �ݺ��Ǵ°� ���� �������� �ƴϸ� ()? : �̰ŷ� �ذ� �������� -->
		<% if(boardIdx == 0){ %>�۾���
		<% }else{ %>�����ϱ�<%} %>
	</h4>
	<table>
		<tr>
			<td>&nbsp;</td>
			<td align="center">����</td>
			<td>
				<input name="title" size="50" maxlength="100"
				<%if(boardIdx != 0){%>
				value="<%=vo.getTitle()%>"
				<%} %>
				>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr height="1" bgcolor="#dddddd">
			<td colspan="4"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="center">�̸�</td>
			<td>
				<input name="name" size="50" maxlength="50"
				<%if(boardIdx != 0){%>
				value="<%=vo.getUserName()%>"
				<%} %>
				>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr height="1" bgcolor="#dddddd">
			<td colspan="4"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="center">��й�ȣ</td>
			<td><input type="password" name="password" size="50" maxlength="50"></td>
			<td>&nbsp;</td>
		</tr>
		<tr height="1" bgcolor="#dddddd">
			<td colspan="4"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="center">����</td>
			<td>
				<textarea name="memo" cols="50" rows="13"><%if(boardIdx != 0){%><%=vo.getMemo()%><%} %></textarea>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr height="1" bgcolor="#dddddd">
			<td colspan="4"></td>
		</tr>
		<tr height="1" bgcolor="#82B5DF">
			<td colspan="4"></td>
		</tr>
		<tr align="center">
			<td>&nbsp;</td>
			<td colspan="2">
				<input type=button 
					<% if(boardIdx != 0){ %> value="����"
					<%}else{ %> value="���" <%} %> OnClick="javascript:checkBlank();"
				>
				<input type=button value="���"
					<% if(boardIdx != 0){ %> OnClick="window.location='ShowWriting.jsp?boardIdx=<%=boardIdx%>'"
					<%}else{ %> OnClick="window.location='ShowList.jsp?pg=1'" <%} %>>
			<td>&nbsp;</td>
		</tr>
	</table>
</form>
</body>
</html>
