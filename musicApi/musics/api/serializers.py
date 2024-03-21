from django.contrib.auth.models import User
from musics.models import Category, Musician, Album, Music, List
from django.urls import reverse
from rest_framework import serializers

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email']

class CategorySerializer(serializers.HyperlinkedModelSerializer):
    createdAt = serializers.DateTimeField(source='created_at', format='%Y-%m-%d %H:%M:%S')
    updatedAt = serializers.DateTimeField(source='updated_at', format='%Y-%m-%d %H:%M:%S')

    class Meta:
        model = Category
        fields = ['id','name','description','slug','createdAt','updatedAt']

class AlbumSerializer(serializers.HyperlinkedModelSerializer):
    musics = serializers.SerializerMethodField()
    class Meta:
        model = Album
        fields = ['name','slug','image','artist','release_date','num_stars','musics']

    def get_musics(self,obj):
        musics = obj.music_set.all()
        request = self.context.get('request')
        return MusicSerializer(musics, context={'request': request}, many=True).data

class MusicSerializer(serializers.HyperlinkedModelSerializer):
    artist_name = serializers.CharField(source='artist.first_name')
    class Meta:
        model = Music
        fields = [
            'name',
            'slug',
            'lyric',
            'artist',
            'artist_name',
            'category',
            'album',
            'music_url',
            'image_url',
            'video_url',
            'release_date',
            'num_stars'
        ]

    def get_artist(self,obj):
        artist = obj.artist
        request = self.context.get('request')
        return MusicianSerializer(artist, context={'request': request}, many=True).data

class ListSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = List
        fields = ['id','name','slug','description','image','creator','musics']

class MusicianSerializer(serializers.HyperlinkedModelSerializer):
    albums = serializers.SerializerMethodField()
    musics = serializers.SerializerMethodField()

    class Meta:
        model = Musician
        fields = ['first_name','last_name','avatar','slug','resume','category','albums','musics']

    def get_albums(self,obj):
        albums = obj.album_set.all()
        request = self.context.get('request')
        return [request.build_absolute_uri(reverse('album-detail', args=[album.id])) for album in albums]

    def get_musics(self,obj):
        musics = obj.music_set.all()
        request = self.context.get('request')
        return [request.build_absolute_uri(reverse('music-detail', args=[music.id])) for music in musics]
