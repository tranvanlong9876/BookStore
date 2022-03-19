function checkSelect(position) {
    var newValue = document.getElementById("select-promotion-rank-" + position).value;
    var currentValue = document.getElementById("current-rank-" + position).innerHTML;
    if(newValue != currentValue) {
        document.getElementById("btn-update-" + position).classList.remove("disabled");
    } else {
        if(!document.getElementById("btn-update-" + position).classList.contains("disabled")) {
            document.getElementById("btn-update-" + position).classList.add("disabled");
        }
    }
}
