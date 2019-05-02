from django.conf.urls import url

from . import views

urlpatterns = [
	url(r'^ajax/get_results', views.ajax_get_results, name='Ajax request for getting results'),
	url(r'^ajax/get_prediction', views.ajax_get_prediction, name='Ajax request for getting predictions'),
	url(r'^ajax/add_data', views.ajax_add_data, name='Ajax request for adding new data'),
	url(r'^prediction', views.prediction, name='Prediction Page'),
	url(r'^data', views.data, name='Adding new data'),
    url(r'^', views.index, name='Index page')
]