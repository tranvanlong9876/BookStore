/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.BookDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.BookCartDTO;
import longtv.dtos.BookCartListDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {
    private static final String ERROR = "error";
    private static final String ADD_SUCCESS = "success";
    private static final String ALREADY_EXIST = "alreadyexist";
    private static final String NOT_LOGIN = "gotologinpage";
    private static final String INVALID_ROLE = "invalidrole";
    private static final String BOOK_NOT_FOUND = "notfoundbook";
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
        String result = ERROR;
        int sizeOfCart = 0;
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNTDETAIL");
            if (account != null) {
                if (account.getRolename().equals("User")) {
                    BookCartDTO cart = (BookCartDTO) session.getAttribute("BOOKCARTDETAIL");
                    if (cart == null) {
                        cart = new BookCartDTO();
                        cart.setIsVerifyOTP(false);
                        if(account.getDistrict() != null && account.getHomeNumber() != null) {
                            cart.setHomeNumber(account.getHomeNumber());
                            cart.setDeliveryAddress(account.getDistrict());
                        }
                    }
                    String bookID = request.getParameter("txtBookID");
                    BookDAO dao = new BookDAO();
                    BookCartListDTO bookDetail = dao.getBookBasedOnIDForAddToCart(bookID);
                    if (bookDetail != null) {
                        Locale localeVN = new Locale("vi", "VN");
                        NumberFormat convertToVietNameseCurrency = NumberFormat.getCurrencyInstance(localeVN);
                        int defaultQuantity = 1;
                        bookDetail.setBookQuantity(defaultQuantity);
                        bookDetail.setTotalPriceCastToVietNameseCurrency(convertToVietNameseCurrency.format(defaultQuantity * bookDetail.getBookPrice()));
                        if (!cart.getBookLists().containsKey(Integer.parseInt(bookID))) {
                            cart.addBookToCart(bookDetail);
                            cart.countTotalPriceOfCart();
                            cart.setTotalPriceOfCartWithVietnameseCurrency(convertToVietNameseCurrency.format(cart.getTotalPriceOfCart()));
                            cart.setDiscountPriceString(convertToVietNameseCurrency.format(cart.getDiscountPrice()));
                            cart.countTotalPriceCheckOut();
                            cart.setTotalPriceOfCartCheckOutWithVietnameseCurrency(convertToVietNameseCurrency.format(cart.getTotalPriceOfCartCheckOut()));
                            session.setAttribute("BOOKCARTDETAIL", cart);
                            result = ADD_SUCCESS;
                        } else {
                           result = ALREADY_EXIST; 
                        }
                    } else {
                        result = BOOK_NOT_FOUND;
                    }
                    sizeOfCart = cart.getBookLists().size();
                } else {
                    result = INVALID_ROLE;
                }
            } else {
                result = NOT_LOGIN;
            }
        } catch (Exception e) {
            log("ERROR at AddToCartServlet: " + e.getMessage());
        } finally {
            out.write(result + "|" + sizeOfCart);
            out.close();
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
