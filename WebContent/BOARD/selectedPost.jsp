<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<%
	/* idx의 게시글 불러오기 */
	int idx = 0;
	if (request.getParameter("idx") != null) {
		idx = Integer.parseInt(request.getParameter("idx"));
	}
	dao.updateHit(idx); // 해당 게시글 조회수 갱신
	BoardVO vo = dao.loadSelectedPost(idx); // 해당 게시글 값 불러오기	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- html 작업 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시글</title>
</head>
<body>
	<br>
	<h3 style="padding-left:180px">게시글</h3>
	<br>
	<table>
		<tr>
			<td>
				<table width="413">
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">글번호</td>
						<td width="319"><%= idx %></td>
						<td width="0">&nbsp;</td>						
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">조회수</td>
						<td width="319"><%= vo.getHit() %></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">이름</td>
						<td width="319"><%= vo.getUserName() %></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">작성일</td>
						<td width="319"><%= vo.getCreateAt() %></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">제목</td>
						<td width="319"><%= vo.getTitle() %></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td width="399" colspan="2" height="200"><%= vo.getMemo() %></td>
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
		<input type=button value="목록" OnClick="window.location='boardList.jsp?pg=1'">
		<input type=button value="수정" OnClick="window.location='checkPassword.jsp?idx=<%= idx %>&command=modify'">
		<input type=button value="삭제" OnClick="window.location='checkPassword.jsp?idx=<%= idx %>&command=delete'"></div>
</body>
</html>