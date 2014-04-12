d3 = require 'd3'

module.exports =

($rootScope, $scope, dataService, $timeout, $http)->
    $scope.data = dataService.getData()

    $scope.chooseDepartment = (dep)->
        return if dep is $scope.selectedDepartment
        $scope.selectedDepartment = null
        $scope.selectedItem = null
        $timeout ->
            $scope.selectedDepartment = dep
            $scope.selectedDepartment.color = dataService.getColor(dep.department)
            $scope.dataByCompanies = dataService.getDataByCompanies(dep.department)
        ,400


    $scope.tabColor = (dep)->
        if dep is $scope.selectedDepartment
            'background-color': d3.rgb($scope.selectedDepartment.color).brighter(0.4)

    $scope.$on 'itemSelected', (event, item)->
        $scope.selectedItem = item

    $rootScope.$on 'itemAdded',(event, item)->
        $scope.selectedDepartment.inStockCount += 1
        $scope.selectedDepartment.toDateSpent += item.costPerUnit

        if item.guid is $scope.selectedItem.guid
            $scope.selectedItem.toDateSpent += $scope.selectedItem.costPerUnit
            $scope.selectedItem.inStockCount += 1

    $rootScope.$on 'itemSubtracted',(event, item)->
        if $scope.selectedItem.inStockCount < 2
            $scope.cannotSubtractMore = true
            $timeout ->
                $scope.cannotSubtractMore = false
            ,2000
            return

        $scope.selectedDepartment.inStockCount -= 1
        $scope.selectedDepartment.toDateSpent -= item.costPerUnit

        if item.guid is $scope.selectedItem.guid
            $scope.selectedItem.toDateSpent -= $scope.selectedItem.costPerUnit
            $scope.selectedItem.inStockCount -= 1

    $scope.addItem = -> dataService.addItem($scope.selectedItem.guid)

    $scope.subtractItem = -> dataService.subtractItem($scope.selectedItem.guid)



