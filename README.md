# PROJECT IS MOVED

This project is moved to [Cj-bc/brick-shgif](https://github.com/Cj-bc/brick-shgif) and changed to Haskell.
Please visit there.

---

# Shgif -- shell-gif

shgif is one of the simplest gif-like player made by ASCIIs

# description

## Shgif is:

  * a Gif-like animation player for `.shgif` file
  * ASCII animation

## Shgif is not:

  * a real-gif player
  * no-gif supported

# installation

you can use homebrew and bpkg[WIP] to install `shgif`:

```bash
$ brew tap Cj-bc/shgif
$ brew install shgif
```

```bash
$ bpkg install -g Cj-bc/shgif
```

`bpkg` support is in progress...


## dependencies

| name | description |
|:-:|:-:|
| [Cj-bc/blib](https://github.com/Cj-bc/blib)       | a bash library manager |
| [Cj-bc/libtar](https://github.com/Cj-bc/libtar)   | treat tar unpack/pack  |
| [Cj-bc/libfile](https://github.com/Cj-bc/libfile) | parse files into array |

# usage

```bash
# start paying shgif.
# this should have `src` folder on the same directory as `.shgif` file
shgif <yourshgif.shgif>
# start playing shgif with tar/tar.gz
shgif <yourshgif.tar>
shgif <youshgif.tar.gz>
```


# file structure

You should have this directory structure:

```
projectFile/projectFile.shgif
           /src             /yourAAfile.txt
                            /color         /yourAAfile.txt
```

where:

| | |
|:-:|:-:|
| projectFile | the root directory for the project |
| projectFile.shgif | config file to define how shgif move |
| src | where your AAs are put |
| yourAAfile.txt | your shgif source file |
| color | where your color layer for each src are put |
| color/yourAAfile.txt | color layer of 'yourAAfile.txt' |


# how to write color layer

You should write color layer for each src file for now.
(I'll try to remove this)

the *color layer* is the file where you can define color for each src.
It based on src file, but some feature are added to support color.

## how it work

Mainly, it works by defining alias to color.
Set the pair of alias and color number at first.
then, specify the color to each char using them.

## 1. Add 2 lines before src

The first/second line in color layer define the pair of color and keyword.

* First line: setting for foreground color
* Second line: setting for background color

*Note*: you can use `blink`/`bold` keywords in both lines.
        When you use this, the specified characters will be blink/bold.

```
r=10,n=blink
B=231,W=235
```

Above code sets 'B' to 'background:
