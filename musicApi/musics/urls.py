from django.urls import path, include
from rest_framework import routers

from musics.api import views

router = routers.DefaultRouter()
router.register(r'categories', views.CategoryViewSet)
router.register(r'musicians', views.MusicianViewSet)
router.register(r'albums', views.AlbumViewSet)
router.register(r'musics', views.MusicViewSet)
router.register(r'lists', views.ListViewSet)

urlpatterns = [
    path('api/v1/', include(router.urls)),
]

urlpatterns += router.urls
