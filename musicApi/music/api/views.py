from music.models import Category, Musician, Album, Music
from music.api.serializers import CategorySerializer, MusicianSerializer,AlbumSerializer,MusicSerializer
from rest_framework import permissions, viewsets

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
    queryset = Music.objects.all()
    serializer_class = MusicSerializer
    permission_classes = [permissions.AllowAny]
