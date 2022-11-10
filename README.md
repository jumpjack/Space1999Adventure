![image](https://user-images.githubusercontent.com/1620953/200532450-90ec5331-c57a-4d58-a368-35cb43314cc9.png)
 ![image](https://user-images.githubusercontent.com/1620953/200525511-4756c506-7fef-4b35-8dee-3cb3def45eb7.png)


# Space 1999 Adventure

Adventure game by "[Chema](http://isa.uniovi.es/~chema/)" (Jose Maria Enguita Gonzalez) based on "[Space 1999](https://en.wikipedia.org/wiki/Space:_1999)" TV series by Gerry and Sylvia Anderson, aired on 1975-1978.

Original adventure game was created in 2010 for 8-bit [Oric computers](https://en.wikipedia.org/wiki/Oric):
1) Windows executables ([English](https://www.defence-force.org/files/space1999-en.zip), [French](https://www.defence-force.org/files/space1999-fr.zip)) (785 KB)
2) [Official page](https://www.defence-force.org/index.php?page=games&game=space1999)
3) [Sources on defence-force.org/archive.org](https://web.archive.org/web/20170628070728/http://miniserve.defence-force.org/svn/public/oric/games/Space%201999/)
4) [Sources on OSDN.net](https://osdn.net/projects/oricsdk/scm/svn/archive/head/public/oric/games/Space%201999/?format=zip)
5) [Development discussion thread](https://forum.defence-force.org/viewtopic.php?t=135)

This repository holds the original source code for Oric, which include raw stuff (images and maps) which would allow rebuilding the game for any platform. Oric version was build using wcmap.exe and wcgraph.exe . 

The game was [started in 2006 by users "Twilighte" and "Chema" on defence-force.org](https://forum.defence-force.org/viewtopic.php?t=135), and written using Windows  tools NOISE (Novel Oric ISometric Engine) and WHITE (World Handling and Interaction with The Environment) by Chema, which you can find [here](http://isa.uniovi.es/~chema/white+noise/intro.htm).

# Porting to "Tiled"

## Technical details

There are 114 rooms in the game, created with [map editor "WHITE"](https://www.defence-force.org/ftp/forum/isometric/space1999/):

- The map of the rooms is contained in file xxxx (can't find it yet)
- The names of the rooms are listed in  "\Space 1999\Sources\game source\world\space1999.txt.lab"
- Eeach room is composed of "tiles" as described in file "\Space 1999\Sources\game source\world\space1999.txt"
- The names of each tile used to build each room are listed in "\Space 1999\Sources\game source\world\tileset.txt"

Game author states:

_A standard block (that uses all the tile space and its height) is a picture of 24x20 (see block.bmp), but you can use much more higher graphics (I don't remember where the limit is, actually), for example for walls. Currently I am using images of **12x38** for walls, with the idea of them being 4 layers in height (8x4=32 logical coordinates). You can notice you don't need to draw the parts that would be occult, as NOISE correctly displays the tile._

Probably there's a typo and he meant "**12x32**" as size for walls.

### Tiles size

Tiles have various sizes: width is always multiple of 12; height is apparently "free":

12x17 (w.bmp):

![image](https://user-images.githubusercontent.com/1620953/201062676-6014de36-331e-468e-a322-39154a6d503d.png)


12x40 (wall2panel.bmp):

![image](https://user-images.githubusercontent.com/1620953/201062515-54e9717f-5d63-4213-b973-65e4f0e502c1.png)


24x17 (stairS.bmp):

![image](https://user-images.githubusercontent.com/1620953/201062328-d5cfd433-7469-44ad-b99c-050d1ad00b2f.png)



The different widths "confuse" Tiled, which expect all tiles tohave same widths, so images set should be modified to have all tiles of same width = 24, so as to fit in a Tiled map which expects 24x12 tiles.

This Imagemagick commandline doubles the width of an image without stretching it, but just adding empty space:

    convert w12.png  -background transparent -gravity west -extent 24x -format bmp  w24.bmp
    
Result:

![immagine](https://user-images.githubusercontent.com/1620953/201090954-56e52568-cd73-4430-83cd-b3577c02f244.png)

To apply to all images in a folder we shall use **mogrify**:

    mogrify  -background transparent -gravity west -extent 24x -format bmp -path . *.png

### Tiles transparency

Some tiles are also made of main image and transparency mask; to get a couple into a single .PNG image with transparency, ImageMagick can be used (in the mask, black is the transparent color.):

    convert image.png -alpha on \( +clone -channel a -fx 0 \) +swap mask.png -composite masked.png

Tiles are stored in /Sources/game source/world/; if an image named "filename.bmp" has a mask, there is a "filename-mask.bmp:

root.bmp:

![image](https://user-images.githubusercontent.com/1620953/201062875-dad32099-752b-46cb-9872-f82b9e5e317e.png)


root-mask.bmp:

![image](https://user-images.githubusercontent.com/1620953/201062950-acaf41ec-8e12-49cd-b568-05fb6295fe37.png)

Result:

![immagine](https://user-images.githubusercontent.com/1620953/201063826-bddb30b5-8263-4e3f-a029-96b37add5524.png)


