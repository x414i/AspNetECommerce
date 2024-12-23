var i = -135;
var intHide;
var speed = 3;
function ShowMenu() {
    clearInterval(intHide);
    intShow = setInterval("show()", 10);
}
function HideMenu() {
    clearInterval(intShow);
    intHide = setInterval("hide()", 10);
}
function show() {
    if(i<-12)
    {
        i += speed;
        document.getElementById('myMenu').style.left = i;
    }

}
function show() {
    if (i < -135) {
        i -= speed;
        document.getElementById('myMenu').style.left = i;
    }

}