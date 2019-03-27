const app = angular.module("EntryApp", []);
app.controller("EntryCtrl", ($scope) => {

    $scope.BalBl = function() {
        return ($scope.StlBl-$scope.ConBl).toFixed(4);
    };
    $scope.Bal08 = function() {
        return ($scope.Stk08+$scope.Con08).toFixed(4);
    };
    $scope.Bal10 = function() {
        return ($scope.Stk10+$scope.Con10).toFixed(4);
    };
    $scope.Bal12 = function() {
        return ($scope.Stk12+$scope.Con12).toFixed(4);
    };
    $scope.Bal16 = function() {
        return ($scope.Stk16+$scope.Con16).toFixed(4);
    };
    $scope.Bal20 = function() {
        return ($scope.Stk20+$scope.Con20).toFixed(4);
    };
    $scope.Bal25 = function() {
        return ($scope.Stk25+$scope.Con25).toFixed(4);
    };
    $scope.Bal28 = function() {
        return ($scope.Stk28+$scope.Con28).toFixed(4);
    };
    $scope.Bal32 = function() {
        return ($scope.Stk32+$scope.Con32).toFixed(4);
    };
    $scope.StkTT = function() {
        return ($scope.Stk08+$scope.Stk10+$scope.Stk12+$scope.Stk16+$scope.Stk20+$scope.Stk25+$scope.Stk28+$scope.Stk32).toFixed(4);
    };
    $scope.ConTT = function() {
        return ($scope.Con08+$scope.Con10+$scope.Con12+$scope.Con16+$scope.Con20+$scope.Con25+$scope.Con28+$scope.Con32).toFixed(4);
    };
    $scope.BalTT = function() {
        return ($scope.Stk08+$scope.Stk10+$scope.Stk12+$scope.Stk16+$scope.Stk20+$scope.Stk25+$scope.Stk28+$scope.Stk32+$scope.Con08+$scope.Con10+$scope.Con12+$scope.Con16+$scope.Con20+$scope.Con25+$scope.Con28+$scope.Con32).toFixed(4);
    };
    $scope.BalMr = function() {
        return ($scope.StkMr+$scope.ConMr).toFixed(4);
    };
    $scope.BalMs = function() {
        return ($scope.StkMs+$scope.ConMs).toFixed(4);
    };
    $scope.BalSc = function() {
        return ($scope.StkSc+$scope.ConSc).toFixed(4);
    };
    $scope.StkTS = function() {
        return ($scope.StkMr+$scope.StkMs+$scope.StkSc).toFixed(4);
    };
    $scope.ConTS = function() {
        return ($scope.ConMr+$scope.ConMs+$scope.ConSc).toFixed(4);
    };
    $scope.BalTS = function() {
        return ($scope.StkMr+$scope.ConMr+$scope.StkMs+$scope.ConMs+$scope.StkSc+$scope.ConSc).toFixed(4);
    };
});