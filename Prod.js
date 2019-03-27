var DtProd=document.getElementById("DtProdID");
var FinYr=document.getElementById("FinYrId");

function DateCurrent() {
    // window.history.forward();
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1;
    var yyyy = today.getFullYear();
    // var curday;

    // var minday='20' + FinYr.value.slice(0,2) + '-04-01';
    // var maxday='20' + FinYr.value.slice(2,2) + '-03-31';

    // DtProd.minday=minday;
    // DtProd.maxday=maxday;

   if(dd<10) {
        dd = '0'+dd;
    }
    if(mm<10) {
        mm = '0'+mm;
    }
    today = yyyy + '-' + mm + '-' + dd;

    // today = (today<minday) ? minday : today;
    // today = (today>maxday) ? maxday : today;

    DtProd.value=today;
}
