const TmtProdApp = angular.module("TmtProdApp", []);
const FoProdApp = angular.module("FoProdApp", []);

TmtProdApp.controller("TmtProdCtrl", ($scope) => {

    // $scope.ConBl=$scope.PrvBl;
    // $scope.Con08=$scope.Prv08;
    // $scope.Con10=$scope.Prv10;
    // $scope.Con12=$scope.Prv12;
    // $scope.Con16=$scope.Prv16;
    // $scope.Con20=$scope.Prv20;
    // $scope.Con25=$scope.Prv25;
    // $scope.Con28=$scope.Prv28;
    // $scope.Con32=$scope.Prv32;
    // $scope.ConMr=$scope.PrvMr;
    // $scope.ConMs=$scope.PrvMs;
    // $scope.ConSc=$scope.PrvSc;

    $scope.ConBl=0;
    $scope.Con08=0;
    $scope.Con10=0;
    $scope.Con12=0;
    $scope.Con16=0;
    $scope.Con20=0;
    $scope.Con25=0;
    $scope.Con28=0;
    $scope.Con32=0;
    $scope.ConMr=0;
    $scope.ConMs=0;
    $scope.ConSc=0;

    $scope.BalBl = function() {
        return ($scope.StkBl - (($scope.ConBl>0) ? $scope.ConBl : $scope.PrvBl)).toFixed(4);
    };
    $scope.Bal08 = function() {
        return ($scope.Stk08 + (($scope.Con08>0) ? $scope.Con08 : $scope.Prv08)).toFixed(4);
    };
    $scope.Bal10 = function() {
        return ($scope.Stk10 + (($scope.Con10>0) ? $scope.Con10 : $scope.Prv10)).toFixed(4);
    };
    $scope.Bal12 = function() {
        return ($scope.Stk12 + (($scope.Con12>0) ? $scope.Con12 : $scope.Prv12)).toFixed(4);
    };
    $scope.Bal16 = function() {
        return ($scope.Stk16 + (($scope.Con16>0) ? $scope.Con16 : $scope.Prv16)).toFixed(4);
    };
    $scope.Bal20 = function() {
        return ($scope.Stk20 + (($scope.Con20>0) ? $scope.Con20 : $scope.Prv20)).toFixed(4);
    };
    $scope.Bal25 = function() {
        return ($scope.Stk25 + (($scope.Con25>0) ? $scope.Con25 : $scope.Prv25)).toFixed(4);
    };
    $scope.Bal28 = function() {
        return ($scope.Stk28 + (($scope.Con28>0) ? $scope.Con28 : $scope.Prv28)).toFixed(4);
    };
    $scope.Bal32 = function() {
        return ($scope.Stk32 + (($scope.Con32>0) ? $scope.Con32 : $scope.Prv32)).toFixed(4);
    };
    $scope.StkTT = function() {
        return ($scope.Stk08 + $scope.Stk10 + $scope.Stk12 + $scope.Stk16 + $scope.Stk20 + $scope.Stk25 + $scope.Stk28 + $scope.Stk32).toFixed(4);
    };
    $scope.PrvTT = function() {
        return ($scope.Prv08 + $scope.Prv10 + $scope.Prv12 + $scope.Prv16 + $scope.Prv20 + $scope.Prv25 + $scope.Prv28 + $scope.Prv32).toFixed(4);
    };
    $scope.ConTT = function() {
        return ($scope.Con08 + $scope.Con10 + $scope.Con12 + $scope.Con16 + $scope.Con20 + $scope.Con25 + $scope.Con28 + $scope.Con32).toFixed(4);
    };
    $scope.BalTT = function() {
        return ($scope.Stk08 + $scope.Stk10 + $scope.Stk12 + $scope.Stk16 + $scope.Stk20 + $scope.Stk25 + $scope.Stk28 + $scope.Stk32 + (($scope.Con08>0) ? $scope.Con08 : $scope.Prv08) + (($scope.Con10>0) ? $scope.Con10 : $scope.Prv10) + (($scope.Con12>0) ? $scope.Con12 : $scope.Prv12) + (($scope.Con16>0) ? $scope.Con16 : $scope.Prv16) + (($scope.Con20>0) ? $scope.Con20 : $scope.Prv20) + (($scope.Con25>0) ? $scope.Con25 : $scope.Prv25) + (($scope.Con28>0) ? $scope.Con28 : $scope.Prv28) + (($scope.Con32>0) ? $scope.Con32 : $scope.Prv32)).toFixed(4);
    };
    $scope.BalMr = function() {
        return ($scope.StkMr + (($scope.ConMr>0) ? $scope.ConMr : $scope.PrvMr)).toFixed(4);
    };
    $scope.BalMs = function() {
        return ($scope.StkMs + (($scope.ConMs>0) ? $scope.ConMs : $scope.PrvMs)).toFixed(4);
    };
    $scope.BalSc = function() {
        return ($scope.StkSc + (($scope.ConSc>0) ? $scope.ConSc : $scope.PrvSc)).toFixed(4);
    };
    $scope.StkTS = function() {
        return ($scope.StkMr + $scope.StkMs + $scope.StkSc).toFixed(4);
    };
    $scope.PrvTS = function() {
        return ($scope.PrvMr + $scope.PrvMs + $scope.PrvSc).toFixed(4);
    };
    $scope.ConTS = function() {
        return ($scope.ConMr + $scope.ConMs + $scope.ConSc).toFixed(4);
    };
    $scope.BalTS = function() {
        return ($scope.StkMr + (($scope.ConMr>0) ? $scope.ConMr : $scope.PrvMr) + $scope.StkMs + (($scope.ConMs>0) ? $scope.ConMs : $scope.PrvMs) + $scope.StkSc + (($scope.ConSc>0) ? $scope.ConSc : $scope.PrvSc)).toFixed(4);
    };
});

FoProdApp.controller("FoProdCtrl", ($scope) => {

    // $scope.ConFo=$scope.PrvFo;
    // $scope.Con08=$scope.Prv08;

    $scope.ConFo=0;
    $scope.Con08=0;

    $scope.BalFo = function() {
        return ($scope.StkFo - (($scope.ConFo>0) ? $scope.ConFo : $scope.PrvFo)).toFixed(4);
    };
});