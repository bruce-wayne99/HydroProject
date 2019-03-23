from django.shortcuts import render
from applications.models.models import Station
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json
import time

def index(request):
	return render(request, 'models/index.html', {})

def ajax_get_results(request):
	time.sleep(2)
	if request.method == 'GET':
		# image = request.GET['seasonal'] + '_' + request.GET['region'] + '_' + request.GET['variable'] + '.jpg'
		ipath = request.GET['seasonal'] + '/' + request.GET['region'] + '_' + request.GET['visualization'] + '_' + request.GET['variable'] + '.jpg'
		return HttpResponse(json.dumps({
				'ipath': ipath
			}), content_type="application/json", status=200)