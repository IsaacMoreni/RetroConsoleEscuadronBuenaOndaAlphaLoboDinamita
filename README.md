# RetroConsoleEscuadronBuenaOndaAlphaLoboDinamita
Proyecto de FSEm, Emulador de GB, GB Color y GBA para raspberry pi

## Dependencias Visual Boy
```
cd ~ && mkdir src && cd src
git clone https://github.com/visualboyadvance-m/visualboyadvance-m.git
cd visualboyadvance-m
./installdeps

# ./installdeps will give you build instructions, which will be similar to:

mkdir build && cd build
cmake .. -G Ninja
ninja
```
Para mas informacion visite [esta](https://i.pinimg.com/236x/8f/8f/17/8f8f1741b98e082152e1d78fe42f8963.jpg) [pagina](https://www.youtube.com/watch?v=dQw4w9WgXcQ&list=RD7oUdcT97Fco&index=4&ab_channel=RickAstley)

## Required Dependencies

- [xorg](https://wiki.debian.org/Xorg)
Usado como ayuda para iniciar la interfaz gráfica de la aplicación

- [pip3](https://packages.debian.org/buster/python3-pip)
Es python we, se ucupa

- [python3-gi](https://packages.debian.org/sid/python3-gi)

### Python Requierements

- [Screeninfo](https://pypi.org/project/screeninfo/)
Un apoyo para obtener las dimensiones de la pantalla a usar y poder redimensionar de manera correcta la aplicacion

- [piborg/Gamepad](https://github.com/piborg/Gamepad)
Usado por su facilidad de mapiar los botones y joystick de cualquier control y usarlo en las interfacez
