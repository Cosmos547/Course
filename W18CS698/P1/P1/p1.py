import pyglet
from pyglet.window import mouse
from pyglet import clock
import numpy as np
import sounddevice as sd
from threading import Thread

window = pyglet.window.Window()
sd.default.samplerate = 44100

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
    global stream
    # t = Thread(target=generateSound())
    # t.start()
    # audios.append(generateSound(0.08, 1.0))

    # stream.write(generateSound(0.08, 1.0))
    # Thread(target=generateSound, args=(0.08,1.0,)).start()
    w = 0.05 + 0.07*x/640
    s = 0.2 + 1.0*y/480
    
    
    print("Playing at " + str(w) + " meters away with " + str(s) + " of force")


    Thread(target=generateSound, args=(w, s)).start()

@window.event
def on_draw():
    window.clear()
    fps_display.draw()

def playaudio(dt):
    global audios
    global stream
    samples = int(0.5*44100/60)
    if (samples % 2 == 0):
        samples += 1
    for i in range(len(audios)):
        stream.write(audios[i][:samples+1])
        audios[i] = audios[i][samples+1:]

    for i in range(len(audios)):
        print(len(audios[i]))
        if (len(audios[i]) == 0):
            del audios[i]
            i -= 1
    print(len(audios))
    print(dt)

clock.set_fps_limit(60)
# clock.schedule_interval(playaudio, 0.01)
pyglet.app.run()


