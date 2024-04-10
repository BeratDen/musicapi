from django.urls import path, include
from rest_framework import routers

from musics.api.views import *

router = routers.DefaultRouter()
router.register(r'categories', CategoryViewSet)
router.register(r'musicians', MusicianViewSet)
router.register(r'albums', AlbumViewSet)
router.register(r'musics', MusicViewSet)
router.register(r'lists', ListViewSet)

urlpatterns = [
    path('api/v1/', include(router.urls)),
    path('musics/session', UserMuiscAPIView.as_view())
]

urlpatterns += router.urls
