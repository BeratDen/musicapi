from django.contrib.auth.models import User
from musics.models import Category, Musician, Album, Music, List
from musics.api.serializers import CategorySerializer, MusicianSerializer,AlbumSerializer,MusicSerializer, ListSerializer, UserSerializer
from rest_framework import permissions, viewsets, filters

# Create your views here.

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [permissions.AllowAny]

class MusicianViewSet(viewsets.ModelViewSet):
    queryset = Musician.objects.all()
    serializer_class = MusicianSerializer
    permission_classes = [permissions.AllowAny]

class AlbumViewSet(viewsets.ModelViewSet):
    queryset = Album.objects.all()
    serializer_class = AlbumSerializer
    permission_classes = [permissions.AllowAny]

class MusicViewSet(viewsets.ModelViewSet):
    search_fields = ['name','artist__first_name','artist__last_name','lyric']
    filter_backends = (filters.SearchFilter,)
    queryset = Music.objects.all()
    serializer_class = MusicSerializer
    permission_classes = [permissions.AllowAny]

class ListViewSet(viewsets.ModelViewSet):
    queryset = List.objects.all()
    serializer_class = ListSerializer
    permission_classes = [permissions.AllowAny]

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.AllowAny]
