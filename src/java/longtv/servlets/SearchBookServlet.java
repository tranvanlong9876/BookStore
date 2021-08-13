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
import longtv.daos.BookDAO;
import longtv.dtos.CategoryBookDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.dtos.SearchBookDTO;
import longtv.util.ConvertInput;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SearchBookServlet", urlPatterns = {"/SearchBookServlet"})
public class SearchBookServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SEARCH_BOOK = "index.jsp";

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
        String url = ERROR;
        try {
            int categoryBook = 0;
            int fructualPrice = 0;
            String searchName = "";

            if (request.getParameter("dboCategoryBook") != null && !request.getParameter("dboCategoryBook").isEmpty()) {
                categoryBook = Integer.parseInt(request.getParameter("dboCategoryBook"));
            }

            if (request.getParameter("dboFluctuatingPrice") != null && !request.getParameter("dboFluctuatingPrice").isEmpty()) {
                fructualPrice = Integer.parseInt(request.getParameter("dboFluctuatingPrice"));
            }

            if (request.getParameter("txtSearchBook") != null) {
                searchName = request.getParameter("txtSearchBook");
            }
            String[] priceRange = ConvertInput.convertToFructualPrice(fructualPrice);
            BookDAO dao = new BookDAO();
            List<SearchBookDTO> allBooks = dao.searchAllBooks(searchName, categoryBook, priceRange);
            List<CategoryBookDTO> allCategories = dao.loadAllBookCategories();
            request.setAttribute("ALLBOOKS", allBooks);
            request.setAttribute("ALLCATEGORIES", allCategories);
            url = SEARCH_BOOK;
        } catch (Exception e) {
            log("ERROR at DispatchServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi load sách tại trang chủ";
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
