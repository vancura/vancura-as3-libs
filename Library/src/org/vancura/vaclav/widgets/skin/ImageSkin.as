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

	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IImageSkin;

	public class ImageSkin extends Skin implements IImageSkin {


		protected var _paddingTop:Number;
		protected var _paddingLeft:Number;
		protected var _imageBD:BitmapData;

		private var _oldPaddingTop:Number;
		private var _oldPaddingLeft:Number;



		public function ImageSkin(id:String = null) {
			super(SkinType.IMAGE, id);

			_paddingTop = 0;
			_paddingLeft = 0;

			_imageBD = new BitmapData(1, 1, true, 0x00000000);
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			_assetWidth = source.width;
			_assetHeight = source.height;

			_imageBD = source;
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			_getSkinSize(source, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);

			_imageBD = _getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'image' : labels[0]);
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldPaddingTop = _paddingTop;
			_oldPaddingLeft = _paddingLeft;

			if(source.paddingTop != undefined) _paddingTop = source.paddingTop;
			if(source.paddingLeft != undefined) _paddingLeft = source.paddingLeft;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_paddingTop = _oldPaddingTop;
			_paddingLeft = _oldPaddingLeft;
		}



		public function get paddingTop():Number {
			return _paddingTop;
		}



		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		public function set imageBD(source:BitmapData):void {
			_checkSize(source);
			_imageBD = source;
		}



		public function get imageBD():BitmapData {
			return _imageBD;
		}
	}
}
