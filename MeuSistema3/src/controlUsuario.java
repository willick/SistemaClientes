

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class controlUsuario
 */
@WebServlet("/controlUsuario")
public class controlUsuario extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		HttpSession sessao = request.getSession();
		if(sessao.getAttribute("login") == null){
			response.sendRedirect("http://localhost:8080/MeuSistema3/index.jsp");
		}
		
		String login = request.getParameter("txtLogin");
		String senha = request.getParameter("txtSenha");
		String nome = request.getParameter("txtNome");
		String Sobrenome = request.getParameter("txtSobrenome");
		int idade = Integer.parseInt(request.getParameter("txtIdade"));
		long cpf = Long.parseLong(request.getParameter("txtCPF"));
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String SQLInsert = "INSERT INTO usuarios (login, senha, nome, sobrenome, idade, cpf, data) VALUES (?, ?, ?, ?, ?, ?, ?)";
			
			try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema3", "root", "");
				PreparedStatement pstm = conn.prepareStatement(SQLInsert);
				
				Date dt = new Date(new java.util.Date().getTime());
						
				pstm.setString(1, login);
				pstm.setString(2, senha);
				pstm.setString(3, nome);
				pstm.setString(4, Sobrenome);
				pstm.setInt(5, idade);
				pstm.setLong(6, cpf);
				pstm.setDate(7, dt);
				
				pstm.execute();
				pstm.close();
				conn.close();
				
			} catch(Exception ex){
				out.println("Erro ao conectar com banco de dados!" + ex.getMessage());
			}
		} catch(Exception ex){
			out.println("Erro ao carregar o drive de conexão!");
		}
		response.sendRedirect("http://localhost:8080/MeuSistema3/index.jsp?msg=Cadastro");
	}
}
