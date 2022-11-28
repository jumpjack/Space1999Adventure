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
