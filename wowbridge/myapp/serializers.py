from django.contrib.auth.models import User
from rest_framework import serializers
from .models import Dreamreal


class DreamrealSerializer(serializers.ModelSerializer):
    """Serializer to map the Model instance into JSON format."""

    class Meta:
        """Meta class to map serializer's fields with the model fields."""
        model = Dreamreal
        fields = ('id', 'website', 'mail', 'name','phonenumber')

class UserSerializer(serializers.ModelSerializer):
	class Meta:
		model = User
		fields = ('id', 'username', 'first_name', 'last_name', 'email')
		write_only_fields = ('password',)
		read_only_fields = ('id',)