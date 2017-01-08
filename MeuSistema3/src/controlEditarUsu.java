

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/controlEditarUsu")
public class controlEditarUsu extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	PrintWriter out = response.getWriter();
	
	HttpSession sessao = request.getSession();
	if(sessao.getAttribute("login") == null){
		response.sendRedirect("http://localhost:8080/MeuSistema3/index.jsp");
	}
	
	int id = Integer.parseInt(request.getParameter("txtId"));
	String login = request.getParameter("txtLogin");
	String senha = request.getParameter("txtSenha");
	String nome = request.getParameter("txtNome");
	String sobrenome = request.getParameter("txtSobrenome");
	int idade = Integer.parseInt(request.getParameter("txtIdade"));
	long cpf = Long.parseLong(request.getParameter("txtCPF"));
	
	//UPDATE chamados SET titulo = ?, conteudo = ? WHERE id = ?
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String SQLUpdate = "UPDATE usuarios SET login = ?, senha = ?, nome = ?, sobrenome = ?, idade = ?, cpf = ? WHERE id = ?";
		
		try{
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema3", "root", "");
			PreparedStatement pstm = conn.prepareStatement(SQLUpdate);
			
			pstm.setString(1, login);
			pstm.setString(2, senha);
			pstm.setString(3, nome);
			pstm.setString(4, sobrenome);
			pstm.setInt(5, idade);
			pstm.setLong(6, cpf);
			pstm.setInt(7, id);
			
			pstm.execute();
			pstm.close();
			conn.close();
			
			response.sendRedirect("http://localhost:8080/MeuSistema3/ListarUsu.jsp?msg=editUsu");
			
		} catch(Exception ex){
			
		}
	} catch(Exception ex){
		
	}	
	}
}
