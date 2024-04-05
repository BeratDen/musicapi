from rest_framework import serializers
from .models import CustomUser

class UserSerializer(serializers.ModelSerializer):
    value = serializers.HyperlinkedIdentityField(view_name='customuser-detail')

    class Meta:
        model = CustomUser
        fields = ['id','value','username','email','password']
        extra_kwargs = {
            'password' : {'write_only': True}
        }

    def create(self, validated_data):
        password = validated_data.pop('password', None)
        instance = self.Meta.model(**validated_data)
        if password is not None:
            instance.set_password(password)
        instance.save()
        return instance

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.context['request'] = self.context.get('request')
