package org.vancura.vaclav.widgets.widgets {
	import org.vancura.vaclav.core.QTextField;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;
	import org.vancura.vaclav.widgets.globals.SkinManager;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	
	
	public class Label extends Widget implements ILabel {

		
		
		protected var $skin:ILabelSkin;
		protected var $textField:QTextField;
		protected var $textFormat:TextFormat;
		
		private var _isWidthOverriden:Boolean;
		private var _isHeightOverriden:Boolean;
		private var _vAlign:String;
		private var _isInput:Boolean;

		
		
		public function Label(	skin:ILabelSkin,
								config:Object = null,
								text:String = '',
								parent:DisplayObjectContainer = null,
								debugLevel:String = null) {
									
			if(config == null) {
				config = new Object();
			}
			
			if(skin != null) {
				super(config, parent, (debugLevel != null) ? debugLevel : SkinManager.debugLevel);
			}
			else {
				throw new Error('No skin defined');
			}
			
			_isWidthOverriden = (config.width != undefined);
			_isHeightOverriden = (config.height != undefined);
			
			this.skin = skin;
			this.text = text;
		}

		
		
		override protected function $init():void {
			super.$init();
			
			$textFormat = new TextFormat();
			
			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}

		
		
		override protected function $addChildren():void {
			super.$addChildren();
			
			$textField = new QTextField({width:2880, autoSize:(_isWidthOverriden) ? TextFieldAutoSize.NONE : Align.LEFT, borderColor:$debugColor, border:($debugLevel == DebugLevel.ALWAYS)}, $contentSpr);
		}

		
		
		override protected function $removeChildren():void {
			super.$removeChildren();
			
			removeChildren($contentSpr, $textField);
		}

		
		
		override public function draw():void {
			super.draw();
			
			if($width != 0) {
				$textField.width = $width - $skin.paddingLeft - $skin.paddingRight;
			}
			
			if($height != 0) {
				// count height without padding
				var h:Number = $height - $skin.paddingTop - $skin.paddingBottom;
				
				// set label height
				$textField.height = h;
				
				// non-top alignment
				if(_vAlign == Align.CENTER) {
					$textField.y = Math.round((h - $textField.textHeight) / 2) + $skin.paddingTop;
				}
				if(_vAlign == Align.BOTTOM) {
					$textField.y = h - $textField.textHeight + $skin.paddingTop;
				}
			}
		}

		
		
		override public function set debugLevel(value:String):void {
			super.debugLevel = value;
			
			$textField.border = ($debugLevel == DebugLevel.ALWAYS);
		}

		
		
		public function get skin():ILabelSkin {
			return $skin;
		}

		
		
		public function set skin(skin:ILabelSkin):void {
			$skin = skin;
			
			_vAlign = $skin.vAlign;
			
			$textFormat = new TextFormat();
			$textFormat.font = $skin.font;
			$textFormat.size = $skin.size;
			$textFormat.color = $skin.color;
			$textFormat.align = $skin.hAlign;
			
			$textField.setTextFormat($textFormat);
			$textField.defaultTextFormat = $textFormat;
			$textField.setPosition($skin.paddingLeft, $skin.paddingTop);
			$textField.filters = $skin.filters;
			$textField.sharpness = $skin.sharpness;
			$textField.thickness = $skin.thickness;
			$textField.alpha = $skin.alpha;
			$textField.embedFonts = ($skin.font != '');
			
			if($width == 0) {
				$width = $skin.assetWidth;
			}
			
			if($height == 0) {
				$height = $skin.assetHeight;
			}
			
			draw();
		}
		
		
		
		public function get text():String {
			return $textField.text;
		}
		
		
		
		public function set text(value:String):void {
			if($textField != null) {
				if(value != null) {
					$textField.htmlText = value;
				}
				
				$textField.setTextFormat($textFormat);
			}
			
			draw();
		}
		
		
		
		public function get textField():TextField {
			return $textField;
		}
		
		
		
		override public function get width():Number {
			return (_isWidthOverriden) ? $textField.width : $textField.textWidth + $skin.paddingLeft + $skin.paddingRight;
		}

		
		
		override public function get height():Number {
			return (_isHeightOverriden) ? $textField.height : $textField.textHeight + $skin.paddingTop + $skin.paddingBottom;
		}

		
		
		override public function get x():Number {
			return super.x - $skin.paddingLeft;
		}

		
		
		override public function get y():Number {
			return super.y - $skin.paddingTop;
		}

		
		
		public function get isInput():Boolean {
			return _isInput;
		}
		
		
		
		public function set isInput(value:Boolean):void {
			if($textField != null) {
				$textField.type = (value) ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
				$textField.selectable = value;
				$textField.multiline = !value;
				$textField.condenseWhite = !value;
				
				if(value) {
					$textField.autoSize = TextFieldAutoSize.NONE;
				}
				
				$textFormat.kerning = !value;
				$textField.setTextFormat($textFormat);
			}
			
			_isInput = value;
		}
		
		
		
		override protected function $onDebugOver(event:MouseEvent):void {
			super.$onDebugOver(event);
			
			if($debugLevel == DebugLevel.HOVER) $textField.border = true;
		}

		
		
		override protected function $onDebugOut(event:MouseEvent):void {
			super.$onDebugOut(event);
			
			if($debugLevel == DebugLevel.HOVER) $textField.border = false;
		}
	}
}