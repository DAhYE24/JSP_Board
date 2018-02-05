<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<!-- class �۾� -->
<%
	/* �Խ��� ��ϰ� ��ü ���� �ľ� */ 
	ArrayList<BoardVO> list = dao.getList();
	int listCnt = dao.countList();
	int size = list.size();
	int listSize = size;

	/* TODO : ����¡ �۾� > �����ϱ� */
	final int ROWSIZE = 5;
	final int BLOCK = 5;
	int pg = 1;
	
	if (request.getParameter("pg") != null) {	// Ŭ���� �������� ���� ����, null�� �ƴ��� üũ�ϰ� ����
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	int end = (pg * ROWSIZE);
	int allPage = 0;
	int startPage = ((pg - 1) / BLOCK * BLOCK) + 1;
	int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK;
	allPage = (int) Math.ceil(listCnt / (double) ROWSIZE);	// Math.ceil �ݿø� �Լ�

	if (endPage > allPage) {
		endPage = allPage;
	}
	listSize -= end;
	if (listSize < 0) {
		end = size;
	}
%>
<!-- html �۾� -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<script>
	function searchKeyword(){
		var form = document.writeform;
		if (!form.inputKeyword.value) {
			alert("������ �����ּ���");
			form.inputKeyword.focus();
			return;
		}
		var selected = document.getElementsByName("keyField");
		console.log(selected[0].value);
		form.action="CheckPassword.jsp?type=" + selected[0].value;
		form.submit();
	}
</script>
</head>
<body>
	<br>
	<h3 align="center">�Խ���</h3>
	<br>
		<!-- �۾��� ��ư -->
		<div align="right" style="padding-right:100px;"><input type=button value="�۾���" OnClick="window.location='Write.jsp'"></div>
	<br>
	<!-- �Խñ� �����ִ� �Խ��� ���� -->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr height="6">
			<td width="5"></td>
		</tr>
		<!-- TODO :���̺� ���� ���ϱ� -->
		<tr align="center">
			<td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
			<td width="70">��ȣ</td>
			<td width="300">����</td>
			<td width="73">�ۼ���</td>
			<td width="164">�ۼ���</td>
			<td width="58">��ȸ��</td>
			<td width="7"><img src="img/table_right.gif" width="5" height="30" /></td>
		</tr>
		<!-- DB�� �Խñ� �����Ͱ� ���� ��� -->
		<%
			if (listCnt == 0) {
		%>
		<tr align="center" bgcolor="#FFFFFF" height="60">
			<td colspan="6">�Խ��ǿ� ��ϵ� ���� �����ϴ�</td>
		</tr>
		<!-- DB�� �Խñ� �����Ͱ� �ִ� ��� -->
		<%
			} else {
				for (int i = ROWSIZE * (pg - 1); i < end; i++) {
					BoardVO vo = list.get(i); // ������� VO ���� �޾ƿ���
					int boardIdx = vo.getBoardIdx(); // �۹�ȣ
		%>
		<!-- �Խñ� ���� ����ϱ� -->
		<tr height="30" align="center">
			<td align="center">&nbsp;</td>
			<td align="center"><%=boardIdx%></td>
			<td align="left">
				<a href="ShowWriting.jsp?boardIdx=<%=boardIdx%>&pg=<%=pg%>">
					<%=vo.getTitle()%>
				</a>
			</td>
			<td align="center"><%=vo.getUserName()%></td>
			<td align="center"><%=vo.getCreateAt()%></td>
			<td align="center"><%=vo.getHit()%></td>
			<td align="center">&nbsp;</td>
		<tr height="1" bgcolor="#D2D2D2">
			<td colspan="6"></td>
		</tr>
		<%
				}	// for��
			}	// if��
		%>
		<tr height="1" bgcolor="#82B5DF"> <!-- ���̺� �ؼ� -->
			<td colspan="6" width="752"></td>
		</tr>
	</table>

<!-- ������ �ѹ� ���� -->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		<tr>
			<td align="center">
			<%
				if (pg > BLOCK) {
			%>
			<a href="ShowList.jsp?pg=1">����</a>
			<a href="ShowList.jsp?pg=<%=startPage - 1%>">��</a>
			<%
				}
			%>
			<%
 				for (int i = startPage; i <= endPage; i++) {
 					if (i == pg) {
 			%>
 			<b><%=i%></b>
			<%
 					} else {
 			%>
 			<a href="ShowList.jsp?pg=<%=i%>"><%=i%></a>
 			<%
				 	}
 				}
			%>
			<%
 				if (endPage < allPage) {
 			%>
 			<a href="ShowList.jsp?pg=<%=endPage + 1%>">��</a>
 			<a href="ShowList.jsp?pg=<%=allPage%>">����</a>
 			<%
			 	}
 			%>
			</td>
		</tr>
		<!-- �˻�â -->
	</table>
	<br>
	<form name=writeform method=post>
	<div align="right">
				<select name="keyField">
  					<option value="title">����</option>
  					<option value="name">�ۼ���</option>
  					<option value="both">����+����</option>
				</select>
				<input type="text" name="inputKeyword"/>
				<input type="button" value="�˻�" onClick="javascript:searchKeyword()"/>
	</div>
	</form>
</body>
</html>