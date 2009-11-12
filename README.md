# vancura-as3-libs

My set of classes. Read the docs here: [here](http://doc.vaclav.vancura.org/vancura-as3-libs).



## Features

Currently these features are covered:

### Core functions

* [MorphSprite class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/MorphSprite-as.html)
* [QBitmap class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/QBitmap-as.html)
* [QSprite class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/QSprite-as.html)
* [QTextField class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/QTextField-as.html)
* [QVideo class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/QVideo-as.html)
* [Stats class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/Stats-as.html)
* [FPS class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/FPS-as.html)
* [GlobalStage class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/GlobalStage-as.html)
* [ModalWindow class](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/ModalWindow-as.html)
* [Drawing()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/Drawing-as.html)
* [Bitmapping()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/Bitmapping-as.html)
* [addChildren()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/addChildren-as.html)
* [removeChildren()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/removeChildren-as.html)
* [duplicateMovieClip()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/duplicateMovieClip-as.html)
* [addEventListeners()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/addEventListeners-as.html)
* [removeEventListeners()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/removeEventListeners-as.html)
* [assign()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/assign-as.html)
* [clone()](http://doc.vaclav.vancura.org/vancura-as3-libs/files/org/vancura/vaclav/core/clone-as.html)


### Easy [Far](http://code.google.com/p/vanrijkom-flashlibs/wiki/FAR) wrapper:

* Far
* FarHelperItem

More features coming soon: **skinnable widgets**, **remoting** and more. Watch my [blog](http://vaclav.vancura.org/blog) for more information.


## How to get the SWC

There are several ways to get the library for use in your project.

### Binary distribution

In case you're lazy or you don't have all required components to compile it on your machine, you can grab the SWC [here](http://github.com/vancura/vancura-as3-libs/blob/master/bin/vancura-as3-libs.swc).

### Compilation from source

You can compile the SWC very easily. In simple words you just need to launch **./compile.sh** file. I wrote it on OSX, but it should work fine on a Linux machine as well. The only issue, actually, is the Windows machine. Since I don't have access to any Windows installation around here, you have to figure out how to compile it. Just take a look at the compile.sh file and you'll see what's going on there.

The library uses several 3rd party components:
* [Greensock Tweening Platform](http://tweenmax.com) (known as TweenNano, TweenLite and TweenMax)
* [Printf-AS3](http://code.google.com/p/printf-as3), an article [here](http://www.stimuli.com.br/trane/2009/feb/21/printf-as3).
* [Vanrijkom Flashlibs](http://code.google.com/p/vanrijkom-flashlibs)
* [Quasimondo ColorMatrix class](http://www.quasimondo.com/colormatrix/ColorMatrix.as)
* [Uni fonts](http://www.dafont.com/search.php?psize=m&q=uni_05_x) by [miniml.com](http://miniml.com)

All these files are downloaded from internet and not included in the source package. Hence you'll get the most up-to-date SWC if you compile.

Of course you need [Adobe Flex SDK](http://www.adobe.com/products/flex). In my **compile.sh** script I use [FlexSDK4 beta](http://opensource.adobe.com/wiki/display/flexsdk/Download+Flex+4), which is not out yet, but works pretty well for me.



## License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



## Contact

Contact me at [vaclav@vancura.org](mailto:vaclav@vancura.org) or see my homepage at [vaclav.vancura.org](http://vaclav.vancura.org)

