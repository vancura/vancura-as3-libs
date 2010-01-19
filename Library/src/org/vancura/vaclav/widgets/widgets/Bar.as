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

package org.vancura.vaclav.widgets.widgets {
	import com.destroytoday.display.Scale9Bitmap;

	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.utils.DisplayUtils;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IBar;
	import org.vancura.vaclav.widgets.interfaces.IBarSkin;

	public class Bar extends Widget implements IBar {


		protected var _skin:IBarSkin;
		protected var _bodySBM:Scale9Bitmap;



		public function Bar(skin:IBarSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			if(c.width == undefined) c.width = skin.assetWidth;
			if(c.height == undefined) c.height = skin.assetHeight;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			else throw new Error('No skin defined');

			this.skin = skin;
		}



		override protected function _init():void {
			super._init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		override protected function _addChildren():void {
			super._addChildren();

			_bodySBM = new Scale9Bitmap();

			DisplayUtils.addChildren(_contentSpr, _bodySBM);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			DisplayUtils.removeChildren(_contentSpr, _bodySBM);
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function draw():void {
			super.draw();

			if(_skin != null) {
				var l:Number = _skin.paddingLeft;
				var t:Number = _skin.paddingTop;
				var w:Number = _width - _skin.paddingLeft - _skin.paddingRight;
				var h:Number = _height - _skin.paddingTop - _skin.paddingBottom;

				if(_width != 0 && !isNaN(_width)) {
					_bodySBM.width = w;
					_bodySBM.x = l;
				}
				if(_height != 0 && !isNaN(_height)) {
					_bodySBM.height = h;
					_bodySBM.y = t;
				}

				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(_width != 0 && _height != 0) {
						DisplayUtils.strokeBounds(_debugSpr, l, t, w, h, 5, _debugColor);
					}
				}
			}
		}



		public function get skin():IBarSkin {
			return _skin;
		}



		public function set skin(skin:IBarSkin):void {
			_skin = skin;

			if(_width == 0) _width = _skin.assetWidth;
			if(_height == 0) _height = _skin.assetHeight;

			_bodySBM.setup(_skin.backBD, _skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false));

			draw();
		}



		override public function get width():Number {
			return _width + _skin.paddingLeft + _skin.paddingRight;
		}



		override public function get height():Number {
			return _height + _skin.paddingTop + _skin.paddingBottom;
		}
	}
}
