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
            'visualization': $('#visualization').val()
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