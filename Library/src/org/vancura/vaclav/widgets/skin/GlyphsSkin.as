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

package org.vancura.vaclav.widgets.skin {
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	import org.vancura.vaclav.core.utils.BitmapUtils;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IGlyphsSkin;
	import org.vancura.vaclav.widgets.interfaces.IImageSkin;

	public class GlyphsSkin extends Skin implements IGlyphsSkin {


		protected var _glyphOutSkin:IImageSkin;
		protected var _glyphHoverSkin:IImageSkin;
		protected var _glyphFocusSkin:IImageSkin;



		public function GlyphsSkin(id:String = null) {
			super(SkinType.GLYPHS, id);

			_glyphOutSkin = new ImageSkin(id + '#glyphOut');
			_glyphHoverSkin = new ImageSkin(id + '#glyphHover');
			_glyphFocusSkin = new ImageSkin(id + '#glyphFocus');
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 3 != 0) throw new Error('Width has to be multiple of 3');

			_assetWidth = source.width / 3;
			_assetHeight = source.height;

			var outBD:BitmapData = BitmapUtils.crop(source, 0, 0, _assetWidth, _assetHeight);
			var overBD:BitmapData = BitmapUtils.crop(source, _assetWidth, 0, _assetWidth, _assetHeight);
			var focusBD:BitmapData = BitmapUtils.crop(source, _assetWidth * 2, 0, _assetWidth, _assetHeight);

			_glyphOutSkin.getAssetsFromAtlas(outBD);
			_glyphHoverSkin.getAssetsFromAtlas(overBD);
			_glyphFocusSkin.getAssetsFromAtlas(focusBD);
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ...labels:Array):void {
			_getSkinSize(source, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);

			_glyphOutSkin.getAssetsFromMovieClip(source, elements, 'out');
			_glyphHoverSkin.getAssetsFromMovieClip(source, elements, 'hover');
			_glyphFocusSkin.getAssetsFromMovieClip(source, elements, 'focus');
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
		}



		override public function revertConfig():void {
			super.revertConfig();

			_glyphOutSkin.revertConfig();
			_glyphHoverSkin.revertConfig();
			_glyphFocusSkin.revertConfig();
		}



		public function get glyphOutSkin():IImageSkin {
			return _glyphOutSkin;
		}



		public function set glyphOutSkin(source:IImageSkin):void {
			_glyphOutSkin = source;
		}



		public function get glyphHoverSkin():IImageSkin {
			return _glyphHoverSkin;
		}



		public function set glyphHoverSkin(source:IImageSkin):void {
			_glyphHoverSkin = source;
		}



		public function get glyphFocusSkin():IImageSkin {
			return _glyphFocusSkin;
		}



		public function set glyphFocusSkin(source:IImageSkin):void {
			_glyphFocusSkin = source;
		}
	}
}
