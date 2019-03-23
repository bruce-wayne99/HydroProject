from django.conf.urls import url

from . import views

urlpatterns = [
	url(r'^ajax/get_results', views.ajax_get_results, name='Ajax request for getting results'),
    url(r'^', views.index, name='Index page')
]