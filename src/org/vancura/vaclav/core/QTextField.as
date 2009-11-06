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
		 * Create new QTextField instance.
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

			// TextField overrides
			if(c.autoSize != undefined) this.autoSize = c.autoSize;
			if(c.background != undefined) this.background = c.background;
			if(c.backgroundColor != undefined) this.backgroundColor = c.backgroundColor;
			if(c.border != undefined) this.border = c.border;
			if(c.borderColor != undefined) this.borderColor = c.borderColor;
			if(c.defaultTextFormat != undefined) this.defaultTextFormat = c.defaultTextFormat;
			if(c.displayAsPassword != undefined) this.displayAsPassword = c.displayAsPassword;
			if(c.htmlText != undefined) this.htmlText = c.htmlText;
			if(c.maxChars != undefined) this.maxChars = c.maxChars;
			if(c.mouseWheelEnabled != undefined) this.mouseWheelEnabled = c.mouseWheelEnabled;
			if(c.restrict != undefined) this.restrict = c.restrict;
			if(c.scrollH != undefined) this.scrollH = c.scrollH;
			if(c.scrollV != undefined) this.scrollV = c.scrollV;
			if(c.sharpness != undefined) this.sharpness = c.sharpness;
			if(c.styleSheet != undefined) this.styleSheet = c.styleSheet;
			if(c.text != undefined) this.text = c.text;
			if(c.textColor != undefined) this.textColor = c.textColor;
			if(c.thickness != undefined) this.thickness = c.thickness;
			if(c.useRichTextClipboard != undefined) this.useRichTextClipboard = c.useRichTextClipboard;

			// InteractiveObject overrides
			if(c.contextMenu != undefined) this.contextMenu = c.contextMenu;
			if(c.doubleClickEnabled != undefined) this.doubleClickEnabled = c.doubleClickEnabled;
			if(c.focusRect != undefined) this.focusRect = c.focusRect;
			if(c.mouseEnabled != undefined) this.mouseEnabled = c.mouseEnabled;
			if(c.tabEnabled != undefined) this.tabEnabled = c.tabEnabled;
			if(c.tabIndex != undefined) this.tabIndex = c.tabIndex;

			// DisplayObject overrides
			if(c.accessibilityProperties != undefined) this.accessibilityProperties = c.accessibilityProperties;
			if(c.alpha != undefined) this.alpha = c.alpha;
			if(c.blendMode != undefined) this.blendMode = c.blendMode;
			if(c.cacheAsBitmap != undefined) this.cacheAsBitmap = c.cacheAsBitmap;
			if(c.filters != undefined) this.filters = c.filters;
			if(c.height != undefined) this.height = c.height;
			if(c.mask != undefined) this.mask = c.mask;
			if(c.name != undefined) this.name = c.name;
			if(c.opaqueBackground != undefined) this.opaqueBackground = c.opaqueBackground;
			if(c.rotation != undefined) this.rotation = c.rotation;
			if(c.scale9Grid != undefined) this.scale9Grid = c.scale9Grid;
			if(c.scaleX != undefined) this.scaleX = c.scaleX;
			if(c.scaleY != undefined) this.scaleY = c.scaleY;
			if(c.scrollRect != undefined) this.scrollRect = c.scrollRect;
			if(c.transform != undefined) this.transform = c.transform;
			if(c.visible != undefined) this.visible = c.visible;
			if(c.width != undefined) this.width = c.width;
			if(c.x != undefined) this.x = c.x;
			if(c.y != undefined) this.y = c.y;
			
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
