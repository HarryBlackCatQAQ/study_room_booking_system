from urllib.parse import parse_qs

from channels.db import database_sync_to_async
from django.contrib.auth import get_user_model
from django.contrib.auth.models import AnonymousUser
from rest_framework_simplejwt.tokens import AccessToken


# get the django user linked to a websocket jwt token
@database_sync_to_async
def get_user_from_token(token):
    User = get_user_model()

    try:
        validated_token = AccessToken(token)
        # read the user id stored in the jwt payload
        user_id = validated_token['user_id']
        return User.objects.get(pk=user_id)
    except Exception:
        # fall back to an anonymous user when the token is missing or invalid
        return AnonymousUser()


# custom JWT auth middleware for websocket connections
class JwtAuthMiddleware:
    def __init__(self, inner):
        self.inner = inner

    async def __call__(self, scope, receive, send):
        # read the token from the websocket query string
        query_params = parse_qs(scope.get('query_string', b'').decode())
        token = query_params.get('token', [None])[0]

        if token:
            scope['user'] = await get_user_from_token(token)
        else:
            scope['user'] = AnonymousUser()

        return await self.inner(scope, receive, send)


# helper that matches the channels middleware stack interface
def JwtAuthMiddlewareStack(inner):
    return JwtAuthMiddleware(inner)
