/* global angular, document, window */
'use strict';

angular.module('starter.controllers', [])

.controller('AppCtrl', function($scope, $ionicModal, $ionicPopover, $timeout) {
    // Form data for the login modal
    $scope.loginData = {};
    $scope.isExpanded = false;
    $scope.hasHeaderFabLeft = false;
    $scope.hasHeaderFabRight = false;

    var navIcons = document.getElementsByClassName('ion-navicon');
    for (var i = 0; i < navIcons.length; i++) {
        navIcons.addEventListener('click', function() {
            this.classList.toggle('active');
        });
    }

    ////////////////////////////////////////
    // Layout Methods
    ////////////////////////////////////////

    $scope.hideNavBar = function() {
        document.getElementsByTagName('ion-nav-bar')[0].style.display = 'none';
    };

    $scope.showNavBar = function() {
        document.getElementsByTagName('ion-nav-bar')[0].style.display = 'block';
    };

    $scope.noHeader = function() {
        var content = document.getElementsByTagName('ion-content');
        for (var i = 0; i < content.length; i++) {
            if (content[i].classList.contains('has-header')) {
                content[i].classList.toggle('has-header');
            }
        }
    };

    $scope.setExpanded = function(bool) {
        $scope.isExpanded = bool;
    };

    $scope.setHeaderFab = function(location) {
        var hasHeaderFabLeft = false;
        var hasHeaderFabRight = false;

        switch (location) {
            case 'left':
                hasHeaderFabLeft = true;
                break;
            case 'right':
                hasHeaderFabRight = true;
                break;
        }

        $scope.hasHeaderFabLeft = hasHeaderFabLeft;
        $scope.hasHeaderFabRight = hasHeaderFabRight;
    };

    $scope.hasHeader = function() {
        var content = document.getElementsByTagName('ion-content');
        for (var i = 0; i < content.length; i++) {
            if (!content[i].classList.contains('has-header')) {
                content[i].classList.toggle('has-header');
            }
        }

    };

    $scope.hideHeader = function() {
        $scope.hideNavBar();
        $scope.noHeader();
    };

    $scope.showHeader = function() {
        $scope.showNavBar();
        $scope.hasHeader();
    };

    $scope.clearFabs = function() {
        var fabs = document.getElementsByClassName('button-fab');
        if (fabs.length && fabs.length > 1) {
            fabs[0].remove();
        }
    };
})

.controller('LoginCtrl', function($scope, $state, $rootScope, $timeout, $stateParams, $ionicLoading, ionicMaterialInk) {
    $scope.$parent.clearFabs();
    $timeout(function() {
        $scope.$parent.hideHeader();
    }, 0);

    ionicMaterialInk.displayEffect();
    $scope.show = false;

    $scope.recordYourVoice = function() {
       VoiceIt.createEnrollment({
         developerID: "d00958aaa91241fcb3dce9d11306b0e1",
         email: "creation.wide@gmail.com",
         password: "password1",
         contentLanguage: "en-US"
       }, function(response) {
         alert('Result: ' + response);
         $scope.show = false;
         $scope.$apply();

       }, function(error) {
         $scope.show = false;
         $scope.$apply();

         alert('Error: ' + error);
       });
         $scope.show = true;
    };

    $scope.verifyYourVoice = function() {
        VoiceIt.authentication({
          developerID: "d00958aaa91241fcb3dce9d11306b0e1",
          email: "creation.wide@gmail.com",
          password: "password1",
          accuracy: "5",
          accuracyPasses: "10",
          accuracyPassIncrement: "5",
          confidence: "85",
          contentLanguage: "en-US"

        }, function(response) {
         $rootScope.result = response;
          $scope.show = false;
          $scope.$apply();
          var message = angular.fromJson(response);
          if(message.ResponseCode === "SUC") {
            $state.go('app.profile');

          } else {
            alert(message.Result);

          }

        }, function(error) {
          $scope.show = false;
          $scope.$apply();
          var errorJsonResult = angular.fromJson(error).Result;
          var errorMessage = (errorJsonResult ==="") ? "Internal Server Error":errorJsonResult;
          alert(errorMessage);
        });

        $scope.show = true;
      };


})

.controller('ProfileCtrl', function($scope, $stateParams,$rootScope, $timeout, ionicMaterialMotion, ionicMaterialInk) {
    $scope.messages = angular.fromJson($rootScope.result);
    // Set Header
    $scope.$parent.showHeader();
    $scope.$parent.clearFabs();
    $scope.isExpanded = false;
    $scope.$parent.setExpanded(false);
    $scope.$parent.setHeaderFab(false);

    // Set Motion
    $timeout(function() {
        ionicMaterialMotion.slideUp({
            selector: '.slide-up'
        });
    }, 300);

    $timeout(function() {
        ionicMaterialMotion.fadeSlideInRight({
            startVelocity: 3000
        });
    }, 700);

    // Set Ink
    ionicMaterialInk.displayEffect();
})
;
