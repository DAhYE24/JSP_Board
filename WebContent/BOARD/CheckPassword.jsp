<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<%
	int idx = 0;
	String next = null;
	if(request.getParameter("idx") != null){
		idx = Integer.parseInt(request.getParameter("idx"));
	}
	if(request.getParameter("command") != null){
		next = request.getParameter("command");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��й�ȣ üũ</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 <script type="text/javascript">
 $(function() {
		$("#sendPassword").click(function(e){
	        e.preventDefault();
			var pwd = document.getElementById('pwd').value;
			var next = "<%=next%>";
		    var url = 'controller.jsp?idx=' + <%=idx%> + '&command=pwd';		    
		    $.ajax({
				url: url,
	            type: "POST",
	            datatype:"HTML",
	            data: {password: pwd, idx: <%=idx%>},
				success: function(args) {
					var num = $.trim(args).charAt(164);
					if(num == 0){
						if(next === "modify"){
							location.href="write.jsp?idx=" + <%=idx%>;
						}
						if(next === "delete"){
							alert("�Խù��� �����մϴ�");
							location.href='controller.jsp?idx=' + <%=idx%> + '&command=delete';
						}
					}else if(num ==1){
						alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
					}
				},
				error: function(){
					console.log("Connection Failed");
				}
			});
		});
	});
</script>
</head>
<body>
<!-- input type="hidden"���� �����ϱ� -->
	<h4 style="padding-left:180px">��й�ȣ</h4>
	<table>
		<tr>
			<td><input type="password" id="pwd" size="50" maxlength="50"></td>
		</tr>
		<tr>
			<td><input type="button" value="Ȯ��" id="sendPassword"></td>
		</tr>
	</table>
</body>
</html>