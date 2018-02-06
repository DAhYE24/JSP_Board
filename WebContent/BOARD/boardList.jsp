<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<!-- class �۾� -->
<%
	/* �Խ��� ��� �ҷ����� */ 
	String keyField = null;	// <select>, �˻� ����
	String keyWord = null; // �˻� Ű����
	if(request.getParameter("keyWord") != null){ // ������ null ���� Ȯ��
		keyField = request.getParameter("keyField");
	    keyWord = request.getParameter("keyWord");
	}	
	ArrayList<BoardVO> arrList = dao.getList(keyField, keyWord);
	int postCnt = dao.countPost();
	int size = arrList.size();
	int listSize = size;

	/* TODO : ����¡ �����ϱ� */
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
	allPage = (int) Math.ceil(postCnt / (double) ROWSIZE);	// Math.ceil() �ݿø�

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
		var form = document.searchform;
		if (!form.keyWord.value) {
			alert("�˻��� ������ �����ּ���");
			form.keyWord.focus();
			return;
		}
		var selectedItem = document.getElementsByName("keyField");
		console.log(selectedItem[0].value);
		form.submit();
	}
</script>
</head>
<body>
	<br>
	<h3 align="center">�Խ���</h3>
	<br>
		<!-- �۾��� ��ư -->
		<div align="right" style="padding-right:100px;">
			<input type=button value="�۾���" OnClick="window.location='write.jsp'">
		</div>
	<br>
	<!-- �Խ��� ���� -->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr height="6">
			<td width="5"></td>
		</tr>
		<tr align="center">
			<td width="5"/></td>
			<td width="70">��ȣ</td>
			<td width="300">����</td>
			<td width="73">�ۼ���</td>
			<td width="164">�ۼ���</td>
			<td width="58">��ȸ��</td>
			<td width="7"/></td>
		</tr>
		<%
			// ī���õ� �Խñ� ������ ���� 0�� ���
			if (postCnt == 0) {
		%>
				<tr align="center" bgcolor="#FFFFFF" height="60">
				<td colspan="6">�Խ��ǿ� ��ϵ� ���� �����ϴ�</td>
			</tr>
		<%
			} else { // DB�� �Խñ� �����Ͱ� �ִ� ���
				/* String time = null; */
				for (int i = ROWSIZE * (pg - 1); i < end; i++) {
					BoardVO vo = arrList.get(i); // ������� VO ���� �޾ƿ���
		%>
		<!-- �Խñ� ���� ����ϱ� -->
		<tr height="30" align="center">
			<td align="center">&nbsp;</td>
			<td align="center"><%=vo.getBoardIdx()%></td>
			<td align="left">
				<a href="selectedPost.jsp?idx=<%= vo.getBoardIdx() %>&pg=<%= pg %>">
					<%=vo.getTitle()%>
				</a>
			</td>
			<td align="center"><%= vo.getUserName() %></td>
			<td align="center"><%= vo.getCreateAt().substring(0,10) %></td>
			<td align="center"><%= vo.getHit() %></td>
			<td align="center">&nbsp;</td>
		<tr height="1" bgcolor="#D2D2D2">
			<td colspan="6"></td>
		</tr>
		<%
				}	// for�� : �Խñ� ������ �Ѹ���
			}	// if��
		%>
		<tr height="1" bgcolor="#82B5DF">
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
			<a href="boardList.jsp?pg=1">����</a>
			<a href="boardList.jsp?pg=<%=startPage - 1%>">��</a>
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
 			<a href="boardList.jsp?pg=<%=i%>"><%=i%></a>
 			<%
				 	}
 				}
			%>
			<%
 				if (endPage < allPage) {
 			%>
 			<a href="boardList.jsp?pg=<%=endPage + 1%>">��</a>
 			<a href="boardList.jsp?pg=<%=allPage%>">����</a>
 			<%
			 	}
 			%>
			</td>
		</tr>
		<!-- �˻�â -->
	</table>
	<br>
	<form name=searchform method=post>
	<!-- �˻�â -->
	<div align="right">
				<select name="keyField">
  					<option value="TITLE">����</option>
  					<option value="MEMO">����</option>
  					<option value="USERNAME">�ۼ���</option>  					
				</select>
				<input type="text" name="keyWord"/>
				<input type="button" value="�˻�" onClick="javascript:searchKeyword()"/>
	</div>
	</form>
</body>
</html>