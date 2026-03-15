from channels.routing import URLRouter

from support.routing import websocket_urlpatterns


application = URLRouter(websocket_urlpatterns)
