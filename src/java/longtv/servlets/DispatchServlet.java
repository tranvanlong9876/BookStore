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
import longtv.dtos.ErrorServletDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DispatchServlet", urlPatterns = {"/DispatchServlet"})
public class DispatchServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SEARCH_BOOK = "SearchBookServlet";
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String LOGIN_SERVLET = "LoginAccountServlet";
    private static final String LOGOUT = "LogOutServlet";
    private static final String CREATE_NEW_BOOK = "LoadBookCategoryServlet";
    private static final String CREATE_BOOK_CONTROLLER = "CreateNewBookServlet";
    private static final String DELETE_BOOK_CONTROLLER = "DeleteBookServlet";
    private static final String EDIT_BOOK_CONTROLLER = "LoadBookToUpdateServlet";
    private static final String UPDATE_BOOK_CONTROLLER = "UpdateBookServlet";
    private static final String CREATE_VOUCHER_PAGE = "createvoucher.jsp";
    private static final String CREATE_VOUCHER_CONTROLLER = "CreateNewVoucherServlet";
    private static final String UPDATE_CART_DETAIL = "UpdateCartDetailServlet";
    private static final String ADD_TO_CART = "AddToCartServlet";
    private static final String VIEW_CART = "cart.jsp";
    private static final String REMOVE_ITEM_FROM_CART = "RemoveItemFromCartServlet";
    private static final String APPLY_VOUCHER_CODE = "InputVoucherServlet";
    private static final String CHECKOUT_CART = "CheckOutCartServlet";
    private static final String SHOPPING_HISTORY = "LoadHistoryHeaderServlet";
    private static final String SHOPPING_HISTORY_DETAIL = "LoadHistoryDetailServlet";

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
            String action = "";
            if (request.getParameter("action") != null) {
                action = request.getParameter("action");
            }
            if (action.length() == 0) {
                url = SEARCH_BOOK;
            } else if (action.equals("SearchBook")) {
                url = SEARCH_BOOK;
            } else if (action.equals("LoginPage")) {
                url = LOGIN_PAGE;
            } else if (action.equals("Login")) {
                url = LOGIN_SERVLET;
            } else if (action.equals("Logout")) {
                url = LOGOUT;
            } else if (action.equals("CreateNewBook")) {
                url = CREATE_NEW_BOOK;
            } else if (action.equals("CreateBook")) {
                url = CREATE_BOOK_CONTROLLER;
            } else if (action.equals("ConfirmDeleteBook")) {
                url = DELETE_BOOK_CONTROLLER;
            } else if (action.equals("EditBookPage")) {
                url = EDIT_BOOK_CONTROLLER;
            } else if (action.equals("UpdateBook")) {
                url = UPDATE_BOOK_CONTROLLER;
            } else if (action.equals("CreateVoucherPage")) {
                url = CREATE_VOUCHER_PAGE;
            } else if (action.equals("CreateVoucher")) {
                url = CREATE_VOUCHER_CONTROLLER;
            } else if (action.equals("UpdateCart")) {
                url = UPDATE_CART_DETAIL;
            } else if (action.equals("AddToCart")) {
                url = ADD_TO_CART;
            } else if (action.equals("ViewCart")) {
                url = VIEW_CART;
            } else if (action.equals("RemoveCart")) {
                url = REMOVE_ITEM_FROM_CART;
            } else if (action.equals("ApplyVoucherCode")) {
                url = APPLY_VOUCHER_CODE;
            } else if (action.equals("CheckOut")) {
                url = CHECKOUT_CART;
            } else if (action.equals("HistoryPage")) {
                url = SHOPPING_HISTORY;
            } else if (action.equals("ViewOrderDetail")) {
                url = SHOPPING_HISTORY_DETAIL;
            } else {
                String errorServlet = "Lỗi đã xảy ra khi điều phối xử lý";
                String errorDetail = "Hành động chuyển trang không hợp lệ, vui lòng thử lại sau!";
                ErrorServletDTO error = new ErrorServletDTO(errorServlet, errorDetail);
                request.setAttribute("ERROR", error);
            }
        } catch (Exception e) {
            log("ERROR at DispatchServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi điều phối xử lý";
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
