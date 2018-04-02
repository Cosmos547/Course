import pyglet
from pyglet.window import mouse
from exp import *
from pyglet import clock
import numpy as np
import sounddevice as sd
from threading import Thread
from math import *
from pbsr import *

window = pyglet.window.Window(640,480)
sd.default.samplerate = 44100

mouse_x = 0
mouse_y = 0

frequencies = bar(1000)
rfreq = [16,150,440,1100,7902]

fps_display = clock.ClockDisplay()

def generateSound(x, amp):
    stream = sd.OutputStream(dtype=np.int16, channels=2)
    stream.start()
    time = 1.0
    f0 = 0.75526*(x**(-1.87009))
    samples = np.arange(44100*1*time)/44100.0
    wave = 0
    y = [0.03548, 0.0024953, 0.001, 0.000708]
    for i in range(4):
        wave += 281849 * amp * y[i] * np.sin(2*np.pi*f0*samples)
    for i in range(len(wave)):
        wave[i] *= np.exp(-3.0*(i/44100))

    wav_wave = np.array(wave, dtype=np.int16)
    stream.write(wav_wave)
    stream.close()

    return wav_wave
    # Thread(target=sd.play, args=(wav_wave,)).start()
    # sd.play(stream)

    # samples = np.arange(44100*time)/44100.0
    # wave = 10000 * np.sin(2*np.pi*2*f0*samples)
    # wav_wave = np.array(wave, dtype=np.int16)
    # stream.write(wav_wave)
    # sd.play(wav_wave)
    # Thread(target=sd.play, args=(wav_wave,)).start()

@window.event
def on_mouse_press(x, y, button, modifiers):
    global mouse_x
    global mouse_y
    global frequencies
    global rfreq
    # t = Thread(target=generateSound())
    # t.start()
    # audios.append(generateSound(0.08, 1.0))

    # stream.write(generateSound(0.08, 1.0))
    # Thread(target=generateSound, args=(0.08,1.0,)).start()
    mouse_x = x
    mouse_y = y

    hit_x = (mouse_x - 100.0)/440.0
    for i in range(4):
        if (mouse_y > 71+100*i and mouse_y < 111+100*i and hit_x < 1.0 and hit_x > 0.0):
            Thread(target=easy_sound, args=(rfreq[i], hit_x, 3, frequencies)).start()
    
    # print("Playing at " + str(w) + " meters away with " + str(s) + " of force")


    # Thread(target=generateSound, args=(w, s)).start()

def draw_circle(x, y):
    verts = []
    numPoints = 20;
    for i in range(numPoints):
        angle = radians(float(i)/numPoints*360)
        c_x = 20*cos(angle) + x
        c_y = 20*sin(angle) + y
        verts += [c_x,c_y]

    c = pyglet.graphics.vertex_list(numPoints, ('v2f', verts))
    c.draw(pyglet.gl.GL_LINE_LOOP)

labels = []
for i in range(4):
    labels.append(pyglet.text.Label(str(rfreq[i]) + "Hz", font_name='Serif', font_size=12, x= 580, y=96+100*i))

@window.event
def on_draw():
    global mouse_x
    global mouse_y
    window.clear()
    pyglet.gl.glColor3f(1,1,0)

    for i in range(4):
        pyglet.graphics.draw_indexed(4, pyglet.gl.GL_TRIANGLES,
            [0, 1, 2, 0, 2, 3],
            ('v2i', (100, 71+100*i, 540, 71+100*i, 540, 111+100*i, 100, 111+100*i)))
        labels[i].draw()

    # pyglet.graphics.draw_indexed(4, pyglet.gl.GL_TRIANGLES,
            # [0, 1, 2, 0, 2, 3],
            # ('v2i', (mouse_x-20, mouse_y-20, mouse_x+20, mouse_y-20, mouse_x+20, mouse_y+20, mouse_x-20, mouse_y+20)))

    pyglet.gl.glColor3f(1,0,0)
    draw_circle(mouse_x, mouse_y)
    hit_x = (mouse_x - 100.0)/440.0
    if (hit_x > 0.0 and hit_x < 1.0):
        pyglet.text.Label("Hit location: " + "{:10.2f}".format(hit_x), font_name='Serif', font_size=12, x=40, y = 440).draw()
    # print("Current mouse location: ", mouse_x, mouse_y)
    # fps_display.draw()


clock.set_fps_limit(60)
# clock.schedule_interval(playaudio, 0.01)
pyglet.app.run()


