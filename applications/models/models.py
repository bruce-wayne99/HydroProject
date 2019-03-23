from django.db import models

class Station(models.Model):
	region = models.CharField(max_length=200, null=True)
	index = models.CharField(max_length=1000, null=True)
	ipath = models.CharField(max_length=200, null=True)
	time = models.CharField(max_length=200, null=True)

	def serialize(cls):
		return {
			'id': cls.id,
			'region': cls.region,
			'index': cls.index,
			'time': cls.time,
			'ipath': cls.ipath
		}