from django.contrib.auth import get_user_model
from musics.models import Category, Musician, Album, Music, List
from musics.api.serializers import CategorySerializer, MusicianSerializer,AlbumSerializer,MusicSerializer, ListSerializer
from rest_framework import permissions, viewsets, filters
from rest_framework.response import Response
from rest_framework.views import APIView
from .permissions import JTWPermission
from rest_framework.exceptions import AuthenticationFailed
import jwt

# Create your views here.

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [JTWPermission]

class MusicianViewSet(viewsets.ModelViewSet):
    queryset = Musician.objects.all()
    serializer_class = MusicianSerializer
    permission_classes = [JTWPermission]

class AlbumViewSet(viewsets.ModelViewSet):
    queryset = Album.objects.all()
    serializer_class = AlbumSerializer
    permission_classes = [JTWPermission]

class MusicViewSet(viewsets.ModelViewSet):
    search_fields = ['name','artist__first_name','artist__last_name','lyric']
    filter_backends = (filters.SearchFilter,)
    queryset = Music.objects.all()
    serializer_class = MusicSerializer
    permission_classes = [JTWPermission]

class ListViewSet(viewsets.ModelViewSet):
    queryset = List.objects.all()
    serializer_class = ListSerializer
    permission_classes = [JTWPermission]


class UserMuiscAPIView(APIView):
    def get(self,request):
        token = request.COOKIES.get('jwt')
        # return Response({
        #     'jwt' : token,
        # },200)
        if not token:
            raise AuthenticationFailed('Unauthenticated')

        try:
            payload = jwt.decode(token, 'secret', algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            raise AuthenticationFailed('Unauthenticated')

        user = get_user_model().objects.filter(id=payload['id']).first()


        if user.music_set.all():
            musics = user.music_set.all()
            serializer = MusicSerializer(musics, many=True,context={'request': request})
            return Response(serializer.data,status=200)
        else:
            return Response({
                'error': "You didn't upload any music"
            },status=400)
