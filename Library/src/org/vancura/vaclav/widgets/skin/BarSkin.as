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
	import org.vancura.vaclav.widgets.interfaces.IBarSkin;

	public class BarSkin extends Skin implements IBarSkin {


		protected var _paddingTop:Number;
		protected var _paddingBottom:Number;
		protected var _paddingLeft:Number;
		protected var _paddingRight:Number;
		protected var _guideBD:BitmapData;
		protected var _backBD:BitmapData;

		private var _oldPaddingTop:Number;
		private var _oldPaddingBottom:Number;
		private var _oldPaddingLeft:Number;
		private var _oldPaddingRight:Number;



		public function BarSkin(id:String = null) {
			super(SkinType.BAR, id);

			_paddingTop = 0;
			_paddingBottom = 0;
			_paddingLeft = 0;
			_paddingRight = 0;

			_guideBD = new BitmapData(1, 1, true, 0x00000000);
			_backBD = new BitmapData(1, 1, true, 0x00000000);
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 2 != 0) throw new Error('Width has to be multiple of 2');

			_assetWidth = source.width / 2;
			_assetHeight = source.height;

			_guideBD = BitmapUtils.crop(source, 0, 0, _assetWidth, _assetHeight);
			_backBD = BitmapUtils.crop(source, _assetWidth, 0, _assetWidth, _assetHeight);
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			_getSkinSize(source, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);

			_backBD = _getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'back' : labels[0]);
			_guideBD = _getSkinFrame(source, elements, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldPaddingTop = _paddingTop;
			_oldPaddingBottom = _paddingBottom;
			_oldPaddingLeft = _paddingLeft;
			_oldPaddingRight = _paddingRight;

			if(source.paddingTop != undefined) _paddingTop = source.paddingTop;
			if(source.paddingBottom != undefined) _paddingBottom = source.paddingBottom;
			if(source.paddingLeft != undefined) _paddingLeft = source.paddingLeft;
			if(source.paddingRight != undefined) _paddingRight = source.paddingRight;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_paddingTop = _oldPaddingTop;
			_paddingBottom = _oldPaddingBottom;
			_paddingLeft = _oldPaddingLeft;
			_paddingRight = _oldPaddingRight;
		}



		public function get paddingTop():Number {
			return _paddingTop;
		}



		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		public function get paddingBottom():Number {
			return _paddingBottom;
		}



		public function set paddingBottom(value:Number):void {
			_paddingBottom = value;
		}



		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		public function get paddingRight():Number {
			return _paddingRight;
		}



		public function set paddingRight(value:Number):void {
			_paddingRight = value;
		}



		public function set guideBD(source:BitmapData):void {
			_checkSize(source);
			_guideBD = source;
		}



		public function get guideBD():BitmapData {
			return _guideBD;
		}



		public function set backBD(source:BitmapData):void {
			_checkSize(source);
			_backBD = source;
		}



		public function get backBD():BitmapData {
			return _backBD;
		}
	}
}
