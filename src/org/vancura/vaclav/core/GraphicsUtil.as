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
	import flash.display.Sprite;

	/*
	 * Class: GraphicsUtil
	 *
	 * A class covering few graphics methods I can't put anywhere else.
	 *
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public final class GraphicsUtil {



		/*
		 *	Constants: Default config
		 *
		 *		DEFAULT_WIDTH		- Default width (100)
		 *		DEFAULT_HEIGHT		- Default height (100)
		 *		DEFAULT_COLOR		- Default color (0xFF0000)
		 *		DEFAULT_ALPHA		- Default alpha (1)
		 *		DEFAULT_THICKNESS	- Default thickness (0)
		 *		DEFAULT_RADIUS		- Default radius (20)
		 *		DEFAULT_SEGMENTS	- Default segments (6)
		 */
		public static const DEFAULT_WIDTH:Number = 100;
		public static const DEFAULT_HEIGHT:Number = 100;
		public static const DEFAULT_COLOR:uint = 0xFF0000;
		public static const DEFAULT_ALPHA:Number = 1;
		public static const DEFAULT_THICKNESS:Number = 0;
		public static const DEFAULT_RADIUS:Number = 20;
		public static const DEFAULT_SEGMENTS:Number = 6;


		/*
		 *	Method: drawRect
		 *
		 *	Shortcut to draw a rectangle.
		 *
		 *	Parameters:
		 *
		 *		canvas		- Canvas to draw on
		 *		x			- X position
		 *		y			- Y position
		 *		width		- Width (if not specified, <DEFAULT_WIDTH> used)
		 *		height		- Height (if not specified, <DEFAULT_HEIGHT> used)
		 *		color		- Color (if not specified, <DEFAULT_COLOR> used)
		 *		alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		 */
		public static function drawRect(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT,
		                                color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawRect(x, y, width, height);
			canvas.graphics.endFill();
		}



		/*
		 *	Method: drawCircle
		 *
		 *	Shortcut to draw a circle.
		 *
		 *	Parameters:
		 *
		 *		canvas		- Canvas to draw on
		 *		x			- X center position
		 *		y			- Y center position
		 *		radius		- Radius (if not specified, <DEFAULT_RADIUS> used)
		 *		color		- Color (if not specified, <DEFAULT_COLOR> used)
		 *		alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		 */
		public static function drawCircle(canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR,
		                                  alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawCircle(x, y, radius);
			canvas.graphics.endFill();
		}



		/*
		 *	Method: drawRoundRect
		 *
		 *	Shortcut to draw a rounded rectangle.
		 *
		 *	Parameters:
		 *
		 *		canvas		- Canvas to draw on
		 *		x			- X position
		 *		y			- Y position
		 *		width		- Width (if not specified, <DEFAULT_WIDTH> used)
		 *		height		- Height (if not specified, <DEFAULT_HEIGHT> used)
		 *		radius		- Radius (if not specified, <DEFAULT_RADIUS> used)
		 *		color		- Color (if not specified, <DEFAULT_COLOR> used)
		 *		alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		 */
		public static function drawRoundRect(canvas:Sprite, x:Number, y:Number, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT,
		                                     radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawRoundRect(x, y, width, height, radius, radius);
			canvas.graphics.endFill();
		}



		/*
		 *	Method: drawPie
		 *
		 *	Shortcut to draw a pie.
		 *
		 *	Parameters:
		 *
		 *		canvas		- Canvas to draw on
		 *		x			- X center position
		 *		y			- Y center position
		 *		radius		- Radius (if not specified, <DEFAULT_RADIUS> used)
		 *		segments	- Segments (if not specified, <DEFAULT_SEGMENTS> used)
		 *		angle1		- Angle1 (if not specified, 0 used)
		 *		angle2		- Angle2 (if not specified, 360 used)
		 *		color		- Color (if not specified, <DEFAULT_COLOR> used)
		 *		alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		 */
		public static function drawPie(canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, segments:int = DEFAULT_SEGMENTS,
		                               angle1:Number = 0, angle2:Number = 360, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			var segm:Number;
			var grad:Number;
			var x1:Number;
			var y1:Number;
			var rad:Number = Math.PI / 180;

			canvas.graphics.beginFill(color, alpha);

			if(!angle1 && !angle2 || angle1 == angle2) {
				// full circle
				grad = 360;
				segm = grad / segments;
				x1 = radius + x;
				y1 = y;
				canvas.graphics.moveTo(x1, y1);
			}
			else {
				// not a full circle
				if(angle1 > angle2) {
					angle1 -= 360;
				}
				x1 = radius * Math.cos(angle1 * rad) + x;
				y1 = radius * Math.sin(angle1 * rad) + y;
				grad = angle2 - angle1;
				segm = grad / segments;
				canvas.graphics.moveTo(x, y);
				canvas.graphics.lineTo(x1, y1);
			}

			for(var s:Number = segm + angle1; s < grad + 0.1 + angle1; s += segm) {
				var x2:Number = radius * Math.cos((s - segm / 2) * rad) + x;
				var y2:Number = radius * Math.sin((s - segm / 2) * rad) + y;
				var x3:Number = radius * Math.cos(s * rad) + x;
				var y3:Number = radius * Math.sin(s * rad) + y;
				var cx:Number = 2 * x2 - 0.5 * (x1 + x3);
				var cy:Number = 2 * y2 - 0.5 * (y1 + y3);
				x1 = x3;
				y1 = y3;
				canvas.graphics.curveTo(cx, cy, x3, y3);
			}
			if(grad != 360) {
				canvas.graphics.lineTo(x, y);
			}

			canvas.graphics.endFill();
		}



		/*
		 *	Method: strokeRect
		 *
		 *	Shortcut to stroke a rectangle.
		 *
		 *	Parameters:
		 *
		 *		canvas		- Canvas to draw on
		 *		x			- X position
		 *		y			- Y position
		 *		width		- Width (if not specified, <DEFAULT_WIDTH> used)
		 *		height		- Height (if not specified, <DEFAULT_HEIGHT> used)
		 *		color		- Color (if not specified, <DEFAULT_COLOR> used)
		 *		alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		 *		thickness	- Thickness (if not specified, <DEFAULT_THICKNESS> used)
		 */
		public static function strokeRect(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH,
		                                  height:Number = DEFAULT_HEIGHT, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA,
		                                  thickness:Number = DEFAULT_THICKNESS):void {
			width--;
			height--;

			canvas.graphics.lineStyle(thickness, color, alpha, true);
			canvas.graphics.drawRect(x, y, width, height);
		}



		/*
		 *	Method: strokeLine
		 *
		 *	Shortcut to draw a line.
		 *
		 *	Parameters:
		 *
		 *		canvas		- Canvas to draw on
		 *		x1			- Start X position
		 *		y1			- Start Y position
		 *		x2			- End X position
		 *		y2			- End Y position
		 *		color		- Color (if not specified, <DEFAULT_COLOR> used)
		 *		alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		 *		thickness	- Thickness (if not specified, <DEFAULT_THICKNESS> used)
		 */
		public static function strokeLine(canvas:Sprite, x1:Number, y1:Number, x2:Number, y2:Number, color:uint = DEFAULT_COLOR,
		                                  alpha:Number = DEFAULT_ALPHA, thickness:Number = DEFAULT_THICKNESS):void {
			canvas.graphics.lineStyle(thickness, color, alpha, true);
			canvas.graphics.moveTo(x1, y1);
			canvas.graphics.lineTo(x2, y2);
		}



		/*
		 *	Method: strokeBounds
		 *
		 *	Draw bounding corners.
		 *
		 *	Parameters:
		 *
		 *		canvas		- Canvas to draw on
		 *		x			- X position
		 *		y			- Y position
		 *		width		- Width (if not specified, <DEFAULT_WIDTH> used)
		 *		height		- Height (if not specified, <DEFAULT_HEIGHT> used)
		 *		color		- Color (if not specified, <DEFAULT_COLOR> used)
		 *		alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		 */
		public static function strokeBounds(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH,
		                                    height:Number = DEFAULT_HEIGHT, padding:Number = 5, color:uint = DEFAULT_COLOR,
		                                    alpha:Number = DEFAULT_ALPHA):void {
			width--;
			height--;

			canvas.graphics.lineStyle(0, color, alpha, true);
			canvas.graphics.moveTo(x, padding + y);
			canvas.graphics.lineTo(x, y);
			canvas.graphics.lineTo(padding + x, y);
			canvas.graphics.moveTo(width - padding + x, y);
			canvas.graphics.lineTo(width + x, y);
			canvas.graphics.lineTo(width + x, padding + y);
			canvas.graphics.moveTo(width + x, height - padding + y);
			canvas.graphics.lineTo(width + x, height + y);
			canvas.graphics.lineTo(width - padding + x, height + y);
			canvas.graphics.moveTo(padding + x, height + y);
			canvas.graphics.lineTo(x, height + y);
			canvas.graphics.lineTo(x, height - padding + y);
		}
	}
}
