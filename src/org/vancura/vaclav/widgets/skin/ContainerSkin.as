/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IContainerSkin;

	public class ContainerSkin extends Skin implements IContainerSkin {


		protected var _paddingTop:Number;
		protected var _paddingBottom:Number;
		protected var _paddingLeft:Number;
		protected var _paddingRight:Number;

		private var _oldPaddingTop:Number;
		private var _oldPaddingBottom:Number;
		private var _oldPaddingLeft:Number;
		private var _oldPaddingRight:Number;



		public function ContainerSkin(id:String = null) {
			super(SkinType.CONTAINER, id);

			_paddingTop = 0;
			_paddingBottom = 0;
			_paddingLeft = 0;
			_paddingRight = 0;
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
	}
}
