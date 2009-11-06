#!/bin/bash

# =====================
# = Customize me here =
# =====================

FLEX_DIR="/Developer/SDKs/FlexSDK4";
# Set $flex_dir to point to your Flex SDK directory

NATURAL_DOCS_DIR="/Developer/Applications/NaturalDocs";
# Set $natural_docs_dir to point to your NaturalDocs installation directory

IS_NATURAL_DOCS_DISABLED="no";
# Disable NaturalDocs if you don't have it

# ========================
# = End of customization =
# ========================



# Fix DTerm current directory problem
cd "`dirname "$0"`"

# Prepare all directories
echo "---------------------------------------------------------------------------------------------------"
echo "Making directories"
rm -rf tmp >/dev/null 2>&1
rm -rf lib >/dev/null 2>&1
mkdir tmp >/dev/null 2>&1
mkdir lib >/dev/null 2>&1
mkdir lib/src >/dev/null 2>&1
mkdir lib/fonts >/dev/null 2>&1
mkdir bin >/dev/null 2>&1
mkdir doc >/dev/null 2>&1
mkdir .doc-config >/dev/null 2>&1

# Download my mDocs NaturalDocs style and all 3rd party libraries
echo "---------------------------------------------------------------------------------------------------"
echo "Downloading my mDocs NaturalDocs style and all 3rd party libraries"
curl http://github.com/vancura/mdocs/raw/master/mdocs.css -o mdocs.css >/dev/null 2>&1
curl http://www.greensock.com/as/greensock-tweening-platform-as3.zip -o tmp/greensock-tweening-platform-as3.zip >/dev/null 2>&1
curl http://img.dafont.com/dl/?f=uni_05_x -o tmp/uni_05_x.zip >/dev/null 2>&1
svn checkout http://printf-as3.googlecode.com/svn/trunk lib/src/printf-as3 >/dev/null 2>&1
svn checkout http://vanrijkom-flashlibs.googlecode.com/svn/trunk lib/src/vanrijkom-flashlibs >/dev/null 2>&1

# Unzip curled files
echo "---------------------------------------------------------------------------------------------------"
echo "Unzipping 3rd party libraries"
unzip tmp/greensock-tweening-platform-as3.zip -d lib/src >/dev/null 2>&1
unzip tmp/uni_05_x.zip -d lib/fonts >/dev/null 2>&1

# Compile the SWC
echo "---------------------------------------------------------------------------------------------------"
echo "Compiling vancura-as3-libs.swc"
$FLEX_DIR/bin/compc --target-player=10.0.0 -o bin/vancura-as3-libs.swc -l $FLEX_DIR/frameworks/libs/player/10/playerglobal.swc -l $FLEX_DIR/frameworks/libs/flex.swc  -l $FLEX_DIR/frameworks/libs/framework.swc  -l $FLEX_DIR/frameworks/libs/rpc.swc  -l $FLEX_DIR/frameworks/libs/utilities.swc -is src -sp lib/src/vanrijkom-flashlibs -sp lib/src/printf-as3/src -sp lib/src/greensock-tweening-platform-as3

# Generate documentation
if [ "$IS_NATURAL_DOCS_DISABLED" == "no" ]; then
	echo "---------------------------------------------------------------------------------------------------"
	echo "Generating documentation in ./doc"
	$NATURAL_DOCS_DIR/NaturalDocs -i src -o HTML doc -p .doc-config -s mDocs -do
	echo "---------------------------------------------------------------------------------------------------"
	echo "Documentation done"
else
	echo "---------------------------------------------------------------------------------------------------"
	echo "Documentation generation disabled"
fi

# Cleanup
rm -rf tmp

# Done
echo "---------------------------------------------------------------------------------------------------"
echo "All operations done. Enjoy vancura-as3-libs.swc."
echo "Feel free to contact me at vaclav@vancura.org or my homepage at http://vaclav.vancura.org."
