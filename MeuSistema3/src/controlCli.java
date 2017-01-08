

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


@WebServlet("/controlCli")
public class controlCli extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        
        PrintWriter out = response.getWriter();
        
        String nome = request.getParameter("txtNome");
        String sobrenome = request.getParameter("txtSobrenome");
        String empresa = request.getParameter("txtEmpresa");
        String cnpj = request.getParameter("txtCNPJ");
        String ramo = request.getParameter("txtRamo");
        String contato = request.getParameter("txtContato");
        
        try{
        	Class.forName("com.mysql.jdbc.Driver");
        	
        	String SQLInsert = "INSERT INTO clientes (nome, sobrenome, empresa, cnpj, ramo, contato) VALUES (?, ?, ?, ?, ?, ?)";
        	
        	try{
        		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema3", "root", "");
        		PreparedStatement pstm = conn.prepareStatement(SQLInsert);
        		
        		pstm.setString(1, nome);
        		pstm.setString(2, sobrenome);
        		pstm.setString(3, empresa);
        		pstm.setString(4, cnpj);
        		pstm.setString(5, ramo);
        		pstm.setString(6, contato);
        		
        		pstm.execute();
        		pstm.close();
        		conn.close();
        		
        		response.sendRedirect("http://localhost:8080/MeuSistema3/CadastroCli.jsp?msg=cli");
        		
        	} catch(Exception ex){
        		
        		
        	}
        } catch(Exception ex){
        	
        }
        
	}

}
