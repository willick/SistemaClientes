

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/controlLogin")
public class controlLogin extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		//out.println("Testando");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String login = request.getParameter("txtLogin");
		String senha = request.getParameter("txtSenha");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String SQLSelect = "SELECT * FROM usuarios WHERE login = ? AND senha = ?";
			
			try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema3", "root", "");
				PreparedStatement pstm = conn.prepareStatement(SQLSelect);
				pstm.setString(1, login);
				pstm.setString(2, senha);
				
				ResultSet rs = pstm.executeQuery();
				
				if(rs.next()){
					HttpSession sessao = request.getSession();
					sessao.setAttribute("login", login);
					
					response.sendRedirect("http://localhost:8080/MeuSistema3/CadastroCli.jsp");
					pstm.close();
					conn.close();
				} else {
					
				}
				pstm.close();
				conn.close();
				
			} catch(Exception ex){
				out.println("Banco " + ex.getMessage());
			}
			
			
			
		} catch(Exception ex){
			out.println("Driver");
		}
		
	}

}
