from ursina import *

app = Ursina()

camera.isometric = True

cow = load_texture('Assets/cow/iddle/cow.png')
cow1 = load_texture('Assets/cow/iddle/cow1.png')
cow2 = load_texture('Assets/cow/iddle/cow2.png')
cow3 = load_texture('Assets/cow/iddle/cow3.png')

cow = Animation('cow', fps = 0, scale = 4, autoplay = True, frames = (cow, cow1, cow2, cow3))

app.run()