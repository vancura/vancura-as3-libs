package org.vancura.vaclav.widgets.widgets {
	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.ILabelButton;
	import org.vancura.vaclav.widgets.interfaces.ILabelButtonSkin;
	import org.vancura.vaclav.widgets.globals.SkinManager;

	import flash.display.DisplayObjectContainer;

	
	
	public class LabelButton extends MorphSprite implements ILabelButton {

		
		
		protected var $skin:ILabelButtonSkin;		
		protected var $button:ScaleButton;
		protected var $label:Label;

		private var _debugLevel:String;

		
		
		public function LabelButton(	skin:ILabelButtonSkin,
										config:Object = null,
										text:String = '',
										parent:DisplayObjectContainer = null,
										debugLevel:String = null) {
										
			if(config == null) {
				config = new Object();
			}
			
			var sm:SkinManager = SkinManager.getInstance();
			var dl:String = (debugLevel != null) ? debugLevel : sm.debugLevel;
			
			$button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			$label = new Label(skin.labelSkin, {mouseEnabled:false, mouseChildren:false}, '', this, dl);
			$button.debugColor = sm.debugColor;
			$label.debugColor = sm.debugColor;
			
			this.skin = skin;
			this.text = text;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;
			
			if(skin != null) {
				super(config, parent);
			}
			else {
				throw new Error('No skin defined');
			}
			
			$skin = skin;
		}

		
		
		public function destroy():void {
			removeChildren(this, $button, $label);
			
			$button.destroy();
			$label.destroy();
		}

		
		
		public function draw():void {
			$button.draw();
			$label.draw();
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
			
			$skin.labelSkin.hAlign = Align.CENTER;
			
			$button.skin = $skin.buttonSkin;
			$label.skin = $skin.labelSkin;
			
			draw();
		}

		
		
		override public function get width():Number {
			return $button.width;
		}

		
		
		override public function set width(value:Number):void {
			$button.width = value;
			$label.width = value;
			
			draw();
		}

		
		
		override public function get height():Number {
			return $button.height;
		}

		
		
		override public function set height(value:Number):void {
			$button.height = value;
			$label.y = Math.round((value - $label.height) / 2);
			
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

		
		
		public function get isDown():Boolean {
			return $button.isDown;
		}

		
		
		public function get isOver():Boolean {
			return $button.isOver;
		}

		
		
		public function get debugLevel():String {
			return _debugLevel;
		}

		
		
		public function set debugLevel(value:String):void {
			_debugLevel = value;
			$button.debugLevel = value;
			$label.debugLevel = value;
		}

		
		
		public function get text():String {
			return $label.text;
		}

		
		
		public function set text(value:String):void {
			$label.text = value;
			
			draw();
		}
		
		
		
		public function get label():ILabel {
			return $label;
		}
		
		
		
		public function get button():IButton {
			return $button;
		}
	}
}
