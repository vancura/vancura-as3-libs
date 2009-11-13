package org.vancura.vaclav.core {
	import flash.display.DisplayObjectContainer;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	
	
	/*
	 *	Class: QTextField
	 *	
	 *	Quick creation of TextField with initial data.
	 *	
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class QTextField extends TextField {

		
		
		/*
		 * Constructor: QTextField
		 * 
		 * Create a new QTextField instance.
		 * 
		 * Parameters:
		 * 
		 * 		c		- Config object
		 * 		parent	- Parent DisplayObjectContainer
		 * 		
		 * Every sane parameter of TextField, InteractiveObject and DisplayObject is supported,
		 * that means:
		 * 
		 * TextField parameters: autoSize, background, backgroundColor, border, borderColor,
		 * defaultTextFormat, displayAsPassword, htmlText, maxChars, mouseWheelEnabled, restrict,
		 * scrollH, scrollV, sharpness, styleSheet, text, textColor, thickness,
		 * useRichTextClipboard
		 * 
		 * InteractiveObject parameters: contextMenu, doubleClickEnabled, focusRect,
		 * mouseEnabled, tabEnabled, tabIndex
		 * 
		 * DisplayObject parameters: accessibilityProperties, alpha, blendMode, cacheAsBitmap,
		 * filters, height, mask, name, opaqueBackground, rotation, scale9Grid, scaleX, scaleY,
		 * scrollRect, transform, visible, width, x, y 
		 * 
		 * Additionally these parameters are set to new values if not specified:
		 * 
		 * 		antiAliasType	- set to AntiAliasType.ADVANCED if not specified
		 * 		condenseWhite	- set to true if not specified
		 * 		embedFonts		- set to true if not specified
		 * 		gridFitType		- set to GridFitType.PIXEL if not specified
		 * 		multiline		- set to true if not specified
		 * 		selectable		- set to false if not specified
		 * 		type			- set to TextFieldType.DYNAMIC if not specified
		 * 		wordWrap		- set to true if not specified
		 * 
		 * Example code:
		 * 
		 * (start code)
		 * 
		 * 		import org.vancura.graphics.QTextField;
		 * 		
		 * 		var myTextField:QTextField = new QTextField({
		 * 			x: 100,
		 * 			y: 50,
		 * 			width: 300,
		 * 			embedFonts: false,
		 * 			text: 'Lorem ipsum dolor sit amet.'
		 * 		});
		 * 		addChild(myTextField);
		 * 
		 * (end)
		 *  	
		 * Another example:
		 *  	
		 * (start code)
		 * 
		 * 		import org.vancura.graphics.QTextField;
		 * 		
		 * 		var myTextField:QTextField = new QTextField(null, this);
		 * 
		 * (end) 	
		 */
		public function QTextField(	c:Object = null,
									parent:DisplayObjectContainer = null) {
										
			// if config is not defined, prepare it
			if(c == null) c = new Object();

			super();
			
			// TextField overrides and custom config
			this.antiAliasType = (c.antiAliasType != undefined) ? c.antiAliasType : AntiAliasType.ADVANCED;
			this.condenseWhite = (c.condenseWhite != undefined) ? c.condenseWhite : true;
			this.embedFonts = (c.embedFonts != undefined) ? c.embedFonts : true;
			this.gridFitType = (c.gridFitType != undefined) ? c.gridFitType : GridFitType.PIXEL;
			this.multiline = (c.multiline != undefined) ? c.multiline : true;
			this.selectable = (c.selectable != undefined) ? c.selectable : false;
			this.type = (c.type != undefined) ? c.type : TextFieldType.DYNAMIC;
			this.wordWrap = (c.wordWrap != undefined) ? c.wordWrap : true;

			// assign parameters
			assign(this, c);
			
			// add child if requested
			if(parent != null) parent.addChild(this);
		}
		
		
		
		/*
		 * Method: setPosition
		 * 
		 * Moves to the specified position.
		 * 
		 * Parameters:
		 * 		x	- New x position
		 * 		y	- New y position
		 */
		public function setPosition(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}

		
		
		/*
		 * Method: setSize
		 * 
		 * Sets the size.
		 * 
		 * Parameters:
		 * 		width	- New width
		 * 		height	- New height
		 */
		public function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
	}
}
