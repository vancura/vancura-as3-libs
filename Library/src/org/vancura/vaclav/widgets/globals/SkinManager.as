/***********************************************************************************************************************
 * Some methods Copyrighted by their authors, specified in ASDocs.
 * If not specified elsewhere: Copyright (c) 2010 Vaclav Vancura.
 *
 * Contact me at vaclav@vancura.org, @vancura or at my homepage at http://vaclav.vancura.org.
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Licensed under Attribution 3.0 Czech Republic (http://creativecommons.org/licenses/by/3.0/cz/deed.en_GB).
 *
 * That means you are free:
 * * to copy, distribute, display, and perform the work
 * * to make derivative works
 *
 * Under the following conditions::
 * * Attribution Ñ You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver Ñ Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights Ñ In no way are any of the following rights affected by the license:
 * 	        - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

/**
 * TODO: Caching
 * TODO: Mergin with settings from FlashVar etc.
 * TODO: Theming
 * TODO: Better error handling
 */

package org.vancura.vaclav.widgets.globals {
	import flash.display.BitmapData;

	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.skin.BarSkin;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.skin.CheckButtonSkin;
	import org.vancura.vaclav.widgets.skin.ContainerSkin;
	import org.vancura.vaclav.widgets.skin.GlyphButtonSkin;
	import org.vancura.vaclav.widgets.skin.GlyphLabelButtonSkin;
	import org.vancura.vaclav.widgets.skin.ImageSkin;
	import org.vancura.vaclav.widgets.skin.InputBarSkin;
	import org.vancura.vaclav.widgets.skin.LabelButtonSkin;
	import org.vancura.vaclav.widgets.skin.LabelSkin;

	public class SkinManager {


		private static var _debugLevel:String = DebugLevel.NONE;
		private static var _debugColor:uint = 0xFF0000;


		//noinspection FunctionTooLongJS,FunctionWithMultipleReturnPointsJS,OverlyComplexFunctionJS
		public static function assetToSkin(asset:Asset):* {
			if(asset.config.widget == null) {
				throw new Error('Asset is null');
			}
			
			else {
				var skin:*;
				var isSupported:Boolean = true;
				var config:Object = asset.config.widget;

				switch(config.type) {
					case SkinType.CONTAINER:
						skin = new ContainerSkin();

						var containerSkin:ContainerSkin = skin as ContainerSkin;

						containerSkin.parseConfig(config);

						break;

					case SkinType.BAR:
						skin = new BarSkin();

						var barSkin:BarSkin = skin as BarSkin;
						var barSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

						barSkin.getAssetsFromAtlas(barSkinBD);
						barSkin.parseConfig(config);

						break;

					case SkinType.IMAGE:
						skin = new ImageSkin();

						var imageSkin:ImageSkin = skin as ImageSkin;
						var imageSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

						imageSkin.getAssetsFromAtlas(imageSkinBD);
						imageSkin.parseConfig(config);

						break;

					case SkinType.BUTTON:
						skin = new ButtonSkin();

						var buttonSkin:ButtonSkin = skin as ButtonSkin;
						var buttonSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

						buttonSkin.getAssetsFromAtlas(buttonSkinBD);
						buttonSkin.parseConfig(config);

						break;

					case SkinType.LABEL:
						skin = new LabelSkin();

						var labelSkin:LabelSkin = skin as LabelSkin;

						labelSkin.parseConfig(config);

						break;

					case SkinType.LABEL_BUTTON:
						skin = new LabelButtonSkin();

						var labelButtonSkin:LabelButtonSkin = skin as LabelButtonSkin;
						var labelButtonSkinBD:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;

						labelButtonSkin.buttonSkin.getAssetsFromAtlas(labelButtonSkinBD);
						labelButtonSkin.parseConfig(config);

						break;

					case SkinType.GLYPH_BUTTON:
						skin = new GlyphButtonSkin();

						var glyphButtonSkin:GlyphButtonSkin = skin as GlyphButtonSkin;
						var glyphButtonSkinBD1:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;
						var glyphButtonSkinBD2:BitmapData = asset.getChunkByURL(config.glyph.image).bitmap.bitmapData;

						glyphButtonSkin.buttonSkin.getAssetsFromAtlas(glyphButtonSkinBD1);
						glyphButtonSkin.glyphsSkin.getAssetsFromAtlas(glyphButtonSkinBD2);
						glyphButtonSkin.parseConfig(config);

						break;

					case SkinType.GLYPH_LABEL_BUTTON:
						skin = new GlyphLabelButtonSkin();

						var glyphLabelButtonSkin:GlyphLabelButtonSkin = skin as GlyphLabelButtonSkin;
						var glyphLabelButtonSkinBD1:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;
						var glyphLabelButtonSkinBD2:BitmapData = asset.getChunkByURL(config.glyph.image).bitmap.bitmapData;

						glyphLabelButtonSkin.buttonSkin.getAssetsFromAtlas(glyphLabelButtonSkinBD1);
						glyphLabelButtonSkin.glyphsSkin.getAssetsFromAtlas(glyphLabelButtonSkinBD2);
						glyphLabelButtonSkin.parseConfig(config);

						break;

					case SkinType.CHECK_BUTTON:
						skin = new CheckButtonSkin();

						var checkButtonSkin:CheckButtonSkin = skin as CheckButtonSkin;
						var checkButtonSkinBD1:BitmapData = asset.getChunkByURL(config.buttonOff.image).bitmap.bitmapData;
						var checkButtonSkinBD2:BitmapData = asset.getChunkByURL(config.buttonOn.image).bitmap.bitmapData;

						checkButtonSkin.buttonOffSkin.getAssetsFromAtlas(checkButtonSkinBD1);
						checkButtonSkin.buttonOnSkin.getAssetsFromAtlas(checkButtonSkinBD2);
						checkButtonSkin.parseConfig(config);

						break;

					case SkinType.INPUT_BAR:
						skin = new InputBarSkin();

						var inputBarSkin:InputBarSkin = skin as InputBarSkin;
						var inputBarSkinBD:BitmapData = asset.getChunkByURL(config.bar.image).bitmap.bitmapData;

						inputBarSkin.barSkin.getAssetsFromAtlas(inputBarSkinBD);
						inputBarSkin.parseConfig(config);

						break;

					default:
						//noinspection ReuseOfLocalVariableJS
						isSupported = false;
				}
			}

			if(isSupported) return skin;
			else return null;
		}



		public static function get debugLevel():String {
			return _debugLevel;
		}



		public static function set debugLevel(debugLevel:String):void {
			_debugLevel = debugLevel;
		}



		public static function get debugColor():uint {
			return _debugColor;
		}



		public static function set debugColor(debugColor:uint):void {
			_debugColor = debugColor;
		}
	}
}
