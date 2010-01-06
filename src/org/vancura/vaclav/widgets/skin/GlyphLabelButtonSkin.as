/***********************************************************************************************************************
 * Copyright (c) 2010. Vaclav Vancura.
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
	import org.vancura.vaclav.widgets.interfaces.IGlyphLabelButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IGlyphsSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	public class GlyphLabelButtonSkin extends Skin implements IGlyphLabelButtonSkin {


		protected var _buttonSkin:IButtonSkin;
		protected var _glyphsSkin:IGlyphsSkin;
		protected var _labelOutSkin:ILabelSkin;
		protected var _labelHoverSkin:ILabelSkin;
		protected var _labelFocusSkin:ILabelSkin;



		public function GlyphLabelButtonSkin(id:String = null) {
			super(SkinType.GLYPH_BUTTON, id);

			_buttonSkin = new ButtonSkin(id + '#button');
			_glyphsSkin = new GlyphsSkin(id + '#glyphs');
			_labelOutSkin = new LabelSkin(id + '#labelOut');
			_labelHoverSkin = new LabelSkin(id + '#labelHover');
			_labelFocusSkin = new LabelSkin(id + '#labelFocus');
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.button != undefined) _buttonSkin.parseConfig(source.button);
			if(source.glyphs != undefined) _glyphsSkin.parseConfig(source.glyphs);
			if(source.labelOut != undefined) _labelOutSkin.parseConfig(source.labelOut);
			if(source.labelHover != undefined) _labelHoverSkin.parseConfig(source.labelHover);
			if(source.labelFocus != undefined) _labelFocusSkin.parseConfig(source.labelFocus);
		}



		override public function revertConfig():void {
			super.revertConfig();

			_buttonSkin.revertConfig();
			_glyphsSkin.revertConfig();
			_labelOutSkin.revertConfig();
			_labelHoverSkin.revertConfig();
			_labelFocusSkin.revertConfig();
		}



		public function get buttonSkin():IButtonSkin {
			return _buttonSkin;
		}



		public function set buttonSkin(source:IButtonSkin):void {
			_buttonSkin = source;
		}



		public function get glyphsSkin():IGlyphsSkin {
			return _glyphsSkin;
		}



		public function set glyphsSkin(source:IGlyphsSkin):void {
			_glyphsSkin = source;
		}



		public function get labelOutSkin():ILabelSkin {
			return _labelOutSkin;
		}



		public function set labelOutSkin(source:ILabelSkin):void {
			_labelOutSkin = source;
		}



		public function get labelHoverSkin():ILabelSkin {
			return _labelHoverSkin;
		}



		public function set labelHoverSkin(source:ILabelSkin):void {
			_labelHoverSkin = source;
		}



		public function get labelFocusSkin():ILabelSkin {
			return _labelFocusSkin;
		}



		public function set labelFocusSkin(source:ILabelSkin):void {
			_labelFocusSkin = source;
		}
	}
}
