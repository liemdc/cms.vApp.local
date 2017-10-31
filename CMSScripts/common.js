///////////////////////
$(document).ready(function() {
    $("#nav li").hover(function() {

        $(this).find('.sub:first').css({ visibility: "visible", display: "none" }).show(400);
    }, function() {
        $(this).find('.sub:first').css({ visibility: "hidden" });

    });
});
///////////////////////
$(function() {
    $("#slider").jCarouselLite({
        btnNext: ".slider-next",
        btnPrev: ".slider-prev",
        visible: 1
    });
});
/////////////////////////
$(document).ready(function() {
    //Default Action
    $(".tab_content").hide(); //Hide all content
    $("ul.tabs li:first").addClass("active").show(); //Activate first tab
    $(".tab_content:first").show(); //Show first tab content


    //On Click Event
    $("ul.tabs li").click(function() {
        $("ul.tabs li").removeClass("active"); //Remove any "active" class
        $(this).addClass("active"); //Add "active" class to selected tab
        $(".tab_content").hide(); //Hide all tab content
        var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
        $(activeTab).fadeIn(); //Fade in the active content
        return false;
    });


});
///////////////////////
function SetText() {
    if (this.document.getElementById("txtContentSearch").value == "")
        this.document.getElementById("txtContentSearch").value = "Từ khóa tìm kiếm";
}
function ClearText() {
    if (this.document.getElementById("txtContentSearch").value == "Từ khóa tìm kiếm")
        this.document.getElementById("txtContentSearch").value = "";
}
function toSearch() {
    var txtS = document.getElementById("txtContentSearch").value;
    if (txtS != "" && txtS != "Từ khóa tìm kiếm")
        window.location = "/Tim-kiem.aspx?key=" + txtS + "";
    else {
        return false;
    }
}
function runScript(e) {
    if (e.keyCode == 13) {
        toSearch();
        return false;
    }
}

/*
    Call:
    <input type="text" onblur="SetText()" value="Search ..." onclick="ClearText()" onkeypress="return runScript(event)" class="txt" id="txtContentSearch">
    <div class="btn" onclick="toSearch()"></div>
*/
///////////////////////////////////////

///////////////////////////////////////
function onlyNumbers(evt) {
    var e = event || evt;
    var charCode = e.which || e.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
/*
    Call:
    onkeypress="return onlyNumbers(event);"
*/
//////////////////////////////////////

function popUpProductGallery(url) {
    var width = 640;
    var height = 500;
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2;
    var params = 'width=' + width + ', height=' + height;
    params += ', top=' + top + ', left=' + left;
    params += ', directories=no';
    params += ', location=no';
    params += ', menubar=no';
    params += ', resizable=yes';
    params += ', scrollbars=yes';
    params += ', status=no';
    params += ', toolbar=no';
    newwin = window.open(url, 'productGalleryWindow', params);
    if (window.focus) { newwin.focus() }
    return false;
}
//////////////////////////////////////////////////////////
// sử dụng validate: ValidationHelper

// hàm get time
function tS() { x = new Date(); x.setTime(x.getTime()); return x; }
function lZ(x) { return (x > 9) ? x : '0' + x; }
function tH(x) { if (x == 0) { x = 12; } return (x > 12) ? x -= 12 : x; }
function y2(x) { x = (x < 500) ? x + 1900 : x; return String(x).substring(0, 4) }
function dT() { if (fr == 0) { fr = 1; document.write('<span id="tP">' + eval(oT) + '</span>'); } tP.innerText = eval(oT); setTimeout('dT()', 1000); }
function aP(x) { return (x > 11) ? 'PM' : 'AM'; }
var dN = new Array('Chủ nhật', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'), mN = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'), fr = 0, oT = "dN[tS().getDay()]+', '+tS().getDate()+'/'+mN[tS().getMonth()]+'/'+y2(tS().getYear())+' - '+tH(tS().getHours())+':'+lZ(tS().getMinutes())+':'+lZ(tS().getSeconds())+' '+aP(tS().getHours())";
//                        <script language="JavaScript" type="text/JavaScript">dT();</script>

