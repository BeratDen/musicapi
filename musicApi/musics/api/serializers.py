from musics.models import Category, Musician, Album, Music, List
from django.urls import reverse
from rest_framework import serializers


class CategorySerializer(serializers.HyperlinkedModelSerializer):
    createdAt = serializers.DateTimeField(source='created_at', format='%Y-%m-%d %H:%M:%S')
    updatedAt = serializers.DateTimeField(source='updated_at', format='%Y-%m-%d %H:%M:%S')
    value = serializers.HyperlinkedIdentityField(view_name='category-detail')

    class Meta:
        model = Category
        fields = ['id','name','value','description','slug','createdAt','updatedAt']

class AlbumSerializer(serializers.HyperlinkedModelSerializer):
    musics = serializers.SerializerMethodField()
    value = serializers.HyperlinkedIdentityField(view_name='album-detail')

    class Meta:
        model = Album
        fields = ['name','value','slug','image','artist','release_date','num_stars','musics']

    def get_musics(self,obj):
        musics = obj.music_set.all()
        request = self.context.get('request')
        return MusicSerializer(musics, context={'request': request}, many=True).data

class MusicSerializer(serializers.HyperlinkedModelSerializer):
    artist_name = serializers.CharField(source='artist.first_name',read_only=True)
    class Meta:
        model = Music
        fields = [
            'name',
            'uploader',
            'slug',
            'lyric',
            'artist',
            'artist_name',
            'category',
            'albums',
            'music_url',
            'image_url',
            'video_url',
            'release_date',
            'num_stars'
        ]
        read_only_fields = ['slug',]

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
    feats = serializers.SerializerMethodField()
    value = serializers.HyperlinkedIdentityField(view_name='musician-detail')

    class Meta:
        model = Musician
        fields = ['first_name','last_name','value','avatar','slug','resume','category','albums','musics','feats']

    def get_albums(self,obj):
        albums = obj.album_set.all()
        request = self.context.get('request')
        return [request.build_absolute_uri(reverse('album-detail', args=[album.id])) for album in albums]

    def get_musics(self,obj):
        musics = obj.artist.all()
        request = self.context.get('request')
        return [request.build_absolute_uri(reverse('music-detail', args=[music.id])) for music in musics]

    def get_feats(self,obj):
        musics = obj.feats.all()
        request = self.context.get('request')
        return [request.build_absolute_uri(reverse('music-detail', args=[music.id])) for music in musics]
