<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<%
	/* boardIdx�� �ش� ���� ���� �޾ƿ��� */
	int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
	dao.updateHit(boardIdx);	// �� hit counting
	BoardVO vo = dao.loadSelectedPost(boardIdx);	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խñ�</title>
</head>
<body>
	<br>
	<h3 style="padding-left:180px">�Խñ�</h3>
	<br>
	<table>
		<tr>
			<td>
				<table width="413">
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">�۹�ȣ</td>
						<td width="319"><%=boardIdx%></td>
						<td width="0">&nbsp;</td>
						
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">��ȸ��</td>
						<td width="319"><%=vo.getHit()%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">�̸�</td>
						<td width="319"><%=vo.getUserName()%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">�ۼ���</td>
						<td width="319"><%=vo.getCreateAt()%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">����</td>
						<td width="319"><%=vo.getTitle()%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td width="399" colspan="2" height="200"><%=vo.getMemo()%></td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="4" width="407"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br>
	<div style="padding-left:150px">
		<input type=button value="���" OnClick="window.location='ShowList.jsp?pg=1'">
		<input type=button value="����" OnClick="window.location='CheckPassword.jsp?boardIdx=<%=boardIdx%>&type=modify'">
		<input type=button value="����" OnClick="window.location='CheckPassword.jsp?boardIdx=<%=boardIdx%>&type=delete'"></div>
</body>
</html>