from avaliauto_api.models import *
from rest_framework import serializers


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        exclude = ['groups','user_permissions','is_staff','is_superuser',
                   'is_active','last_login','date_joined']
        extra_kwargs = {'password': {'write_only': True}}
        #fields = '__all__'

    def save(self):
        user = User(
            email=self.validated_data['email'],
            first_name=self.validated_data['first_name'],
            last_name=self.validated_data['last_name'],
            tel=self.validated_data['tel'],
            type=self.validated_data['type'],
            password=self.validated_data['password']
        )
        user.set_password(user.password)
        user.save()
        return user

    def update(self, instance, validated_data):
        for (key, value) in validated_data.items():
            setattr(instance, key, value)
        instance.save()
        return instance

class TypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Type
        fields = '__all__'

class ConsultancySerializer(serializers.ModelSerializer):
    class Meta:
        model = Consultancy
        fields = '__all__'

class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'