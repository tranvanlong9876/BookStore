/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function updateAvatar(firstImage) {
    var file = document.getElementById("choose-avatar");
    if (typeof (file.files[0]) !== "undefined") {
        var fileType = file.files[0]["type"];
        var form = new FormData();
        form.append("image", file.files[0]);
        if (fileType.split("/")[0] == "image") {
            var settings = {
                url: "https://api.imgbb.com/1/upload?key=0428fd7476dca636c92c4b4c3a96a87d",
                method: "POST",
                timeout: 0,
                processData: false,
                mimeType: "multipart/form-data",
                contentType: false,
                data: form
            };
            $.ajax(settings).done(function (response) {
                var jx = JSON.parse(response);
                var img = jx.data.url;
                document.getElementById("show-new-photo").setAttribute("src", img);
            });

        } else {
            document.getElementById("file-status").innerHTML = "Hình ảnh người dùng không đúng định dạng!";
            document.getElementById("show-new-photo").setAttribute("src", firstImage);
            document.querySelector(".not-valid-book-image").style.display = "table-row";
            document.getElementById("link-avatar").value = "images/default-avatar.jpg";
        }
    }
}

function addAvatar() {
    var file = document.getElementById("file");
    if (typeof (file.files[0]) !== "undefined") {
        var fileType = file.files[0]["type"];
        var form = new FormData();
        form.append("image", file.files[0]);
        if (fileType.split("/")[0] == "image") {
            var settings = {
                url: "https://api.imgbb.com/1/upload?key=0428fd7476dca636c92c4b4c3a96a87d",
                method: "POST",
                timeout: 0,
                processData: false,
                mimeType: "multipart/form-data",
                contentType: false,
                data: form
            };
            $.ajax(settings).done(function (response) {
                var jx = JSON.parse(response);
                var img = jx.data.url;
                document.getElementById("img-avatar-id").setAttribute("src", img);
                document.getElementById("link-avatar").value = img;
            });

        } else {
            document.getElementById("file-status").innerHTML = "Hình ảnh người dùng không đúng định dạng!";
            document.getElementById("img-avatar-id").setAttribute("src", "images/default-avatar.jpg");
            document.querySelector(".not-valid-book-image").style.display = "table-row";
            document.getElementById("link-avatar").value = "images/default-avatar.jpg";
        }
    }
}

function addFile() {
    var file = document.getElementById("file");
    if (typeof (file.files[0]) !== "undefined") {
        var fileType = file.files[0]["type"];
        var form = new FormData();
        form.append("image", file.files[0]);
        if (fileType.split("/")[0] == "image") {
            var settings = {
                url: "https://api.imgbb.com/1/upload?key=0428fd7476dca636c92c4b4c3a96a87d",
                method: "POST",
                timeout: 0,
                processData: false,
                mimeType: "multipart/form-data",
                contentType: false,
                data: form
            };
            $.ajax(settings).done(function (response) {
                var jx = JSON.parse(response);
                var img = jx.data.url;
                document.getElementById("img-setting").setAttribute("src", img);
                document.getElementById("link-photo").value = img;
            });

            var loadingImage = "https://media1.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif?cid=ecf05e47yk4pzu78g1f1ddgte2bj93s3ovqsw0ou7lerqes9&rid=giphy.gif&ct=g";
            document.getElementById("link-photo").value = loadingImage;
            document.getElementById("img-setting").style.display = "flex";
            document.getElementById("file-status").innerHTML = "Kiểm tra sơ hình ảnh của cuốn sách trước khi xác nhận nhé!";
            document.querySelector(".not-valid-book-image").style.display = "table-row";
        } else {
            document.getElementById("img-setting").style.display = "none";
            document.getElementById("file-status").innerHTML = "Hình ảnh của cuốn sách không đúng định dạng!";
            document.querySelector(".not-valid-book-image").style.display = "table-row";
            document.getElementById("link-photo").value = "";
        }
    }
}

function enableNewCategory() {
    var checkBox = document.getElementById("check-changenew-category");

    if (checkBox.checked == true) {
        document.getElementById("category-dropdown-list").style.display = "none";
        document.getElementById("category-input").style.display = "flex";
    } else {
        document.getElementById("category-dropdown-list").style.display = "flex";
        document.getElementById("category-input").style.display = "none";
    }
}