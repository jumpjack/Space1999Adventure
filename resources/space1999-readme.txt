=======================================
	     Space:1999
    	   The Oric Game
=======================================

version 1.00
February 2008

Email: enguita@gmail.com



INTRODUCTION
============

Here is the long-awaited (I hope) final (?) version of Space:1999
(codename "Out of Memory"),a new isometric Oric game based on the 
'70s TV series.

We have put a lot of effort into developing this game, and really
hope you like it.

This game (of course 100% asm code, built with the fabulous OSDK) is 
quite complex, and is using several advanced features (sector disk access
with no DOS, overlay ram, Sonix, compressed text,...) as well as a very 
complex isometric engine (I think it is the first real isometric game under
Oric, with masked sprites), which was designed to be general, so it is not 
optimized for this game. In fact NOISE (Novel Oric ISometric Engine) as 
well as the higher abstraction layer WHITE (World-Handling and
Interaction with The Environment) are designed to be used from C programs
and to provide a general isometric environment for developing games.

With this in mind, it is quite probable that there are several bugs lurking
around, even if the group of beta-testers did an explendid job.



PLAYING SPACE:1999
==================

Under the "User Manual" folder you have the user's manual (read it) both
as a single pdf file and as a set of pages in PNG format. That is in case
the pdf is very slow for being usable in your machine.

It also contains a set of maps of Moonbase Alpha. Consider that an 
additional clue, in case you find it hard to get oriented in the base.

If you want to print the maps, I would suggest to use your favourite paint 
program to invert the colors first (Microsoft Paint will do the job), to save
printer's ink!

To run the game, simply boot your Oric with the disc (virtually or physically). 
Sedoric will load and launch the intro first. Watch it. When it ends the system
is rebooted and the game will launch. You can skip it by pressing ESC, but it is
so beautiful that who would ever want to skip it?

If you do not hard-reset your Oric, subsequent reboots (F6 in Euphoric) will 
launch the game directly.

The game runs on any Atmos+Microdisc. It may run in other configurations too as
long as the disk is compatible with Microdisc. However most probable is that
the intro needs an Atmos rom. 

I have found that sound is quite worse when run under Euphoric and win XP,
(at least in my laptop) than when using VirtualPC+DOS and Euphoric. 
Don't know with other configurations.



I have been playing the beta 0.99 and have my saved game on disk!
=================================================================

Well, if you want to still use your old savepoint there is a trick that *might* work.

Just proceed as normally for restoring a saved game in version 1.00, but *before* 
pressing CTRL to proceed swap the disk and put your 0.99 disk in the drive. If everything
is correct, swap disks again and proceed to save your game again, now into the 1.00 disk.
Voilá! It should work, though I did not test it. You have been warned.

Of course you can use this trick to keep different savepoints in several disks ;)



Why is the codename "Out of Memory"?
====================================

At first it summarized the whole original idea of the plot, while was also an Oric's 
error message. However things evolved differently and it no more reflects what the
game is about.

Anyway at a certain point in the development the sentence became true again. Just when
we saw we needed to use overlay ram and disk access. So I think it is OK to keep it.



Acknowledgments
===============

Most code was done by me (Chema). Twilighte provided the wonderful graphics
and astonishing music and sfx, and many key routines. Dbug helped a lot in
the development and coded the wonderful intro.

Both scenes in the intro which lay down the story (between the "This episode"
letterings) were converted by Sam Hocevar, who recently developed a tool
called img2oric (have a look at http://libcaca.zoy.org/labs/img2oric.html) .

Thanks indeed to Maximus, who made the French translation and patiently beta-tested
the program along with Waskol, who also provided taptap, a tool used to correctly
name files on disk. 

Of course zillions of thanks to Fabrice Frances. Not only for the wonderful Euphoric,
but also for providing feedback on the program and (very) tech insights, who helped me to
solve some hideous problems. He also provided me with the sector-based disk access routines.

I cannot forget the wonderful people of the forums at www.defence-force.org 
(http://www.defence-force.org/phpBB2/index.php) and www.oricgames.com.

Also thanks to everyone that helped in one way or another in the development of this
game and who keep this machine alive.



Some details for the tech people
================================

** Normal Memory usage:

Used memory from $400 and upwards, including pages zero and 2.
NOISE: 5791
WHITE: 3044
Pics of characters & objects that you can take/drop: 4920 bytes
Inventory item pics: 672 bytes
Background pics (tiles): 10390 bytes (62 different tiles)
Compressed text in English version: 3725 bytes (ratio of over 40-45%)

Free space in normal memory: 1001 bytes

** Overlay Ram usage:

Map file: 9722 bytes (114 rooms)
Music & sfx: 3997 bytes

Free space: 1960 bytes



Reporting bugs & comments
=========================

Any thoughts, comments, questions, bugs or whatever, are more than
welcome. Post them in the Oric Forums or email me at
enguita@gmail.com





Happy playing!!!


-- The development team: Twilighte, Dbug and Chema
