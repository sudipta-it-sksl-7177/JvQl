const DtProd = document.getElementById("DtProdID");
const FinYr = document.getElementById("FinYrId");

const vStkBl = document.getElementById("IdStkBl");
const vConBl = document.getElementById("IdConBl");
const vCon08 = document.getElementById("IdCon08");
const vCon10 = document.getElementById("IdCon10");
const vCon12 = document.getElementById("IdCon12");
const vCon16 = document.getElementById("IdCon16");
const vCon20 = document.getElementById("IdCon20");
const vCon25 = document.getElementById("IdCon25");
const vCon28 = document.getElementById("IdCon28");
const vCon32 = document.getElementById("IdCon32");
const vConMr = document.getElementById("IdConMr");
const vConMs = document.getElementById("IdConMs");
const vConEc = document.getElementById("IdConEc");

const vJobCode = document.getElementById("JobProdID");
const vJobDate = document.getElementById("DtProdID");

document.getElementById("IdBtnProd").addEventListener("submit",ValidControl);

function ValidControl() {
    vConBl.value = (vConBl.value == "" || vConBl.value < 0) ? 0 : vConBl.value;
    vCon08.value = (vCon08.value == "" || vCon08.value < 0) ? 0 : vCon08.value;
    vCon10.value = (vCon10.value == "" || vCon10.value < 0) ? 0 : vCon10.value;
    vCon12.value = (vCon12.value == "" || vCon12.value < 0) ? 0 : vCon12.value;
    vCon16.value = (vCon16.value == "" || vCon16.value < 0) ? 0 : vCon16.value;
    vCon20.value = (vCon20.value == "" || vCon20.value < 0) ? 0 : vCon20.value;
    vCon25.value = (vCon25.value == "" || vCon25.value < 0) ? 0 : vCon25.value;
    vCon28.value = (vCon28.value == "" || vCon28.value < 0) ? 0 : vCon28.value;
    vCon32.value = (vCon32.value == "" || vCon32.value < 0) ? 0 : vCon32.value;
    vConMr.value = (vConMr.value == "" || vConMr.value < 0) ? 0 : vConMr.value;
    vConMs.value = (vConMs.value == "" || vConMs.value < 0) ? 0 : vConMs.value;
    vConSc.value = (vConSc.value == "" || vConSc.value < 0) ? 0 : vConSc.value;

    if(vConBl.value == 0) {
        alert('Consumption Billet Can Not Be Zero');
        vConBl.focus();
        return false;
    }
    if(vStkBl.value < vConBl.value) {
        alert('Consumption Billet Can Not Be Less Than Opening');
        vConBl.focus();
        return false;
    }
    if(vConBl.value != (vCon08.value + vCon10.value + vCon12.value + vCon16.value + vCon20.value + vCon25.value + vCon28.value + vCon32.value + vConMr.value + vConMs.value + vConSc.value)) {
        alert('Consumption Billet Vs. Production TMT & Scrap Mis-Match');
        vConBl.focus();
        return false;
    }
    return true;
}

function DateCurrent() {
    // window.history.forward();
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
   if(dd<10) {
        dd = '0' + dd;
    }
    if(mm<10) {
        mm = '0' + mm;
    }
    today = yyyy + '-' + mm + '-' + dd;
    DtProd.value=today;
}

function HideControl() {
    // vJobCode.setAttribute("type","hidden");
    // vJobDate.setAttribute("type","hidden");
}
