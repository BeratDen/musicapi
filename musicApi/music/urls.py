from django.urls import path, include
from rest_framework import routers

from music.api import views

router = routers.DefaultRouter()
router.register(r'categories', views.CategoryViewSet)
router.register(r'musicians', views.MusicianViewSet)
router.register(r'albums', views.AlbumViewSet)
router.register(r'musics', views.MusicViewSet)
router.register(r'lists', views.ListViewSet)
router.register(r'users', views.UserViewSet)

urlpatterns = [
    path('api/v1/', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]

urlpatterns += router.urls
