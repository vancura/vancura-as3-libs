package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.widgets.skin.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.skin.interfaces.ICheckButtonSkin;

	
	
	public class CheckButtonSkin extends Skin implements ICheckButtonSkin {

		
		
		protected var $buttonOffSkin:IButtonSkin;
		protected var $buttonOnSkin:IButtonSkin;

		
		
		public function CheckButtonSkin(id:String) {
			super(id, Skin.TYPE_CHECK_BUTTON);
			
			$buttonOffSkin = new ButtonSkin(id + '#buttonOff');
			$buttonOnSkin = new ButtonSkin(id + '#buttonOn');
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
			
			if(source.buttonOff != undefined) $buttonOffSkin.parseConfig(source.buttonOff);			if(source.buttonOn != undefined) $buttonOnSkin.parseConfig(source.buttonOn);
		}
		
		
		
		override public function revertConfig():void {
			super.revertConfig();
			
			$buttonOffSkin.revertConfig();			$buttonOnSkin.revertConfig();
		}

		
		
		public function get buttonOffSkin():IButtonSkin {
			return $buttonOffSkin;
		}

		
		
		public function set buttonOffSkin(source:IButtonSkin):void {
			$buttonOffSkin = source;
		}

		
		
		public function get buttonOnSkin():IButtonSkin {
			return $buttonOnSkin;
		}

		
		
		public function set buttonOnSkin(source:IButtonSkin):void {
			$buttonOnSkin = source;
		}
	}
}
