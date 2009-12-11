#!/bin/bash

# =====================
# = Customize me here =
# =====================

FLEX_DIR="/Developer/SDKs/FlexSDK34";
# Set to point to your Flex SDK directory

NATURAL_DOCS_DIR="/Developer/Applications/NaturalDocs";
# Set to point to your NaturalDocs installation directory

IS_NATURAL_DOCS_DISABLED="no";
# Disable NaturalDocs if you don't have it

IS_COMPILATION_DISABLED="no"
# Disable compilation if you need that

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
mkdir -p tmp >/dev/null 2>&1
mkdir -p lib/src >/dev/null 2>&1
mkdir -p lib/fonts >/dev/null 2>&1
mkdir -p lib/swc >/dev/null 2>&1
mkdir -p lib/src/quasimondo/src/com/quasimondo/geom >/dev/null 2>&1
mkdir -p lib/src/bytearray/src/org/bytearray/display >/dev/null 2>&1
mkdir -p bin >/dev/null 2>&1
mkdir -p doc >/dev/null 2>&1
mkdir -p .doc-config >/dev/null 2>&1

# Compile
if [ "$IS_COMPILATION_DISABLED" == "no" ]; then
	# Download my mDocs NaturalDocs style and all 3rd party libraries
	echo "---------------------------------------------------------------------------------------------------"
	echo "Downloading my mDocs NaturalDocs style and all 3rd party libraries"
	curl http://github.com/vancura/mdocs/raw/master/mdocs.css -o mdocs.css >/dev/null 2>&1
	curl http://www.greensock.com/as/greensock-tweening-platform-as3.zip -o tmp/greensock-tweening-platform-as3.zip >/dev/null 2>&1
	curl http://img.dafont.com/dl/?f=uni_05_x -o tmp/uni_05_x.zip >/dev/null 2>&1
	curl http://as3corelib.googlecode.com/files/as3corelib-.92.1.zip -o tmp/as3corelib.zip >/dev/null 2>&1
	curl http://www.quasimondo.com/colormatrix/ColorMatrix.as -o lib/src/quasimondo/src/com/quasimondo/geom/ColorMatrix.as >/dev/null 2>&1
	curl http://gist.github.com/raw/232800/642574cb739ea4fa4b9e8527d0c7d86e56334aaf/ScaleBitmap.as -o lib/src/bytearray/src/org/bytearray/display/ScaleBitmap.as >/dev/null 2>&1
	svn checkout http://printf-as3.googlecode.com/svn/trunk lib/src/printf-as3 >/dev/null 2>&1
	svn checkout http://vanrijkom-flashlibs.googlecode.com/svn/trunk lib/src/vanrijkom-flashlibs >/dev/null 2>&1

	# Unzip curled files
	echo "---------------------------------------------------------------------------------------------------"
	echo "Unzipping 3rd party libraries"
	unzip tmp/greensock-tweening-platform-as3.zip -d lib/src >/dev/null 2>&1
	unzip tmp/uni_05_x.zip -d lib/fonts >/dev/null 2>&1
	unzip -j tmp/as3corelib.zip as3corelib-.92.1/lib/as3corelib.swc -d lib/swc >/dev/null 2>&1
	
	# Delete colliding directories
	rm -rf lib/src/printf-as3/test-proj >/dev/null 2>&1
	
	# Compile vanrijkom-flashlibs.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling vanrijkom-flashlibs.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o lib/swc/vanrijkom-flashlibs.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp lib/src/vanrijkom-flashlibs -is lib/src/vanrijkom-flashlibs
	
	# Compile printf-as3.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling printf-as3.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o lib/swc/printf-as3.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp lib/src/printf-as3/src -is lib/src/printf-as3/src
	
	# Compile greensock-tweening-platform-as3.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling greensock-tweening-platform-as3.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o lib/swc/greensock-tweening-platform-as3.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp lib/src/greensock-tweening-platform-as3 -is lib/src/greensock-tweening-platform-as3
	
	# Compile quasimondo.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling quasimondo.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o lib/swc/quasimondo.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp lib/src/quasimondo/src -is lib/src/quasimondo/src
	
	# Compile bytearray.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling bytearray.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o lib/swc/bytearray.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp lib/src/bytearray/src -is lib/src/bytearray/src
	
	# Compile the SWC
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling vancura-as3-libs.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o bin/vancura-as3-libs.swc -l $FLEX_DIR/frameworks/libs/player/10/playerglobal.swc -l $FLEX_DIR/frameworks/libs/flex.swc  -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -is src -l lib/swc/vanrijkom-flashlibs.swc -l lib/swc/printf-as3.swc -l lib/swc/greensock-tweening-platform-as3.swc -l lib/swc/quasimondo.swc -l lib/swc/bytearray.swc -l lib/swc/as3corelib.swc
else
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compilation disabled"
fi

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
