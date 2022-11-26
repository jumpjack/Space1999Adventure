![image](https://user-images.githubusercontent.com/1620953/200532450-90ec5331-c57a-4d58-a368-35cb43314cc9.png)
 ![image](https://user-images.githubusercontent.com/1620953/200525511-4756c506-7fef-4b35-8dee-3cb3def45eb7.png)


# Space 1999 Adventure

Adventure game by "[Chema](http://isa.uniovi.es/~chema/)" (Jose Maria Enguita Gonzalez) based on "[Space 1999](https://en.wikipedia.org/wiki/Space:_1999)" TV series by Gerry and Sylvia Anderson, aired on 1975-1978.

Original adventure game was created in 2010 for 8-bit [Oric computers](https://en.wikipedia.org/wiki/Oric):
1) Download disk images (.dsk files) for Oricutron emulator here: [English](https://www.defence-force.org/files/space1999-en.zip), [French](https://www.defence-force.org/files/space1999-fr.zip) (785 KB each)
2) [Official page](https://www.defence-force.org/index.php?page=games&game=space1999)
3) [Sources on OSDN.net](https://osdn.net/projects/oricsdk/scm/svn/tree/head/public/oric/games/Space%201999/Sources/)
4) Oric emulator for Windows ("Oricutron") with Space1999 bundled as a .dsk file : [oricsdk-public_oric_games_Space201999-r1586.zip](https://osdn.net/projects/oricsdk/scm/svn/archive/head/public/oric/games/Space%201999/?format=zip) (3545816 bytes)
5) Oric emulator for browser, bundled with French version of SPACE 1999: [link](https://torguet.net/oric/)  (click on space1999-fr.dsk)
6) [Development discussion thread](https://forum.defence-force.org/viewtopic.php?t=135)

This repository holds the original source code for Oric, which include raw stuff (images and maps) which would allow porting the game to any platform. Oric version was build using wcmap.exe and wcgraph.exe . 

The game was started in 2004 by users "[Chema](https://forum.defence-force.org/memberlist.php?mode=viewprofile&u=21)" (Programming) "[Twilighte](https://forum.defence-force.org/memberlist.php?mode=viewprofile&u=4)" (Graphics) and "[Dbug](https://forum.defence-force.org/memberlist.php?mode=viewprofile&u=2)" (Intro sequence and trailer), which started [discussing about it on defence-force.org forum in 2006 ](https://forum.defence-force.org/viewtopic.php?t=135), and it waswritten using Windows tools NOISE (Novel Oric ISometric Engine) and WHITE (World Handling and Interaction with The Environment) by Chema, which you can find described [here](http://isa.uniovi.es/~chema/white+noise/intro.htm).

# Porting to "Tiled"

## Technical details

There are 114 rooms in the game, created with [map editor "WHITE"](https://www.defence-force.org/ftp/forum/isometric/space1999/):

- The map of the rooms is not contained into a specific file: the world map is inside a 16x16 grid, so going west/east means subtracting/adding 1 to room number, going north/south means subtracting/adding 16; pasing from one level to another requires use/implementation of "elevators"; images showing levels maps are available [here](https://github.com/jumpjack/Space1999Adventure/tree/main/resources)
- The names of the rooms are listed in  "[\Space 1999\Sources\game source\world\space1999.txt.lab](https://github.com/jumpjack/Space1999Adventure/blob/main/Sources/game%20source/world/space1999.txt.lab)"
- Eeach room is composed of "tiles" as described in file "[\Space 1999\Sources\game source\world\space1999.txt](https://github.com/jumpjack/Space1999Adventure/blob/main/Sources/game%20source/world/space1999.txt)"
    -  Example line: 4,8,0,COR_DOOR|SPECIAL
    - "INVERT" flag means a tile image has to be flipped horizontally
    - "SPECIAL" flag means the tile can be walked on, being it a door; all other tiles are blocking, i.e. collision must be enabled on them
- The names of each tile used to build each room are listed in "[\Space 1999\Sources\game source\world\tileset.txt](https://github.com/jumpjack/Space1999Adventure/blob/main/Sources/game%20source/world/tileset.txt)"

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



The different widths "confuse" Tiled, which expect all tiles to have same widths, so images set should be modified to have all tiles of same width = 24, so as to fit in a Tiled map which expects 24x12 tiles.


## Conversion

### Converting images

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


This batch script for DOS performs all the needed transformations to get single tiles with transparency; "masked" and "final" folders must be present in the working folder:

```
@echo off
setlocal enabledelayedexpansion
for /f "tokens=1,2,3" %%a in (tileset.txt) do (
  set tilename=%%a
  set imagefullname=%%b
  set maskfullname=%%c
  set imagebarename=!imagefullname:~0,-4!
  echo Checking maskfullname
    IF EXIST !maskfullname! (
    echo Masking !imagefullname! ...
      ..\convert !imagefullname! !maskfullname! -alpha Off -compose CopyOpacity -composite masked\!imagebarename!.png
    echo Enlarging newimages\!imagebarename!-masked.png ...
      ..\convert  masked\!imagebarename!.png  -background transparent -gravity west -extent 24x -format png final\!imagebarename!.png
    )
  )
endlocal
```

### Converting game map

[This HTML page](https://github.com/jumpjack/Space1999Adventure/blob/main/oric2tileset.html) converts original map from proprietary Oric/S1999 format to Tiled format


### Analysis of room 0

Raw data:

```
0,1,0,WALL|INVERT
0,2,0,WALL|INVERT
0,2,2,WINDOW|INVERT
0,3,0,RED|INVERT
0,4,0,WALL|INVERT
0,4,2,WINDOW|INVERT
0,5,0,RED|INVERT
0,6,0,WALL|INVERT
0,6,2,WINDOW|INVERT
0,7,0,WALL|INVERT
0,8,0,WALL|INVERT
1,0,0,WALL
1,1,0,PLANT|INVERT
1,7,0,SOFA_SW|INVERT
1,8,0,SOFA_SW|INVERT
1,9,0,INSET_CORNER
2,0,0,WALL
2,0,2,WINDOW
2,4,0,INFO
2,8,0,SOFA_SW|INVERT
2,9,0,INSET_WALL
3,0,0,WALL
3,0,2,WINDOW
3,1,0,SOFA_SW
3,9,0,INSETEDGE
4,0,0,WALL
4,0,2,WINDOW
4,1,0,SOFA_SW
4,3,0,SOFA_SW
4,4,0,SOFA_SW
4,4,1,SOFA_SW
4,5,0,SOFA_SW
4,8,0,COR_DOOR|SPECIAL
4,8,3,DOORJAMB
5,0,0,WALL
5,0,2,WINDOW
5,1,0,SOFA_SW
5,3,0,SOFA_SW
5,4,0,SOFA_SW
5,4,1,SOFA_SW
5,5,0,SOFA_SW
5,9,0,INSET_CORNER
6,0,0,WALL
6,0,2,WINDOW
6,3,0,SOFA_SW
6,4,0,SOFA_SW
6,4,1,SOFA_SW
6,5,0,SOFA_SW
6,8,0,SOFA_SW|INVERT
6,9,0,INSET_WALL
7,0,0,WALL
7,8,0,SOFA_SW
7,9,0,INSET_WALL
8,0,0,WALL
8,2,0,COR_DOOR|INVERT|SPECIAL
8,2,3,DOORJAMB|INVERT
8,7,0,COR_DOOR|INVERT|SPECIAL
8,7,3,DOORJAMB|INVERT
8,9,0,INSET_WALL
9,1,0,INSETEDGE|INVERT
9,3,0,INSET_CORNER|INVERT
9,4,0,INSET_WALL|INVERT
9,5,0,INSET_WALL|INVERT
9,6,0,INSETEDGE|INVERT
9,8,0,INSET_CORNER|INVERT
```

Only level 0, grouped by column:
```
0,1,0,WALL|INVERT
0,2,0,WALL|INVERT
0,3,0,RED|INVERT
0,4,0,WALL|INVERT
0,5,0,RED|INVERT
0,6,0,WALL|INVERT
0,7,0,WALL|INVERT
0,8,0,WALL|INVERT

1,0,0,WALL
1,1,0,PLANT|INVERT
1,7,0,SOFA_SW|INVERT
1,8,0,SOFA_SW|INVERT
1,9,0,INSET_CORNER

2,0,0,WALL
2,4,0,INFO
2,8,0,SOFA_SW|INVERT
2,9,0,INSET_WALL

3,0,0,WALL
3,0,2,WINDOW
3,1,0,SOFA_SW
3,9,0,INSETEDGE

4,0,0,WALL
4,1,0,SOFA_SW
4,3,0,SOFA_SW
4,4,0,SOFA_SW
4,5,0,SOFA_SW
4,8,0,COR_DOOR|SPECIAL
4,8,3,DOORJAMB

5,0,0,WALL
5,1,0,SOFA_SW
5,3,0,SOFA_SW
5,4,0,SOFA_SW
5,5,0,SOFA_SW
5,9,0,INSET_CORNER

6,0,0,WALL
6,3,0,SOFA_SW
6,4,0,SOFA_SW
6,5,0,SOFA_SW
6,8,0,SOFA_SW|INVERT
6,9,0,INSET_WALL

7,0,0,WALL
7,8,0,SOFA_SW
7,9,0,INSET_WALL

8,0,0,WALL
8,2,0,COR_DOOR|INVERT|SPECIAL
8,7,0,COR_DOOR|INVERT|SPECIAL
8,9,0,INSET_WALL

9,1,0,INSETEDGE|INVERT
9,3,0,INSET_CORNER|INVERT
9,4,0,INSET_WALL|INVERT
9,5,0,INSET_WALL|INVERT
9,6,0,INSETEDGE|INVERT
9,8,0,INSET_CORNER|INVERT
```

## Bugs
Original game sources have some minor bugs which could confuse automatic parsers:
- some stray TAB characters in tileset.txt
- some capital letters are used in one tile BMP file
- These tiles are available but never used:
    - LIFT1
    - SURGERY_DOOR1
    - COR_DOOR1
    - PASSCODE
- Tile "TRANSP_WALL" is used but image files are not available (Room 26, level 0; other rooms at other levels); this happens on purpose, because "transparent walls" are areas which cannot be traversed but allow viewing through them; in original developer words: "If a wall is not visible, but it is there (for example south and east walls if no lines in the floor are drawn) the special code (0 OR INVERTED -binary 10000000 and #defined as **TRANSP_WALL**-) is used.
- The computer... has a bug. "Computer" is made of tiles compA.bmp and compB.bmp, both masked by panelmask.bmp; but panelmask.bmp is actually smaller, so a part of compA.bmp and compB.bmp is not masked, resulting in stray lines in finale image; but these stray lines do not appear in actual game:

![image](https://user-images.githubusercontent.com/1620953/204099421-49535ba2-6d38-4ea3-ad9d-bfad9bbb0708.png)
