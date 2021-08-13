/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.Locale;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.BookDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.BookCartDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.util.ValidateInput;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateCartDetailServlet", urlPatterns = {"/UpdateCartDetailServlet"})
public class UpdateCartDetailServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "cart.jsp";
    private static final String NOT_EXIST = "SearchBookServlet";
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
                if (account.getRolename().equals("User")) {
                    BookCartDTO cart = (BookCartDTO) session.getAttribute("BOOKCARTDETAIL");
                    if (cart != null) {
                        boolean notEnoughQuantity = false;
                        String[] bookIDs = request.getParameterValues("txtBookUpdateID");
                        String[] quantities = request.getParameterValues("txtQuantity");
                        String homeNumber = request.getParameter("txtHomeNumber");
                        String homeAddress = request.getParameter("txtAddress");
                        if (homeNumber.length() > 0 && homeAddress.length() > 0) {
                            cart.setHomeNumber(homeNumber);
                            cart.setDeliveryAddress(homeAddress);
                        }
                        for (int checkValidQuantity = 0; checkValidQuantity < quantities.length; checkValidQuantity++) {
                            if (!ValidateInput.validateBookQuantity(quantities[checkValidQuantity])) {
                                quantities[checkValidQuantity] = "1";
                            }
                        }
                        Locale localeVN = new Locale("vi", "VN");
                        NumberFormat convertToVietNameseCurrency = NumberFormat.getCurrencyInstance(localeVN);
                        for (int i = 0; i < bookIDs.length; i++) {
                            int eachBookID = Integer.parseInt(bookIDs[i]);
                            int eachQuantity = Integer.parseInt(quantities[i]);
                            BookDAO dao = new BookDAO();
                            int maxQuantity = dao.checkQuantityOfEachBook(eachBookID);
                            if (maxQuantity - eachQuantity >= 0) {
                                if (cart.getBookLists().containsKey(eachBookID)) {
                                    cart.updateBookInCart(eachBookID, eachQuantity);
                                    cart.getBookLists().get(eachBookID).setTotalPriceCastToVietNameseCurrency(convertToVietNameseCurrency.format(cart.getBookLists().get(eachBookID).getBookPrice() * eachQuantity));
                                    cart.getBookLists().get(eachBookID).setEnoughQuantity(true);
                                    cart.getBookLists().get(eachBookID).setMaxQuantity(maxQuantity);
                                }
                            } else {
                                notEnoughQuantity = true;
                                cart.getBookLists().get(eachBookID).setEnoughQuantity(false);
                                cart.getBookLists().get(eachBookID).setMaxQuantity(maxQuantity);
                            }
                        }
                        cart.countTotalPriceOfCart();
                        cart.setTotalPriceOfCartWithVietnameseCurrency(convertToVietNameseCurrency.format(cart.getTotalPriceOfCart()));
                        cart.setDiscountPriceString(convertToVietNameseCurrency.format(cart.getDiscountPrice()));
                        cart.countTotalPriceCheckOut();
                        cart.setTotalPriceOfCartCheckOutWithVietnameseCurrency(convertToVietNameseCurrency.format(cart.getTotalPriceOfCartCheckOut()));
                        session.setAttribute("BOOKCARTDETAIL", cart);
                        url = SUCCESS;
                        if (!notEnoughQuantity) {
                            request.setAttribute("CARTSTATUS", "Thông tin giỏ hàng cập nhật thành công.");
                        } else {
                            request.setAttribute("CARTSTATUS", "Một số sách bị vượt quá số lượng tồn kho, bạn kiểm tra lại nhé!");
                        }
                    } else {
                        request.setAttribute("SEARCHBOOK_STATUS", "Giỏ hàng không còn tồn tại nữa, bạn tiếp tục mua sắm nhé!");
                        url = NOT_EXIST;
                    }
                } else {
                    request.setAttribute("SEARCHBOOK_STATUS", "Vai trò của bạn không phù hợp để thực hiện yêu cầu này!");
                    url = INVALID_ROLE;
                }
            } else {
                request.setAttribute("SEARCHBOOK_STATUS", "Vui lòng đăng nhập để thực hiện yêu cầu này!");
                url = INVALID_ROLE;
            }
        } catch (Exception e) {
            log("ERROR at UpdateCartDetailServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi cập nhật thông tin giỏ hàng";
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
