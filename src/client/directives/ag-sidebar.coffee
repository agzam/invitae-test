$ = require 'jquery'

module.exports = ($timeout)->
    scope:
       data : "=data"
    restrict: 'E'
    templateUrl: 'partials/directives/ag-sidebar'
    link:(scope, element, attr)->
        scope.active = true
        scope.toggleActiveLabel = "show inactive"
        scope.toggleActive = ->
            scope.active = !scope.active
            $(".sidebar-content").animate({ scrollTop: (if scope.active then window.innerHeight else 0)}, 300)
            scope.toggleActiveLabel = if scope.active then "show inactive" else "show active"

        scope.chooseItem = (item)->
            scope.$emit('itemSelected', item)

