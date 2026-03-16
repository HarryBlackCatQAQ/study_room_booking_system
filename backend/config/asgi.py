import os

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')

from channels.routing import ProtocolTypeRouter
from channels.security.websocket import AllowedHostsOriginValidator
from django.core.asgi import get_asgi_application

# initialize django first so model imports inside websocket consumers do not run before the app registry is ready
django_asgi_application = get_asgi_application()

# import websocket routing only after django has finished setting up the app registry
from config.routing import application as websocket_application
from support.ws_auth import JwtAuthMiddlewareStack

application = ProtocolTypeRouter({
    "http": django_asgi_application,
    "websocket": AllowedHostsOriginValidator(
        JwtAuthMiddlewareStack(websocket_application),
    ),
})
