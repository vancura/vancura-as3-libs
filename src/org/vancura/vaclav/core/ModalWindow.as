package org.vancura.vaclav.core {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	
	
	/*
	 *	Class: ModalWindow
	 *	
	 *	Modal Window allows to show critical information if nothing is embedded
	 *	and everything is screwed up.
	 *	
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class ModalWindow extends Sprite {

		
		
		private static const _FONT:String = '_sans';
		private static const _BACKGROUND_COLOR:uint = 0xFFAAAA;
		private static const _BACKGROUND_ALPHA:Number = .9;
		private static const _TEXT_HORIZ_PADDING:uint = 10;
		private static const _TEXT_VERT_PADDING:uint = 5;
		private static const _DESCRIPTION_COLOR:uint = 0x660000;
		private static const _DESCRIPTION_FONT_SIZE:uint = 9;
		
		private var _fillSPR:Sprite;
		private var _descText:QTextField;
		private var _isVisible:Boolean;

		
		
		/*
		 * Constructor: ModalWindow
		 * 
		 * Modal Window constructor.
		 */
		public function ModalWindow() {
			super();
			
			// add components
			_fillSPR = new QSprite({}, this);
			_descText = new QTextField({embedFonts:false, x:_TEXT_HORIZ_PADDING, y:_TEXT_VERT_PADDING, height:400, defaultTextFormat:new TextFormat(_FONT, _DESCRIPTION_FONT_SIZE, _DESCRIPTION_COLOR)}, this);

			// drawing
			Drawing.drawRect(_fillSPR, 0, 0, 2880, 100, _BACKGROUND_COLOR, _BACKGROUND_ALPHA);

			// set visual properties
			this.visible = false;

			// add event listeners
			addEventListener(MouseEvent.CLICK, _onClick, false, 0, true);
		}

		
		
		/*
		 * Destructor: destroy
		 * 
		 * Modal Window destructor.
		 */
		public function destroy():void {
			// remove event listeners
			removeEventListener(MouseEvent.CLICK, _onClick);
			
			// remove from display list
			removeChildren(this, _fillSPR, _descText);
		}

		
		
		/*
		 * Method: show
		 * 
		 * Show the Modal Window.
		 * 
		 * Parameters:
		 * 
		 * 		description		- Text to be displayed ('No description given' used instead)
		 */
		public function show(description:String = 'No description given'):void {
			_descText.text = description;
			_fillSPR.height = _descText.textHeight + _TEXT_VERT_PADDING * 3;
			_isVisible = true;
			this.visible = true;
		}

		
		
		/*
		 * Method: hide
		 * 
		 * Hide the Modal Window.
		 */
		public function hide():void {
			_isVisible = false;
			this.visible = false;
		}

		
		
		/*
		 * Method: set width
		 * 
		 * Set Modal Window width.
		 * 
		 * Parameters:
		 * 
		 * 		value	- Modal Window width 
		 */
		public override function set width(value:Number):void {
			_descText.width = value - _TEXT_HORIZ_PADDING * 2;
		}

		
		
		/*
		 * Method: set height
		 * 
		 * Set Modal Window height. Unused here, so it doesn't do anything at all.
		 * 
		 * Parameters:
		 * 
		 * 		value	- Modal Window height
		 */
		public override function set height(value:Number):void {
		}

		
		
		private function _onClick(event:MouseEvent):void {
			hide();
		}
	}
}
