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

Full conversion process is described [here](https://github.com/jumpjack/Space1999Adventure/wiki/Porting-game-map-to-Tiled-format).


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
