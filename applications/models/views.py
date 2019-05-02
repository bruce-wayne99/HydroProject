from django.shortcuts import render
from applications.models.models import Station
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json
import time
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression

def index(request):
	return render(request, 'models/index.html', {})

def prediction(request):
	return render(request, 'models/prediction.html', {})

def data(request):
	return render(request, 'models/data_adding.html', {})

def ajax_get_results(request):
	time.sleep(2)
	if request.method == 'GET':
		# image = request.GET['seasonal'] + '_' + request.GET['region'] + '_' + request.GET['variable'] + '.jpg'
		ipath = request.GET['seasonal'] + '/' + request.GET['region'] + '_' + request.GET['visualization'] + '_' + request.GET['variable'] + '.jpg'
		print(ipath)
		return HttpResponse(json.dumps({
				'ipath': ipath
			}), content_type="application/json", status=200)

def ajax_get_prediction(request):
	time.sleep(2)
	if request.method == 'GET':
		data_type = request.GET['seasonal']
		region = request.GET['region']
		region_idx = int(region.split('_')[1]) - 1
		year = int(request.GET['year'])
		month = int(request.GET['month'])
		Y_train = pd.read_csv('data/' + data_type + '.csv').values[region_idx, :]
		Y_train = Y_train.reshape(Y_train.shape[0], 1)
		X_train = np.zeros((Y_train.shape[0], 2))
		for i in range(X_train.shape[0]):
			X_train[i, 0] = int(i/12)
			X_train[i, 1] = i%12
		model = LinearRegression().fit(X_train, Y_train)
		value = round(model.predict(np.array([[(year-1992), month]]))[0][0], 2)
		if data_type == 'spi':
			string = 'The predicted value of precipitation on the given year and month is '
		if data_type == 'sri':
			string = 'The predicted value of run-off on the given year and month is '
		if data_type == 'spei':
			string = 'The predicted value of evapotranspiration on the given year and month is '
		return HttpResponse(json.dumps({
				'value': value,
				'string': string
			}), content_type="application/json", status=200)

def ajax_add_data(request):
	return HttpResponse(json.dumps({
			'success': True
		}), content_type="application/json", status=200)