

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/controlEditarCli")
public class controlEditarCli extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sessao = request.getSession();
		if(sessao.getAttribute("login") == null){
			response.sendRedirect("http://localhost:8080/MeuSistema3/index.jsp");
		}
		
		int ID = Integer.parseInt(request.getParameter("txtId"));
		String nome = request.getParameter("txtNome");
		String sobrenome = request.getParameter("txtSobrenome");
		String empresa = request.getParameter("txtEmpresa");
		String cnpj = request.getParameter("txtCNPJ");
		String ramo = request.getParameter("txtRamo");
		String contato = request.getParameter("txtContato");
		
		try{
			//UPDATE usuarios SET login = ?, senha = ?, nome = ?, sobrenome = ?, idade = ?, cpf = ? WHERE id = ?";
			Class.forName("com.mysql.jdbc.Driver");
			String SQLUpdate = "UPDATE clientes SET nome = ?, sobrenome = ?, empresa = ?, cnpj = ?, ramo = ?, contato = ? WHERE id = ?";
			
			try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema3", "root", "");
				PreparedStatement pstm = conn.prepareStatement(SQLUpdate);
				
				pstm.setString(1, nome);
				pstm.setString(2, sobrenome);
				pstm.setString(3, empresa);
				pstm.setString(4, cnpj);
				pstm.setString(5, ramo);
				pstm.setString(6, contato);
				pstm.setInt(7, ID);
				
				pstm.execute();
				pstm.close();
				conn.close();
				
				response.sendRedirect("http://localhost:8080/MeuSistema3/ListarCli.jsp");
			} catch(Exception ex){
				
			}
		} catch(Exception ex){
			
		}
		
	}

}
