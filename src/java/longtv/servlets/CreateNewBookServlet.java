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
import longtv.dtos.CreateNewBookDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.dtos.InvalidBookDTO;
import longtv.util.ValidateInput;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CreateNewBookServlet", urlPatterns = {"/CreateNewBookServlet"})
public class CreateNewBookServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "SearchBookServlet";
    private static final String UNSUCCESS = "LoadBookCategoryServlet";
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
                    String bookImage = request.getParameter("bookImageLink");
                    String bookTitle = request.getParameter("txtBookTitle");
                    String bookDescription = request.getParameter("txtBookDesc");
                    String bookAuthor = request.getParameter("txtAuthor");
                    String bookQuantityString = request.getParameter("txtQuantity");
                    String bookPriceString = request.getParameter("txtPrice");
                    int categoryID = Integer.parseInt(request.getParameter("cboCategory"));
                    String txtNewCategory = request.getParameter("txtNewCategory");
                    String checkBoxNewCategory = request.getParameter("check-box-newcategory");
                    CreateNewBookDTO newBook = new CreateNewBookDTO(bookImage, bookTitle, bookDescription, bookAuthor, bookPriceString, bookQuantityString, categoryID);
                    ValidateInput validInput = new ValidateInput();
                    InvalidBookDTO checkValid = validInput.checkValidBookRegister(newBook);
                    BookDAO dao = new BookDAO();
                    if (checkValid.isIsValidBook()) {
                        if (checkBoxNewCategory != null) {
                            if (ValidateInput.validateNewCategory(txtNewCategory)) {
                                if (!dao.checkExistedCategories(txtNewCategory)) {
                                    int newBookCategoryID = dao.getIDValueAfterInsertNewCategory(txtNewCategory);
                                    if (newBookCategoryID > 0) {
                                        newBook.setCategoryID(newBookCategoryID);
                                        if (dao.insertNewBook(newBook)) {
                                            url = SUCCESS;
                                            request.setAttribute("SEARCHBOOK_STATUS", "Cuốn sách mới kèm danh mục mới đã được bổ sung thành công.");
                                        }
                                    }
                                } else {
                                    url = UNSUCCESS;
                                    checkValid.setInvalidNewCategory("Tên danh mục mới trùng với tên đã có, bạn thử tìm chọn trên kia nhé!");
                                    request.setAttribute("INVALID_REGISTER", checkValid);
                                }
                            } else {
                                url = UNSUCCESS;
                                checkValid.setInvalidNewCategory("Tên danh mục mới không hợp lệ!");
                                request.setAttribute("INVALID_REGISTER", checkValid);
                            }
                        } else {
                            if (dao.insertNewBook(newBook)) {
                                url = SUCCESS;
                                request.setAttribute("SEARCHBOOK_STATUS", "Cuốn sách mới đã được bổ sung thành công.");
                            }
                        }
                    } else {
                        url = UNSUCCESS;
                        request.setAttribute("INVALID_REGISTER", checkValid);
                    }
                } else {
                    url = INVALID_ROLE;
                    request.setAttribute("SEARCHBOOK_STATUS", "Vai trò của bạn không hợp lệ để thực hiện yêu cầu này!");
                }
            } else {
                url = INVALID_ROLE;
                request.setAttribute("SEARCHBOOK_STATUS", "Vui lòng đăng nhập quyền Admin để thực hiện yêu cầu này!");
            }
        } catch (Exception e) {
            log("ERROR at CreateNewBookServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi tạo sách mới";
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
