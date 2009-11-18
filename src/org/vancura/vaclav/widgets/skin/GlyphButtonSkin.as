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
