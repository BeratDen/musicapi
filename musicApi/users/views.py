from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed, NotFound
from .serializes import UserSerializer
from .models import CustomUser
import jwt, datetime
from django.contrib.auth import get_user_model
from rest_framework import permissions, viewsets

class RegisterAPIView(APIView):
    def post(self,request):
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


class LoginAPIView(APIView):
    def post(self,request):
        email = request.data.get('email')
        password = request.data.get('password')
        user = CustomUser.objects.filter(email=email).first()

        if user is None:
            print('user not found')
            raise NotFound('User not found')

        if not user.check_password(password):
            raise AuthenticationFailed('Password is incorrect')

        payload = {
            'id' : user.id,
            # 'exp' : datetime.datetime.utcnow() + datetime.timedelta(minutes=60) 1 hour to expiration time
            'iat' : datetime.datetime.utcnow()
        }

        token = jwt.encode(payload,'secret', algorithm='HS256')

        response  = Response()
        response.set_cookie(key='jwt', value=token, httponly=True)
        response.data = {
            'jwt' : token
        }

        return response

class UserAPIView(APIView):
    def get(self,request):
        token = request.COOKIES.get('jwt')

        if not token:
            raise AuthenticationFailed('Unauthenticated')

        try:
            payload = jwt.decode(token, 'secret', algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            raise AuthenticationFailed('Unauthenticated')

        user = CustomUser.objects.filter(id=payload['id']).first()
        serializer = UserSerializer(user)

        return Response(serializer.data)

class LogoutAPIView(APIView):
    def post(self,request):
        response = Response()
        response.delete_cookie('jwt')
        response.data = {
            'message': 'success',
        }
        return response

class CustomUserViewSet(viewsets.ModelViewSet):
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.AllowAny]
