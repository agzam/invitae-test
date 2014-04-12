$ = require 'jquery'
require 'angular/angular'
require 'angular-route/angular-route'
require 'angular-animate/angular-animate'

services = require './services'
controllers = require './controllers'
directives = require './directives'


app = angular.module 'app',['ngRoute','ngAnimate']
app.factory(services)
app.controller(controllers)
app.directive(directives)

app.config ($routeProvider)->
    $routeProvider.when '/',
        templateUrl: "partials/home/home-view"
        controller: "homeCtrl"

angular.element(document).ready ->
    angular.bootstrap(document,['app'])
