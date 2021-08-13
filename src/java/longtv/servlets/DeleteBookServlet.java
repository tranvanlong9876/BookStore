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
import longtv.daos.BookDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.ErrorServletDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeleteBookServlet", urlPatterns = {"/DeleteBookServlet"})
public class DeleteBookServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "SearchBookServlet";

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
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNTDETAIL");
            if (account != null) {
                if (account.getRolename().equals("Admin")) {
                    int bookID = 0;
                    if (request.getParameter("txtBookDeleteID") != null) {
                        bookID = Integer.parseInt(request.getParameter("txtBookDeleteID"));
                    }
                    BookDAO bookDAO = new BookDAO();
                    if (bookDAO.deleteSelectedBook(bookID)) {
                        url = SUCCESS;
                        request.setAttribute("SEARCHBOOK_STATUS", "Sách bạn chọn đã được xóa thành công!");
                    }
                } else {
                    url = SUCCESS;
                    request.setAttribute("SEARCHBOOK_STATUS", "Vai trò của bạn không đủ điều kiện để thực hiện yêu cầu này.");
                }
            } else {
                url = SUCCESS;
                request.setAttribute("SEARCHBOOK_STATUS", "Vui lòng đăng nhập để thực hiện yêu cầu này!");
            }
        } catch (Exception e) {
            log("ERROR at DeleteBookServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi thực hiện xóa sách";
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
