# expose the websocket url router for channels/asgi setup
from channels.routing import URLRouter

from support.routing import websocket_urlpatterns


# use the support websocket routes as the root channels router
application = URLRouter(websocket_urlpatterns)
