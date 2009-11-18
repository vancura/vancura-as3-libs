package org.vancura.vaclav.widgets.widgets {
	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.MouseStatus;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.ILabelButton;
	import org.vancura.vaclav.widgets.interfaces.ILabelButtonSkin;

	import flash.display.DisplayObjectContainer;

	
	
	public class LabelButton extends MorphSprite implements ILabelButton {

		
		
		protected var $skin:ILabelButtonSkin;		
		protected var $button:ScaleButton;
		protected var $labelBack:Label;		protected var $labelHover:Label;		protected var $labelFocus:Label;

		private var _debugLevel:String;

		
		
		public function LabelButton(	skin:ILabelButtonSkin,
										config:Object = null,
										text:String = '',
										parent:DisplayObjectContainer = null,
										debugLevel:String = null) {
										
			if(config == null) {
				config = new Object();
			}
			
			var dl:String = (debugLevel != null) ? debugLevel : SkinManager.debugLevel;
			
			$button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			$labelBack = new Label(skin.labelBackSkin, {mouseEnabled:false, mouseChildren:false}, '', this, dl);			$labelHover = new Label(skin.labelHoverSkin, {visible:false, mouseEnabled:false, mouseChildren:false}, '', this, dl);			$labelFocus = new Label(skin.labelFocusSkin, {visible:false, mouseEnabled:false, mouseChildren:false}, '', this, dl);
			$button.debugColor = SkinManager.debugColor;
			$labelBack.debugColor = SkinManager.debugColor;			$labelHover.debugColor = SkinManager.debugColor;			$labelFocus.debugColor = SkinManager.debugColor;
			
			this.skin = skin;
			this.text = text;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;
			
			if(config.width == undefined) {
				config.width = skin.buttonSkin.assetWidth;
			}
			
			if(config.height == undefined) {
				config.height = skin.buttonSkin.assetHeight;
			}
			
			if(skin != null) {
				super(config, parent);
			}
			else {
				throw new Error('No skin defined');
			}
			
			$skin = skin;
		}

		
		
		public function destroy():void {
			removeChildren(this, $button, $labelBack, $labelHover, $labelFocus);
			
			$button.destroy();
			$labelBack.destroy();			$labelHover.destroy();			$labelFocus.destroy();
		}

		
		
		public function draw():void {
			$button.draw();
			$labelBack.draw();			$labelHover.draw();			$labelFocus.draw();
		}

		
		
		public function forceRelease():void {
			$button.forceRelease();
		}

		
		
		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}

		
		
		public function get skin():ILabelButtonSkin {
			return $skin;
		}

		
		
		public function set skin(skin:ILabelButtonSkin):void {
			$skin = skin;
			
			$skin.labelBackSkin.hAlign = Align.CENTER;
			
			$button.skin = $skin.buttonSkin;
			$labelBack.skin = $skin.labelBackSkin;			$labelHover.skin = $skin.labelHoverSkin;			$labelFocus.skin = $skin.labelFocusSkin;
			
			draw();
		}

		
		
		override public function get width():Number {
			return $button.width;
		}

		
		
		override public function set width(value:Number):void {
			$button.width = value;
			$labelBack.width = value;			$labelHover.width = value;			$labelFocus.width = value;
			
			draw();
		}

		
		
		override public function get height():Number {
			return $button.height;
		}

		
		
		override public function set height(value:Number):void {
			$button.height = value;
			$labelBack.y = Math.round((value - $labelBack.height) / 2);			$labelHover.y = Math.round((value - $labelHover.height) / 2);			$labelFocus.y = Math.round((value - $labelFocus.height) / 2);
			
			draw();
		}

		
		
		public function set areEventsEnabled(value:Boolean):void {
			$button.areEventsEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;
			
			draw();
		}

		
		
		public function get areEventsEnabled():Boolean {
			return $button.areEventsEnabled;
		}

		
		
		public function get mouseStatus():String {
			return $button.mouseStatus;
		}

		
		
		public function get debugLevel():String {
			return _debugLevel;
		}

		
		
		public function set debugLevel(value:String):void {
			_debugLevel = value;
			$button.debugLevel = value;
			$labelBack.debugLevel = value;			$labelHover.debugLevel = value;			$labelFocus.debugLevel = value;
		}

		
		
		public function get text():String {
			return $labelBack.text;
		}

		
		
		public function set text(value:String):void {
			$labelBack.text = value;			$labelHover.text = value;			$labelFocus.text = value;
			
			draw();
		}
		
		
		
		public function get label():ILabel {
			if($button.mouseStatus == MouseStatus.BACK) return $labelBack;
			if($button.mouseStatus == MouseStatus.HOVER) return $labelHover;
			if($button.mouseStatus == MouseStatus.FOCUS) return $labelFocus;
		}
		
		
		
		public function get labelBack():ILabel {
			return $labelBack;
		}
		
		
		
		public function get labelHover():ILabel {
			return $labelHover;
		}
		
		
		
		public function get labelFocus():ILabel {
			return $labelFocus;
		}
		
		
		
		public function get button():IButton {
			return $button;
		}
	}
}
