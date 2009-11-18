package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabelButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	
	
	public class LabelButtonSkin extends Skin implements ILabelButtonSkin {

		
		
		protected var $buttonSkin:IButtonSkin;
		protected var $labelOutSkin:ILabelSkin;		protected var $labelHoverSkin:ILabelSkin;		protected var $labelFocusSkin:ILabelSkin;

		
		
		public function LabelButtonSkin(id:String = null) {
			super(SkinType.LABEL_BUTTON, id);
			
			$buttonSkin = new ButtonSkin(id + '#button');
			$labelOutSkin = new LabelSkin(id + '#labelOut');			$labelHoverSkin = new LabelSkin(id + '#labelHover');			$labelFocusSkin = new LabelSkin(id + '#labelFocus');
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
			$labelOutSkin.revertConfig();			$labelHoverSkin.revertConfig();			$labelFocusSkin.revertConfig();
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
