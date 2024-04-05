from rest_framework import permissions
from rest_framework.exceptions import AuthenticationFailed

class JTWPermission(permissions.BasePermission):
    def has_permission(self, request, view):
        ip_addr = request.META['REMOTE_ADDR']
        print("current client ip" + ip_addr)
        token = request.COOKIES.get('jwt')
        print(token)
        if token or request.user.is_authenticated :
            return True

        raise AuthenticationFailed('Unauthenticated')
