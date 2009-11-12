package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.widgets.skin.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.skin.interfaces.ILabelButtonSkin;
	import org.vancura.vaclav.widgets.skin.interfaces.ILabelSkin;

	
	
	public class LabelButtonSkin extends Skin implements ILabelButtonSkin {

		
		
		protected var $buttonSkin:IButtonSkin;
		protected var $labelSkin:ILabelSkin;

		
		
		public function LabelButtonSkin(id:String = null) {
			super(Skin.TYPE_LABEL_BUTTON, id);
			
			$buttonSkin = new ButtonSkin(id + '#button');
			$labelSkin = new LabelSkin(id + '#label');
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
			
			if(source.button != undefined) $buttonSkin.parseConfig(source.button);
			if(source.label != undefined) $labelSkin.parseConfig(source.label);
		}
		
		
		
		override public function revertConfig():void {
			super.revertConfig();
			
			$buttonSkin.revertConfig();
			$labelSkin.revertConfig();
		}

		
		
		public function get buttonSkin():IButtonSkin {
			return $buttonSkin;
		}

		
		
		public function set buttonSkin(source:IButtonSkin):void {
			$buttonSkin = source;
		}

		
		
		public function get labelSkin():ILabelSkin {
			return $labelSkin;
		}

		
		
		public function set labelSkin(source:ILabelSkin):void {
			$labelSkin = source;
		}
	}
}
