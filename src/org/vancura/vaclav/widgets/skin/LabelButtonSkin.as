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
	import org.vancura.vaclav.widgets.interfaces.ILabelButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	public class LabelButtonSkin extends Skin implements ILabelButtonSkin {


		protected var $buttonSkin:IButtonSkin;
		protected var $labelOutSkin:ILabelSkin;
		protected var $labelHoverSkin:ILabelSkin;
		protected var $labelFocusSkin:ILabelSkin;



		public function LabelButtonSkin(id:String = null) {
			super(SkinType.LABEL_BUTTON, id);

			$buttonSkin = new ButtonSkin(id + '#button');
			$labelOutSkin = new LabelSkin(id + '#labelOut');
			$labelHoverSkin = new LabelSkin(id + '#labelHover');
			$labelFocusSkin = new LabelSkin(id + '#labelFocus');
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.button != undefined) {
				$buttonSkin.parseConfig(source.button);
			}

			if(source.labelOut != undefined) {
				$labelOutSkin.parseConfig(source.labelOut);
			}

			if(source.labelHover != undefined) {
				$labelHoverSkin.parseConfig(source.labelHover);
			}

			if(source.labelFocus != undefined) {
				$labelFocusSkin.parseConfig(source.labelFocus);
			}
		}



		override public function revertConfig():void {
			super.revertConfig();

			$buttonSkin.revertConfig();
			$labelOutSkin.revertConfig();
			$labelHoverSkin.revertConfig();
			$labelFocusSkin.revertConfig();
		}



		public function get buttonSkin():IButtonSkin {
			return $buttonSkin;
		}



		public function set buttonSkin(source:IButtonSkin):void {
			$buttonSkin = source;
		}



		public function get labelOutSkin():ILabelSkin {
			return $labelOutSkin;
		}



		public function set labelOutSkin(source:ILabelSkin):void {
			$labelOutSkin = source;
		}



		public function get labelHoverSkin():ILabelSkin {
			return $labelHoverSkin;
		}



		public function set labelHoverSkin(source:ILabelSkin):void {
			$labelHoverSkin = source;
		}



		public function get labelFocusSkin():ILabelSkin {
			return $labelFocusSkin;
		}



		public function set labelFocusSkin(source:ILabelSkin):void {
			$labelFocusSkin = source;
		}
	}
}
