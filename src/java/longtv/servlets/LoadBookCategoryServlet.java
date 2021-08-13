/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.BookDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.CategoryBookDTO;
import longtv.dtos.ErrorServletDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoadBookCategoryServlet", urlPatterns = {"/LoadBookCategoryServlet"})
public class LoadBookCategoryServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "createnewbook.jsp";
    private static final String INVALID_ROLE = "SearchBookServlet";

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
                    BookDAO dao = new BookDAO();
                    List<CategoryBookDTO> allCategories = dao.loadAllBookCategories();
                    request.setAttribute("ALLCATEGORIES", allCategories);
                    url = SUCCESS;
                } else {
                    url = INVALID_ROLE;
                    request.setAttribute("SEARCHBOOK_STATUS", "Vai trò của bạn không hợp lệ để thực hiện yêu cầu này!");
                }
            } else {
                url = INVALID_ROLE;
                request.setAttribute("SEARCHBOOK_STATUS", "Vui lòng đăng nhập quyền Admin để thực hiện yêu cầu này!");
            }
        } catch (Exception e) {
            log("ERROR at LoadBookCategoryServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi chuyển sang trang đăng ký";
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
