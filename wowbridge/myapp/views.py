from django.shortcuts import render
from django.contrib.auth.models import User
from django.http import Http404

from myapp.serializers import UserSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
# Create your views here.
def index(request):
   
   return render(request, "home.html")


def home(request):
   
   return render(request, "home.html")


class UserList(APIView):
	"""
	List all users, or create a new user.
	"""
	def get(self, request, format=None):
		users = User.objects.all()
		serializer = UserSerializer(users, many=True)
		return Response(serializer.data)

	def post(self, request, format=None):
		serializer = UserSerializer(data=request.DATA)
		if serializer.is_valid():
			serializer.save()
			#my_group = Group.objects.get(name='Admin') 
			# my_group.user_set.add(1)
			return Response(serializer.data, status=status.HTTP_201_CREATED)
		return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

	def delete(self, request, pk, format=None):
		user = self.get_object(pk)
		user.delete()
		return Response(status=status.HTTP_204_NO_CONTENT)
	def put(self, request, format=None):
		"""
		This text is the description for this API.

		---
		parameters:
			- name: username
			description: Foobar long description goes here
			required: true
			type: string
			paramType: form
			- name: password
			paramType: form
			required: true
			type: string
		"""
		username = request.DATA['username']
		password = request.DATA['password']


