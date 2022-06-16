from ursina import *

app = Ursina()

camera.isometric = True

cow = Animation('cow', fps = 100, scale = 4)

app.run()