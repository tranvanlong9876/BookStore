/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function getListener() {
    var infoBox = document.getElementById("account-info");

    infoBox.addEventListener("click", function () {
        window.location.href = "/BookStore/DispatchServlet?action=updateAccount";
    });
}