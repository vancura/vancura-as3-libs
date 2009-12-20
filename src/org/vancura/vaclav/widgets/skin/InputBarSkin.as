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
	import org.vancura.vaclav.widgets.interfaces.IBarSkin;
	import org.vancura.vaclav.widgets.interfaces.IInputBarSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	public class InputBarSkin extends Skin implements IInputBarSkin {


		protected var _barSkin:IBarSkin;
		protected var _labelSkin:ILabelSkin;



		public function InputBarSkin(id:String = null) {
			super(SkinType.INPUT_BAR, id);

			_barSkin = new BarSkin(id + '#bar');
			_labelSkin = new LabelSkin(id + '#label');
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.bar != undefined) _barSkin.parseConfig(source.bar);
			if(source.label != undefined) _labelSkin.parseConfig(source.label);
		}



		override public function revertConfig():void {
			super.revertConfig();

			_barSkin.revertConfig();
			_labelSkin.revertConfig();
		}



		public function get barSkin():IBarSkin {
			return _barSkin;
		}



		public function set barSkin(source:IBarSkin):void {
			_barSkin = source;
		}



		public function get labelSkin():ILabelSkin {
			return _labelSkin;
		}



		public function set labelSkin(source:ILabelSkin):void {
			_labelSkin = source;
		}
	}
}
