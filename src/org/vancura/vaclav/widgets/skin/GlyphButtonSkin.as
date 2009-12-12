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
	import org.vancura.vaclav.widgets.interfaces.IGlyphButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IGlyphsSkin;

	public class GlyphButtonSkin extends Skin implements IGlyphButtonSkin {


		protected var $buttonSkin:IButtonSkin;
		protected var $glyphsSkin:IGlyphsSkin;



		public function GlyphButtonSkin(id:String = null) {
			super(SkinType.GLYPH_BUTTON, id);

			$buttonSkin = new ButtonSkin(id + '#button');
			$glyphsSkin = new GlyphsSkin(id + '#glyphs');
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.button != undefined) {
				$buttonSkin.parseConfig(source.button);
			}

			if(source.glyphs != undefined) {
				$glyphsSkin.parseConfig(source.glyphs);
			}
		}



		override public function revertConfig():void {
			super.revertConfig();

			$buttonSkin.revertConfig();
			$glyphsSkin.revertConfig();
		}



		public function get buttonSkin():IButtonSkin {
			return $buttonSkin;
		}



		public function set buttonSkin(source:IButtonSkin):void {
			$buttonSkin = source;
		}



		public function get glyphsSkin():IGlyphsSkin {
			return $glyphsSkin;
		}



		public function set glyphsSkin(source:IGlyphsSkin):void {
			$glyphsSkin = source;
		}
	}
}
