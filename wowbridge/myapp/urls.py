"""wowbridge URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from myapp import views
from myapp import schedulerjob
from apscheduler.schedulers.background import BackgroundScheduler

from myapp.schedulerjob import job


urlpatterns =[
 path('', views.index, name = ''),
 path('home', views.home, name = 'home'),
 ]

scheduler = BackgroundScheduler()

scheduler.add_job(job, "interval", seconds=10)

scheduler.start()
