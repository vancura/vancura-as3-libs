#!/bin/bash

# =====================
# = Customize me here =
# =====================

IS_DOCS_DISABLED="no"
IS_SWF_DISABLED="no"
IS_EXAMPLES_DISABLED="no"

FLEX_DIR="/Developer/SDKs/FlexSDK34"
VISDOC_BIN="/Developer/Applications/VisDoc/VisDoc.app/Contents/MacOS/VisDoc"

# ========================
# = End of customization =
# ========================



# ==================
# = Initialization =
# ==================

# Fix DTerm current directory problem
cd "`dirname "$0"`"

# Prepare all directories
echo "---------------------------------------------------------------------------------------------------"
echo "Creating directories"

rm -rf tmp >/dev/null 2>&1
rm -rf Library/lib >/dev/null 2>&1
rm -rf Tools >/dev/null 2>&1
rm -rf Examples/bin 2>&1
rm -rf Examples/tools 2>&1

mkdir -p tmp >/dev/null 2>&1
mkdir -p Library/lib/src >/dev/null 2>&1
mkdir -p Library/lib/fonts >/dev/null 2>&1
mkdir -p Library/lib/swc >/dev/null 2>&1
mkdir -p Library/lib/src/quasimondo/src/com/quasimondo/geom >/dev/null 2>&1
mkdir -p Library/lib/src/destroytoday/src/com/destroytoday/display >/dev/null 2>&1
mkdir -p Examples/bin >/dev/null 2>&1
mkdir -p Examples/tools >/dev/null 2>&1
mkdir -p Library/swc >/dev/null 2>&1
mkdir -p Docs >/dev/null 2>&1


# ===============
# = Compilation =
# ===============

if [ "$IS_SWF_DISABLED" == "no" ]; then
	
	# Download 3rd party libraries
	echo "---------------------------------------------------------------------------------------------------"
	echo "Downloading 3rd party libraries"
	curl http://www.greensock.com/as/greensock-tweening-platform-as3.zip -o tmp/greensock-tweening-platform-as3.zip >/dev/null 2>&1
	curl http://img.dafont.com/dl/?f=uni_05_x -o tmp/uni_05_x.zip >/dev/null 2>&1
	curl http://as3corelib.googlecode.com/files/as3corelib-.92.1.zip -o tmp/as3corelib.zip >/dev/null 2>&1
	curl http://www.quasimondo.com/colormatrix/ColorMatrix.as -o Library/lib/src/quasimondo/src/com/quasimondo/geom/ColorMatrix.as >/dev/null 2>&1
	curl http://github.com/vancura/DestroyFramework/raw/master/src/com/destroytoday/display/Scale9Bitmap.as -o Library/lib/src/destroytoday/src/com/destroytoday/display/Scale9Bitmap.as >/dev/null 2>&1
	svn checkout http://vanrijkom-flashlibs.googlecode.com/svn/trunk Library/lib/src/vanrijkom-flashlibs >/dev/null 2>&1
	
	# Unzip curled files
	echo "---------------------------------------------------------------------------------------------------"
	echo "Unzipping 3rd party libraries"
	unzip tmp/greensock-tweening-platform-as3.zip -d Library/lib/src >/dev/null 2>&1
	unzip tmp/uni_05_x.zip -d Library/lib/fonts >/dev/null 2>&1
	unzip -j tmp/as3corelib.zip as3corelib-.92.1/lib/as3corelib.swc -d Library/lib/swc >/dev/null 2>&1
	
	# Delete colliding directories
	rm -rf Library/lib/src/printf-as3/test-proj >/dev/null 2>&1
	
	# Compile vanrijkom-flashlibs.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling vanrijkom-flashlibs.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o Library/lib/swc/vanrijkom-flashlibs.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp Library/lib/src/vanrijkom-flashlibs -is Library/lib/src/vanrijkom-flashlibs
	
	# Compile greensock-tweening-platform-as3.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling greensock-tweening-platform-as3.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o Library/lib/swc/greensock-tweening-platform-as3.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp Library/lib/src/greensock-tweening-platform-as3 -is Library/lib/src/greensock-tweening-platform-as3
	
	# Compile quasimondo.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling quasimondo.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o Library/lib/swc/quasimondo.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp Library/lib/src/quasimondo/src -is Library/lib/src/quasimondo/src
	
	# Compile destroytoday.swc
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling destroytoday.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o Library/lib/swc/destroytoday.swc -l $FLEX_DIR/frameworks/libs/air/airframework.swc -l $FLEX_DIR/frameworks/libs/air/airglobal.swc -l $FLEX_DIR/frameworks/libs/air/applicationupdater_ui.swc -l $FLEX_DIR/frameworks/libs/air/servicemonitor.swc -l $FLEX_DIR/frameworks/libs/flex.swc -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -sp Library/lib/src/destroytoday/src -is Library/lib/src/destroytoday/src
	
	# Compile the SWC
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling vancura-as3-libs.swc"
	$FLEX_DIR/bin/compc --target-player=10.0.0 -o Library/swc/vancura-as3-libs.swc -l $FLEX_DIR/frameworks/libs/player/10/playerglobal.swc -l $FLEX_DIR/frameworks/libs/flex.swc  -l $FLEX_DIR/frameworks/libs/framework.swc -l $FLEX_DIR/frameworks/libs/rpc.swc -l $FLEX_DIR/frameworks/libs/utilities.swc -is Library/src -l Library/lib/swc/vanrijkom-flashlibs.swc -l Library/lib/swc/greensock-tweening-platform-as3.swc -l Library/lib/swc/quasimondo.swc -l Library/lib/swc/destroytoday.swc -l Library/lib/swc/as3corelib.swc

