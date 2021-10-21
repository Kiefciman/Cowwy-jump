from ursina import *

app = Ursina()

camera.isometric = True

cow = Animation('cow', fps = 2, scale = 4)

app.run()