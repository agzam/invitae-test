_ = require 'lodash'

require 'angular/angular'
dataJson = require '../data/data.json'

parseMoney = (moneyStr)-> parseFloat(moneyStr.replace(/[\$,\,]/g,""))

module.exports = ($rootScope) ->
    _data = _(dataJson)


    rawData: -> _data.valueOf()

    getData: ->
        arr = []
        _data.each (e)->
            f = _.find(arr, {department: e.department})
            e.toDateSpent = parseMoney(e.toDateSpent)
            e.costPerUnit = parseMoney(e.costPerUnit)
            e.initialOrderDate = new Date(e.initialOrderDate.substring(0, e.initialOrderDate.length - 7))
            if f?
                f.inStockCount += e.inStockCount
                f.toDateSpent += e.toDateSpent
                if f.elements? then f.elements.push(e)
            else
                els = []
                els.push(e)
                arr.push
                    department: e.department
                    inStockCount : e.inStockCount
                    toDateSpent : e.toDateSpent
                    elements: els

        arr

    getDataByCompanies:(department)->
        ret = {'true':[], 'false':[]}
        _data
        .sortBy("sourceCompany")
        .each (i)-> ret[i.isActive].push(i) if i.department is department

        ret

    getColor: (dep)->
        colors =
            0: '#EBF7BB'
            1: '#BBD1F7'
            2: '#F7F7BB'
            3: '#F7CCBB'

        depIndex = _data.pluck("department").uniq().indexOf(dep)
        colors[depIndex]

    addItem: (guid)->
        found = _data.find((i)-> i.guid is guid)
        $rootScope.$emit("itemAdded",found) if found

    subtractItem: (guid)->
        found = _data.find((i)-> i.guid is guid)
        $rootScope.$emit("itemSubtracted",found) if found
