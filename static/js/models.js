var utils = {
	jsonRequest: function (method, url, data, successCallback, errorCallback) {
        $.ajax({
            headers: {
                'Accept': 'application/json'
            },
            method: method,
            data: method == 'GET' ? data : JSON.stringify(data),
            url: url,
            success: successCallback,
            error: errorCallback
        });
    }
};


var data_adding = {
    init: function() {
        $('#addDataBtn').click(function () {
            data_adding.addData();
        })
    },
    addData: function () {
        $.notify('Successfully added new data point to the csv file', 'success');
        $('#dataVal').html('');
        return;
    }
}
var predictions = {
    init: function () {
        $('#predictButton').click(function () {
            predictions.getPrediction();
        })
    },
    getPrediction: function () {
        utils.jsonRequest('GET', '/ajax/get_prediction', {
            'seasonal': $('#seasonal').val(),
            'region': $('#region').val(),
            'year': $('#year').val(),
            'month': $('#month').val(),
        },
        successCallback = function (response) {
            $('#resultStatement').html(response.string);
            $('#resultPrediction').html(response.value + ' millimeters');
            $.notify('Successfully predicted results','success');
        },
        errorCallback = function (response) {
            $.notify('Failed to predict results','error');
        },)
    }
}
var models = {
	init: function () {
		$('#submitButton').click(function () {
            models.getResults();
        });
	},
    getResults: function () {
        utils.jsonRequest('GET', '/ajax/get_results', {
            'seasonal': $('#seasonal').val(),
            'region': $('#region').val(),
            'variable': $('#variable').val(),
            'visualization': ($('#visualization').val() == 'temp')? $('#seasonal').val() : $('#visualization').val(),
        },
        successCallback = function (response) {
            $('#resultImage').attr('src', '/static/images/' + response.ipath);
            $.notify('Successfully loaded images','success');
        },
        errorCallback = function (response) {
            $.notify('Failed to get the image','error');
        },)
    }
}