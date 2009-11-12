package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.widgets.interfaces.IBarSkin;
	import org.vancura.vaclav.widgets.interfaces.IInputBarSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	
	
	public class InputBarSkin extends Skin implements IInputBarSkin {

		
		
		protected var $barSkin:IBarSkin;
		protected var $labelSkin:ILabelSkin;

		
		
		public function InputBarSkin(id:String = null) {
			super(Skin.TYPE_INPUT_BAR, id);
			
			$barSkin = new BarSkin(id + '#bar');
			$labelSkin = new LabelSkin(id + '#label');
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
			
			if(source.bar != undefined) {
				$barSkin.parseConfig(source.bar);
			}
			
			if(source.label != undefined) {
				$labelSkin.parseConfig(source.label);
			}
		}
		
		
		
		override public function revertConfig():void {
			super.revertConfig();
			
			$barSkin.revertConfig();
			$labelSkin.revertConfig();
		}

		
		
		public function get barSkin():IBarSkin {
			return $barSkin;
		}

		
		
		public function set barSkin(source:IBarSkin):void {
			$barSkin = source;
		}
		
		
		
		public function get labelSkin():ILabelSkin {
			return $labelSkin;
		}
		
		
		
		public function set labelSkin(source:ILabelSkin):void {
			$labelSkin = source;
		}
	}
}
