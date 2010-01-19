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
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;

	public class ButtonSkin extends Skin implements IButtonSkin {


		protected var _hoverInDuration:Number;
		protected var _hoverOutDuration:Number;
		protected var _focusInDuration:Number;
		protected var _focusOutDuration:Number;
		protected var _guideBD:BitmapData;
		protected var _outBD:BitmapData;
		protected var _hoverBD:BitmapData;
		protected var _focusBD:BitmapData;

		private var _oldHoverInDuration:Number;
		private var _oldHoverOutDuration:Number;
		private var _oldFocusInDuration:Number;
		private var _oldFocusOutDuration:Number;



		public function ButtonSkin(id:String = null) {
			super(SkinType.BUTTON, id);

			_hoverInDuration = 0;
			_hoverOutDuration = 0.15;
			_focusInDuration = 0;
			_focusOutDuration = 0.1;

			_guideBD = new BitmapData(1, 1, true, 0x00000000);
			_outBD = new BitmapData(1, 1, true, 0x00000000);
			_hoverBD = new BitmapData(1, 1, true, 0x00000000);
			_focusBD = new BitmapData(1, 1, true, 0x00000000);
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 4 != 0) throw new Error('Width has to be multiple of 4');

			_assetWidth = source.width / 4;
			_assetHeight = source.height;

			_guideBD = BitmapUtils.crop(source, 0, 0, _assetWidth, _assetHeight);
			_outBD = BitmapUtils.crop(source, _assetWidth, 0, _assetWidth, _assetHeight);
			_hoverBD = BitmapUtils.crop(source, _assetWidth * 2, 0, _assetWidth, _assetHeight);
			_focusBD = BitmapUtils.crop(source, _assetWidth * 3, 0, _assetWidth, _assetHeight);
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			_getSkinSize(source, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);

			_outBD = _getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'out' : labels[0]);
			_hoverBD = _getSkinFrame(source, elements, (labels[1] == undefined || labels[1] == '') ? 'hover' : labels[1]);
			_focusBD = _getSkinFrame(source, elements, (labels[2] == undefined || labels[2] == '') ? 'focus' : labels[2]);
			_guideBD = _getSkinFrame(source, elements, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldHoverInDuration = _hoverInDuration;
			_oldHoverOutDuration = _hoverOutDuration;
			_oldFocusInDuration = _focusInDuration;
			_oldFocusOutDuration = _focusOutDuration;

			if(source.hoverInDuration != undefined) _hoverInDuration = source.hoverInDuration;
			if(source.hoverOutDuration != undefined) _hoverOutDuration = source.hoverOutDuration;
			if(source.pressInDuration != undefined) _focusInDuration = source.pressInDuration;
			if(source.pressOutDuration != undefined) _focusOutDuration = source.pressOutDuration;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_hoverInDuration = _oldHoverInDuration;
			_hoverOutDuration = _oldHoverOutDuration;
			_focusInDuration = _oldFocusInDuration;
			_focusOutDuration = _oldFocusOutDuration;
		}



		public function set hoverInDuration(value:Number):void {
			_hoverInDuration = value;
		}



		public function get hoverInDuration():Number {
			return _hoverInDuration;
		}



		public function set hoverOutDuration(value:Number):void {
			_hoverOutDuration = value;
		}



		public function get hoverOutDuration():Number {
			return _hoverOutDuration;
		}



		public function set focusInDuration(value:Number):void {
			_focusInDuration = value;
		}



		public function get focusInDuration():Number {
			return _focusInDuration;
		}



		public function set focusOutDuration(value:Number):void {
			_focusOutDuration = value;
		}



		public function get focusOutDuration():Number {
			return _focusOutDuration;
		}



		public function set outBD(source:BitmapData):void {
			_checkSize(source);
			_outBD = source;
		}



		public function get outBD():BitmapData {
			return _outBD;
		}



		public function set hoverBD(source:BitmapData):void {
			_checkSize(source);
			_hoverBD = source;
		}



		public function get hoverBD():BitmapData {
			return _hoverBD;
		}



		public function set focusBD(source:BitmapData):void {
			_checkSize(source);
			_focusBD = source;
		}



		public function get focusBD():BitmapData {
			return _focusBD;
		}



		public function set guideBD(source:BitmapData):void {
			_checkSize(source);
			_guideBD = source;
		}



		public function get guideBD():BitmapData {
			return _guideBD;
		}
	}
}
