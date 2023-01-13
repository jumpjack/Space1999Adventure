# Porting to Adventure Game Studio

## Notes

Current status of my attempt to implement isometric game in AGS:

- Room building: to flip a tile:
    -  temporarily store the tile into a dynamic sprite: `DynamicSprite* flipped = DynamicSprite.CreateFromExistingSprite(tileId,  true); ` 
    - flip the sprite: `flipped.Flip(eFlipLeftToRight);`
    - assign sprite to an overlay; NOTE: you must put "clone" option to "true": `roomOverlay[overlayIndex] = Overlay.CreateRoomGraphical(screenx - tilewidth/2, screeny - 2*tileheight + YFACT,  flipped.Graphic,  0,  true);`
- Occlusions: use overlays, assigning to Zorder properties the sum of X and Y isometric coordinates: `roomOverlay[overlayIndex].ZOrder = (isoX + isoY + 1)*6 + YFACT`  ( 6 is half tile height; YFACT is y offset of the graphic in the room)
- Collisions: 
    - rather than drawing walkable areas, it's better to make whole room walkable and "drill" nonwalkable areas for each tile;
    - it's better to extend downwards by some pixels the nonwalkable areas, to prevent the effect of "walking over furniture".
 
To "drill" the walkable areas:

      int x1 = screenx;                           int y1 = screeny + YFACT;
      int x2 = screenx + tilewidth/2;             int y2 = screeny + tileheight/2 + YFACT + YMARGIN/2;
      int x3 = screenx - tilewidth/2;             int y3 = screeny + tileheight/2 + YFACT + YMARGIN/2;

      int x4 = x2; int y4 = y2 + YMARGIN/2; 
      int x5 = x3; int y5 = y3 + YMARGIN/2; 
      int x6 = screenx;                           int y6 = screeny + tileheight + YFACT + YMARGIN;
      
      ///// drill nonwalkable holes in walkable area:
      walk.DrawTriangle(x1, y1,   x2, y2,   x3, y3);
      walk.DrawRectangle(x3,  y3,    x4,  y4);
      walk.DrawTriangle(x4, y4,   x5, y5,   x6, y6);

"YFACT" is vertical offset of tiles in the screen area;
"YMARGIN" is the extent of additional vertical space of walkable tiles.


Visible room:

![image](https://user-images.githubusercontent.com/1620953/211496551-4e1ab9ab-f584-49da-b5ba-c55926f2f0b6.png)

Walkable/nonwalkable aeras:

![image](https://user-images.githubusercontent.com/1620953/211496644-742be2ed-c4d6-46d9-87f6-03f554f2fb89.png)

![image](https://user-images.githubusercontent.com/1620953/211497263-0277c7a5-f598-4cd3-9abe-93a0acb066e3.png)


Additional vertical space in the walkable areas prevents character from appearing walking over tiles if walking too close, because only the lowest center pixel is used to check for nonwalkable areas collisions.

With additional space:

![image](https://user-images.githubusercontent.com/1620953/211497764-73227855-87cb-4eed-8f44-3ea3b65f3e5a.png)

![image](https://user-images.githubusercontent.com/1620953/211498035-855a7a02-02df-4775-84bd-00bbce92a1a0.png)


Without addditional space:

![image](https://user-images.githubusercontent.com/1620953/211499180-567787d6-dc17-48ca-8ef7-7b0092d88d1c.png)


![image](https://user-images.githubusercontent.com/1620953/211498333-09c48f5f-4f67-46dd-ba13-86ade0697a35.png)





### Tiles drawing order

First attempt:

Each layer is drawn, each tile is assigned a Zorder depending on its position on screen:

![image](https://user-images.githubusercontent.com/1620953/212273735-2abea83b-2adb-4b4d-9a7a-fcb70ee6e660.png)

![image](https://user-images.githubusercontent.com/1620953/212276264-145f0b3b-439c-4cb8-856b-a33cef7430e5.png)


It causes flickering of tiles on layer>0, probably because the draw order is actually undefined, having all objects on same tile same Zorder value:

![image](https://user-images.githubusercontent.com/1620953/212277014-d7e9c45a-e0c7-4087-807a-134fc37cc431.png)


Second attempt:

The numbers are the "order of appearance" as the tiles are drawn:

![image](https://user-images.githubusercontent.com/1620953/212278119-c58aab52-2b07-42ce-9da5-f99e2136ec4c.png)


Each group of 4 stacked tiles should be then assigned to a single overlay with a single Zorder:

![image](https://user-images.githubusercontent.com/1620953/212275368-18a5eb4d-df07-4f04-a4b3-b8ca50f7e747.png)

