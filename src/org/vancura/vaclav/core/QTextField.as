/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

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
		public function QTextField(config:Object = null, parent:DisplayObjectContainer = null) {
			// if config is not defined, prepare it
			if(config == null) {
				config = new Object();
			}

			super();

			// TextField overrides and custom config
			this.antiAliasType = (config.antiAliasType == undefined) ? AntiAliasType.ADVANCED : config.antiAliasType;
			this.condenseWhite = (config.condenseWhite == undefined) ? true : config.condenseWhite;
			this.embedFonts = (config.embedFonts == undefined) ? true : config.embedFonts;
			this.gridFitType = (config.gridFitType == undefined) ? GridFitType.PIXEL : config.gridFitType;
			this.multiline = (config.multiline == undefined) ? true : config.multiline;
			this.selectable = (config.selectable == undefined) ? false : config.selectable;
			this.type = (config.type == undefined) ? TextFieldType.DYNAMIC : config.type;
			this.wordWrap = (config.wordWrap == undefined) ? true : config.wordWrap;

			// assign parameters
			assign(this, config);

			// add child if requested
			if(parent != null) {
				parent.addChild(this);
			}
		}



		// Getters & setters
		// -----------------


		/**
		 * Moves to the specified position.
		 * @param x New X position
		 * @param y New Y position
		 */
		public function setPosition(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}



		/**
		 * Rescales to new size.
		 * @param width New width
		 * @param height New height
		 */
		public function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
	}
}
