<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Lista de Clientes Cadastrados</title>
			  <style>
					      /* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
					      @import url(http://fonts.googleapis.com/css?family=Open+Sans);
					.btn { display: inline-block; *display: inline; *zoom: 1; padding: 4px 10px 4px; margin-bottom: 0; font-size: 13px; line-height: 18px; color: #333333; text-align: center;text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75); vertical-align: middle; background-color: #f5f5f5; background-image: -moz-linear-gradient(top, #ffffff, #e6e6e6); background-image: -ms-linear-gradient(top, #ffffff, #e6e6e6); background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), to(#e6e6e6)); background-image: -webkit-linear-gradient(top, #ffffff, #e6e6e6); background-image: -o-linear-gradient(top, #ffffff, #e6e6e6); background-image: linear-gradient(top, #ffffff, #e6e6e6); background-repeat: repeat-x; filter: progid:dximagetransform.microsoft.gradient(startColorstr=#ffffff, endColorstr=#e6e6e6, GradientType=0); border-color: #e6e6e6 #e6e6e6 #e6e6e6; border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25); border: 1px solid #e6e6e6; -webkit-border-radius: 4px; -moz-border-radius: 4px; border-radius: 4px; -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); cursor: pointer; *margin-left: .3em; }
					.btn:hover, .btn:active, .btn.active, .btn.disabled, .btn[disabled] { background-color: #e6e6e6; }
					.btn-large { padding: 9px 14px; font-size: 15px; line-height: normal; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; }
					.btn:hover { color: #333333; text-decoration: none; background-color: #e6e6e6; background-position: 0 -15px; -webkit-transition: background-position 0.1s linear; -moz-transition: background-position 0.1s linear; -ms-transition: background-position 0.1s linear; -o-transition: background-position 0.1s linear; transition: background-position 0.1s linear; }
					.btn-primary, .btn-primary:hover { text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25); color: #ffffff; }
					.btn-primary.active { color: rgba(255, 255, 255, 0.75); }
					.btn-primary { background-color: #4a77d4; background-image: -moz-linear-gradient(top, #6eb6de, #4a77d4); background-image: -ms-linear-gradient(top, #6eb6de, #4a77d4); background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#6eb6de), to(#4a77d4)); background-image: -webkit-linear-gradient(top, #6eb6de, #4a77d4); background-image: -o-linear-gradient(top, #6eb6de, #4a77d4); background-image: linear-gradient(top, #6eb6de, #4a77d4); background-repeat: repeat-x; filter: progid:dximagetransform.microsoft.gradient(startColorstr=#6eb6de, endColorstr=#4a77d4, GradientType=0);  border: 1px solid #3762bc; text-shadow: 1px 1px 1px rgba(0,0,0,0.4); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.5); }
					.btn-primary:hover, .btn-primary:active, .btn-primary.active, .btn-primary.disabled, .btn-primary[disabled] { filter: none; background-color: #4a77d4; }
					.btn-block { width: 100%; display:block; }
					
					* { -webkit-box-sizing:border-box; -moz-box-sizing:border-box; -ms-box-sizing:border-box; -o-box-sizing:border-box; box-sizing:border-box; }
					
					html { width: 100%; height:100%; overflow:hidden; }
					
					body { 
						width: 100%;
						height:100%;
						font-family: 'Open Sans', sans-serif;
						background: #092756;
						background: -moz-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%),-moz-linear-gradient(top,  rgba(57,173,219,.25) 0%, rgba(42,60,87,.4) 100%), -moz-linear-gradient(-45deg,  #670d10 0%, #092756 100%);
						background: -webkit-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -webkit-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -webkit-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
						background: -o-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -o-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -o-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
						background: -ms-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -ms-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -ms-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
						background: -webkit-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), linear-gradient(to bottom,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), linear-gradient(135deg,  #670d10 0%,#092756 100%);
						filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3E1D6D', endColorstr='#092756',GradientType=1 );
					}
					.login { 
						position: absolute;
						top: 20%;
						left: 50%;
						margin: -150px 0 0 -150px;
						width:300px;
						height:300px;
					}
					.login h1 { color: #fff; text-shadow: 0 0 10px rgba(0,0,0,0.3); letter-spacing:1px; text-align:center; }
					
					input { 
						width: 100%; 
						margin-bottom: 10px; 
						background: rgba(0,0,0,0.3);
						border: none;
						outline: none;
						padding: 10px;
						font-size: 13px;
						color: #fff;
						text-shadow: 1px 1px 1px rgba(0,0,0,0.3);
						border: 1px solid rgba(0,0,0,0.3);
						border-radius: 4px;
						box-shadow: inset 0 -5px 45px rgba(100,100,100,0.2), 0 1px 1px rgba(255,255,255,0.2);
						-webkit-transition: box-shadow .5s ease;
						-moz-transition: box-shadow .5s ease;
						-o-transition: box-shadow .5s ease;
						-ms-transition: box-shadow .5s ease;
						transition: box-shadow .5s ease;
					}
					input:focus { box-shadow: inset 0 -5px 45px rgba(100,100,100,0.4), 0 1px 1px rgba(255,255,255,0.2); }
					
					    </style>

</head>
<body>
	<h1 style="color: white">Tabela De Usu�rios</h1>
    <table width="100%" border="0" cellspacing="10" cellpadding="4" bgcolor="gray">
    	<tr align="center" bgcolor="white">
   		<td>ID</td>
		<td>NOME</td>
		<td>SOBRENOME</td>
		<td>LOGIN</td>
		<td>SENHA</td>
		<td>IDADE</td>
		<td>CPF</td>
		</tr>
		<% 
			HttpSession sessao = request.getSession();
			if(sessao.getAttribute("login") == null){
				response.sendRedirect("http://localhost:8080/MeuSistema3/index.jsp");
			}
			
			if(request.getParameter("msg") != null){
				if(request.getParameter("msg").equals("editUsu")){
					out.println("<h3 align='center' style='color: red'>Usu�rio Atualizado Com Sucesso.</h3>");
				}
			}
			
			if(request.getParameter("id") != null){
				
				int ID = Integer.parseInt(request.getParameter("id"));
				
				Class.forName("com.mysql.jdbc.Driver");
				String SQLDelete = "DELETE FROM usuarios WHERE id = ?";
				
				try{
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema3", "root", "");
					PreparedStatement pstm = conn.prepareStatement(SQLDelete);
					
					pstm.setInt(1, ID);
					pstm.execute();
					pstm.close();
					conn.close();
					
				} catch(Exception ex){
					
				}
			}

			try{
				Class.forName("com.mysql.jdbc.Driver");
				String SQLSelect = "SELECT * FROM usuarios";
				
				try{
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema3", "root", "");
					Statement stm = conn.prepareStatement(SQLSelect);
					
					ResultSet rs = stm.executeQuery(SQLSelect);
					
					while(rs.next()){ %>
						<tr align="center" bgcolor="white">
						<td><% out.println(rs.getInt("id"));%></td>
						<td><% out.println(rs.getString("nome"));%></td>
						<td><% out.println(rs.getString("sobrenome"));%></td>
						<td><% out.println(rs.getString("login"));%></td>
						<td><% out.println(rs.getString("senha"));%></td>
						<td><% out.println(rs.getInt("idade"));%></td>
						<td><% out.println(rs.getBigDecimal("cpf"));%></td>
						<% out.println("<td><a href='http://localhost:8080/MeuSistema3/ListarUsu.jsp?id=" + rs.getInt("id")+ "'>(X)</td>"); %>
						<% out.println("<td><a href='http://localhost:8080/MeuSistema3/EditarUsu.jsp?id="+ rs.getInt("id")+"'>(O)</td>"); %>
						</tr>
					<%
					}
				} catch(Exception ex){
					
				}
			} catch(Exception ex){
				
			}
		%>
	</table>
    <br>
    <br>
    <a style="color: white" href="http://localhost:8080/MeuSistema3/CadastroCli.jsp">Voltar</a>
     <br>
     <br>
     <a style="color: white" href="http://localhost:8080/MeuSistema3/index.jsp?msg=SAIR">Deslogar</a>
</body>
</html>