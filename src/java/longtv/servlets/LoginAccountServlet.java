/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.AccountDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.util.EncryptPassword;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginAccountServlet", urlPatterns = {"/LoginAccountServlet"})
public class LoginAccountServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String LOGIN_SUCCESS = "SearchBookServlet";
    private static final String LOGIN_FAILED = "login.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            if (session.getAttribute("ACCOUNTDETAIL") == null) {
                String username = request.getParameter("txtUsername").toLowerCase().trim();
                String password = request.getParameter("txtPassword");

                if (username == null) {
                    username = "";
                }

                if (password == null) {
                    password = "";
                }
                password = EncryptPassword.encodePassword(password);
                AccountDAO dao = new AccountDAO();
                AccountDTO account = dao.checkLogin(username, password);
                if (account != null) {
                    url = LOGIN_SUCCESS;
                    session.setAttribute("ACCOUNTDETAIL", account);
                } else {
                    url = LOGIN_FAILED;
                    request.setAttribute("LOGINSTATUS", "Tài Khoản hoặc Mật Khẩu không đúng.");
                }
            } else {
                url = LOGIN_SUCCESS;
            }
        } catch (Exception e) {
            log("ERROR at LoginAccountServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi đăng nhập tài khoản";
            String errorDetail = "Vui lòng liên hệ với quản trị viên để được hỗ trợ hoặc thử lại sau!";
            ErrorServletDTO error = new ErrorServletDTO(errorServlet, errorDetail);
            request.setAttribute("ERROR", error);
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
