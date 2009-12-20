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
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.ICheckButtonSkin;

	public class CheckButtonSkin extends Skin implements ICheckButtonSkin {


		protected var _buttonOffSkin:IButtonSkin;
		protected var _buttonOnSkin:IButtonSkin;



		public function CheckButtonSkin(id:String = null) {
			super(SkinType.CHECK_BUTTON, id);

			_buttonOffSkin = new ButtonSkin(id + '#buttonOff');
			_buttonOnSkin = new ButtonSkin(id + '#buttonOn');
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.buttonOff !== undefined) _buttonOffSkin.parseConfig(source.buttonOff);
			if(source.buttonOn !== undefined) _buttonOnSkin.parseConfig(source.buttonOn);
		}



		override public function revertConfig():void {
			super.revertConfig();

			_buttonOffSkin.revertConfig();
			_buttonOnSkin.revertConfig();
		}



		public function get buttonOffSkin():IButtonSkin {
			return _buttonOffSkin;
		}



		public function set buttonOffSkin(source:IButtonSkin):void {
			_buttonOffSkin = source;
		}



		public function get buttonOnSkin():IButtonSkin {
			return _buttonOnSkin;
		}



		public function set buttonOnSkin(source:IButtonSkin):void {
			_buttonOnSkin = source;
		}
	}
}
