from django.contrib import admin

# Register your models here.

from .models import Category, Musician,Album,Music,List

class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name',)
    prepopulated_fields = {'slug': ('name',)}

class MusicianAdmin(admin.ModelAdmin):
    list_display = ('first_name','last_name',)
    prepopulated_fields = {'slug': ('first_name','last_name')}

class AlbumAdmin(admin.ModelAdmin):
    list_display = ('name','artist','num_stars')
    prepopulated_fields = {'slug': ('name',)}

class MusicAdmin(admin.ModelAdmin):
    list_display = ('name','album','num_stars')
    prepopulated_fields = {'slug': ('name',)}

class ListAdmin(admin.ModelAdmin):
    list_display = ('name','image','creator')
    prepopulated_fields = {'slug': ('name',)}

admin.site.register(Category, CategoryAdmin)
admin.site.register(Musician,MusicianAdmin)
admin.site.register(Album, AlbumAdmin)
admin.site.register(Music, MusicAdmin)
admin.site.register(List,ListAdmin)
