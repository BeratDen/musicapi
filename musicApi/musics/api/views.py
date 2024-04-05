from django.contrib.auth import get_user_model
from musics.models import Category, Musician, Album, Music, List
from musics.api.serializers import CategorySerializer, MusicianSerializer,AlbumSerializer,MusicSerializer, ListSerializer
from rest_framework import permissions, viewsets, filters
from .permissions import JTWPermission

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
