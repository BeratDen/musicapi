from music.models import Category, Musician, Album, Music

from rest_framework import serializers

class CategorySerializer(serializers.HyperlinkedModelSerializer):
    createdAt = serializers.DateTimeField(source='created_at', format='%Y-%m-%d %H:%M:%S')
    updatedAt = serializers.DateTimeField(source='updated_at', format='%Y-%m-%d %H:%M:%S')

    class Meta:
        model = Category
        fields = ['id','name','description','slug','createdAt','updatedAt']

class MusicianSerializer(serializers.HyperlinkedModelSerializer):
    albums = serializers.SerializerMethodField()
    musics = serializers.SerializerMethodField()

    class Meta:
        model = Musician
        fields = ['first_name','last_name','slug','resume','category','albums','musics']

    def get_albums(self,obj):
        albums = obj.album_set.all()
        request = self.context.get('request')
        return AlbumSerializer(albums, context={'request': request}, many=True).data

    def get_musics(self,obj):
        musics = obj.music_set.all()
        request = self.context.get('request')
        return MusicSerializer(musics, context={'request': request}, many=True).data,



class AlbumSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Album
        fields = ['name','slug','artist','release_date','num_stars']

class MusicSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Music
        fields = [
            'name',
            'slug',
            'lyric',
            'artist',
            'category',
            'album',
            'music_url',
            'image_url',
            'video_url',
            'release_date',
            'num_stars'
        ]