else

	echo "---------------------------------------------------------------------------------------------------"
	echo "Compilation disabled"

fi



# ==========================
# = Generate documentation =
# ==========================

if [ "$IS_DOCS_DISABLED" == "no" ]; then

	echo "---------------------------------------------------------------------------------------------------"
	echo "Generating documentation in Docs"
	$VISDOC_BIN -listPrivate 1 -includeSourceCode 1 -generateIndex 1 -indexTitle "vancura-as3-libs" -process Library/src -out Docs
	echo "---------------------------------------------------------------------------------------------------"
	echo "Documentation done"

else

	echo "---------------------------------------------------------------------------------------------------"
	echo "Documentation generation disabled"

fi



# ============
# = Examples =
# ============

if [ "$IS_EXAMPLES_DISABLED" == "no" ]; then
	
	# Download FAR tool
	echo "---------------------------------------------------------------------------------------------------"
	echo "Downloading FAR tool"
	curl http://vanrijkom-flashlibs.googlecode.com/files/far_beta_0.1.r1.zip -o tmp/far.zip >/dev/null 2>&1

	# Unzip curled files
	echo "---------------------------------------------------------------------------------------------------"
	echo "Unzipping FAR tool"
	unzip -j tmp/far.zip far/bin/osx/far -d Examples/tools >/dev/null 2>&1
	
	# Compile FARs
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling example FARs"
	cd examples/skins/skin-far-src
	../../tools/far -m test-skin.xml >/dev/null 2>&1
	
	# Compile examples
	echo "---------------------------------------------------------------------------------------------------"
	echo "Compiling examples"
	cd ../..
	$FLEX_DIR/bin/mxmlc -o bin/LoadTest.swf -l+=../Library/lib/swc -sp src -sp ../Library/src --target-player=10.0.0 -debug=false -optimize=true -- src/LoadTest.as
	
else
	
	echo "---------------------------------------------------------------------------------------------------"
	echo "Examples disabled"

fi



# ===========
# = Cleanup =
# ===========

rm -rf tmp



# ========
# = Done =
# ========

echo "---------------------------------------------------------------------------------------------------"
echo "All operations done. Enjoy vancura-as3-libs.swc."
echo "Feel free to contact me at vaclav@vancura.org or my homepage at http://vaclav.vancura.org."
