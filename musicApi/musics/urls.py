from django.urls import path, include
from rest_framework import routers

from musics.api import views

router = routers.DefaultRouter()
router.register(r'categories', views.CategoryViewSet)
router.register(r'musicians', views.MusicianViewSet)
router.register(r'albums', views.AlbumViewSet)
router.register(r'musics', views.MusicViewSet)
router.register(r'lists', views.ListViewSet)
router.register(r'users', views.UserViewSet)

urlpatterns = [
    path('api/v1/', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    #Authentication
    path('token/', views.MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]

urlpatterns += router.urls
