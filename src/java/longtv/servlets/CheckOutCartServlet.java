/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.ShoppingDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.BookCartDTO;
import longtv.dtos.BookCartListDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.dtos.OrderHeaderDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CheckOutCartServlet", urlPatterns = {"/CheckOutCartServlet"})
public class CheckOutCartServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String INSERT_SUCCESS = "SearchBookServlet";
    private static final String CART_NOT_AVAILABLE = "SearchBookServlet";

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
        String paymentType = request.getParameter("paymentType");
        boolean checkOutSuccess = false;
        try {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNTDETAIL");
            if (account != null) {
                if (account.getRolename().equals("User")) {
                    BookCartDTO cart = (BookCartDTO) session.getAttribute("BOOKCARTDETAIL");
                    if (cart != null) {
                        session.removeAttribute("BOOKCARTDETAIL");
                        boolean checkQuantity = true;
                        ShoppingDAO dao = new ShoppingDAO();
                        for (int i : cart.getBookLists().keySet()) {
                            if (!dao.checkQuantities(i, cart.getBookLists().get(i).getBookQuantity())) {
                                checkQuantity = false;
                            }
                        }

                        if (checkQuantity) {
                            for (int i : cart.getBookLists().keySet()) {
                                if (dao.minusQuantity(i, cart.getBookLists().get(i).getBookQuantity()) >= 0) {
                                    cart.getBookLists().get(i).setMinusQuantity(true);
                                } else {
                                    cart.getBookLists().get(i).setMinusQuantity(true);
                                    checkQuantity = false;
                                    break;
                                }
                            }

                            if (checkQuantity) {
                                Date date = new Date();
                                SimpleDateFormat sdf = new SimpleDateFormat("ddMMYYYY-HHmmss");
                                Timestamp time = new Timestamp(date.getTime());
                                int randomCode = (int) (100000 + (Math.random() * 899999));
                                String orderID = "VN-" + sdf.format(date) + "-" + randomCode;
                                String username = account.getUser();
                                String deliveryAddress = request.getParameter("txtHomeNumber") + " " + request.getParameter("txtAddress");
                                OrderHeaderDTO dto;
                                if (paymentType.equals("Paypal")) {
                                    String accountPaypal = request.getParameter("paypalemail");
                                    String paypalID = request.getParameter("paypalid");
                                    String amountPaypal = request.getParameter("paypalamount");
                                    dto = new OrderHeaderDTO(orderID, username, 1, accountPaypal, amountPaypal, paypalID, 2);
                                    dto.setTotalPrice(cart.getTotalPriceOfCartCheckOut());
                                    dto.setDeliveryAddress(deliveryAddress);
                                    if (cart.getVoucher() != null) {
                                        dto.setVoucherApplied(cart.getVoucher().getDiscountCode());
                                    }
                                } else {
                                    dto = new OrderHeaderDTO(orderID, username, 1, 1);
                                    dto.setTotalPrice(cart.getTotalPriceOfCartCheckOut());
                                    dto.setDeliveryAddress(deliveryAddress);
                                    if (cart.getVoucher() != null) {
                                        dto.setVoucherApplied(cart.getVoucher().getDiscountCode());
                                    }
                                }

                                if (dao.insertOrderHeader(dto, time)) {
                                    boolean checkInsertDetail = true;
                                    if (cart.getVoucher() != null) {
                                        dao.inactiveVoucher(cart.getVoucher().getDiscountCode());
                                    }

                                    for (int i : cart.getBookLists().keySet()) {
                                        BookCartListDTO bookInCart = cart.getBookLists().get(i);
                                        if (!dao.insertOrderDetail(bookInCart, orderID)) {
                                            checkInsertDetail = false;
                                        }
                                    }

                                    if (checkInsertDetail) {
                                        url = INSERT_SUCCESS;
                                        checkOutSuccess = true;
                                        if (paymentType.equals("Paypal")) {
                                            request.setAttribute("SEARCHBOOK_STATUS", "Đặt hàng và thanh toán Paypal thành công, nhớ theo dõi đơn hàng tại lịch sử nhé!");
                                        } else {
                                            request.setAttribute("SEARCHBOOK_STATUS", "Đặt hàng thành công, theo dõi đơn hàng và nhớ thanh toán khi nhận hàng nhé!");
                                        }
                                    }
                                }
                            } else {
                                for (int i : cart.getBookLists().keySet()) {
                                    if(true == cart.getBookLists().get(i).isMinusQuantity()) {
                                        dao.restoreQuantity(i, cart.getBookLists().get(i).getBookQuantity());
                                    }
                                }
                                url = CART_NOT_AVAILABLE;
                                if (paymentType.equals("Paypal")) {
                                    request.setAttribute("SEARCHBOOK_STATUS", "Đặt hàng thất bại: Số lượng sách còn lại không đủ cho đơn hàng của bạn, chúng tôi sẽ hỗ trợ hoàn tiền cho bạn trong vòng 24h làm việc!");
                                } else {
                                    request.setAttribute("SEARCHBOOK_STATUS", "Đặt hàng thất bại: Số lượng sách còn lại không đủ cho đơn hàng của bạn");
                                }
                            }
                        } else {
                            url = CART_NOT_AVAILABLE;

                            if (paymentType.equals("Paypal")) {
                                request.setAttribute("SEARCHBOOK_STATUS", "Đặt hàng thất bại: Số lượng sách còn lại không đủ cho đơn hàng của bạn, chúng tôi sẽ hỗ trợ hoàn tiền cho bạn trong vòng 24h làm việc!");
                            } else {
                                request.setAttribute("SEARCHBOOK_STATUS", "Đặt hàng thất bại: Số lượng sách còn lại không đủ cho đơn hàng của bạn");
                            }
                        }
                    } else {
                        url = CART_NOT_AVAILABLE;
                        if (paymentType.equals("Paypal")) {
                            request.setAttribute("SEARCHBOOK_STATUS", "Giỏ hàng không còn tồn tại hoặc xảy ra lỗi, chúng tôi sẽ hỗ trợ hoàn tiền cho bạn trong vòng 24h làm việc!");
                        } else {
                            request.setAttribute("SEARCHBOOK_STATUS", "Giỏ hàng không còn tồn lại, bạn chịu khó đặt hàng lại nhé!");
                        }
                    }
                } else {
                    url = CART_NOT_AVAILABLE;
                    request.setAttribute("SEARCHBOOK_STATUS", "Vai trò Admin của bạn không thể thực hiện yêu cầu này!");
                }
            } else {
                url = CART_NOT_AVAILABLE;
                request.setAttribute("SEARCHBOOK_STATUS", "Vui lòng đăng nhập để thực hiện yêu cầu này!");
            }

            if (!checkOutSuccess) {
                if (paymentType.equals("Paypal")) {
                    String accountPaypal = request.getParameter("paypalemail");
                    String paypalID = request.getParameter("paypalid");
                    String amountPaypal = request.getParameter("paypalamount");
                    ShoppingDAO dao = new ShoppingDAO();
                    if (!dao.refundUserCheckOut(accountPaypal, paypalID, amountPaypal)) {
                        url = ERROR;
                    }
                }
            }
        } catch (Exception e) {
            log("ERROR at CheckOutCartServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra tại trang đặt hàng";
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
