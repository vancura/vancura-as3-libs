/***********************************************************************************************************************
 * Copyright (c) 2010. Vaclav Vancura.
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

package org.vancura.vaclav.core.display {
	import flash.display.Sprite;

	/**
	 * A class covering few graphics methods I can't put anywhere else.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public final class GraphicsUtil {



		/** Default width */
		public static const DEFAULT_WIDTH:Number = 100;

		/** Default height */
		public static const DEFAULT_HEIGHT:Number = 100;

		/** Default color */
		public static const DEFAULT_COLOR:uint = 0xFF0000;

		/** Default alpha */
		public static const DEFAULT_ALPHA:Number = 1;

		/** Default thickness */
		public static const DEFAULT_THICKNESS:Number = 0;

		/** Default radius */
		public static const DEFAULT_RADIUS:Number = 20;

		/** Default segments */
		public static const DEFAULT_SEGMENTS:Number = 6;


		/**
		 * Shortcut to draw a rectangle.
		 *
		 * @param canvas Canvas to draw on
		 * @param x X position
		 * @param y Y position
		 * @param width Width
		 * @param height Height
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection OverlyComplexFunctionJS
		public static function drawRect(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT,
		                                color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawRect(x, y, width, height);
			canvas.graphics.endFill();
		}



		/**
		 * Shortcut to draw a circle.
		 *
		 * @param canvas Canvas to draw on
		 * @param x X center position
		 * @param y Y center position
		 * @param radius Radius
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection OverlyComplexFunctionJS
		public static function drawCircle(canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR,
		                                  alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawCircle(x, y, radius);
			canvas.graphics.endFill();
		}



		/**
		 * Shortcut to draw a rounded rectangle.
		 *
		 * @param canvas Canvas to draw on
		 * @param x X position
		 * @param y Y position
		 * @param width Width
		 * @param height Height
		 * @param radius Radius
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection OverlyComplexFunctionJS
		public static function drawRoundRect(canvas:Sprite, x:Number, y:Number, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT,
		                                     radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawRoundRect(x, y, width, height, radius, radius);
			canvas.graphics.endFill();
		}



		/**
		 * Shortcut to draw a pie.
		 *
		 * @param canvas Canvas to draw on
		 * @param x X center position
		 * @param y Y center position
		 * @param radius Radius
		 * @param segments Segments
		 * @param angle1 Angle 1
		 * @param angle2 Angle 2
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection FunctionTooLongJS,MagicNumberJS,OverlyComplexFunctionJS
		public static function drawPie(canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, segments:int = DEFAULT_SEGMENTS,
		                               angle1:Number = 0, angle2:Number = 360, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			var segm:Number;
			var grad:Number;
			var x1:Number;
			var y1:Number;

			//noinspection MagicNumberJS
			var rad:Number = Math.PI / 180;

			//noinspection UnnecessaryLocalVariableJS
			var a2:Number = angle2;
			var a1:Number = angle1;

			canvas.graphics.beginFill(color, alpha);

			if(!a1 && !a2 || a1 == a2) {
				// full circle

				//noinspection MagicNumberJS
				grad = 360;

				segm = grad / segments;
				x1 = radius + x;
				y1 = y;
				canvas.graphics.moveTo(x1, y1);
			}
			else {
				// not a full circle
				if(a1 > a2) {
					//noinspection MagicNumberJS
					a1 -= 360;
				}
				x1 = radius * Math.cos(a1 * rad) + x;
				y1 = radius * Math.sin(a1 * rad) + y;
				grad = a2 - a1;
				segm = grad / segments;
				canvas.graphics.moveTo(x, y);
				canvas.graphics.lineTo(x1, y1);
			}

			//noinspection MagicNumberJS
			for(var s:Number = segm + a1; s < grad + 0.1 + a1; s += segm) {
				var x2:Number = radius * Math.cos((s - segm / 2) * rad) + x;
				var y2:Number = radius * Math.sin((s - segm / 2) * rad) + y;
				var x3:Number = radius * Math.cos(s * rad) + x;
				var y3:Number = radius * Math.sin(s * rad) + y;

				//noinspection MagicNumberJS
				var cx:Number = 2 * x2 - 0.5 * (x1 + x3);

				//noinspection MagicNumberJS
				var cy:Number = 2 * y2 - 0.5 * (y1 + y3);

				x1 = x3;
				y1 = y3;

				canvas.graphics.curveTo(cx, cy, x3, y3);
			}

			//noinspection MagicNumberJS
			if(grad != 360) canvas.graphics.lineTo(x, y);

			canvas.graphics.endFill();
		}



		/**
		 * Shortcut to stroke a rectangle.
		 *
		 * @param canvas Canvas to draw on
		 * @param x X position
		 * @param y Y position
		 * @param width Width
		 * @param height Height
		 * @param color Color
		 * @param alpha Alpha
		 * @param thickness Thickness
		 */
		//noinspection OverlyComplexFunctionJS
		public static function strokeRect(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH,
		                                  height:Number = DEFAULT_HEIGHT, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA,
		                                  thickness:Number = DEFAULT_THICKNESS):void {
			var w:Number = width - 1;
			var h:Number = height - 1;

			canvas.graphics.lineStyle(thickness, color, alpha, true);
			canvas.graphics.drawRect(x, y, w, h);
		}



		/**
		 * Shortcut to draw a line.
		 *
		 * @param canvas Canvas to draw on
		 * @param x1 Start X position
		 * @param y1 Start Y position
		 * @param x2 End X position
		 * @param y2 End Y position
		 * @param color Color
		 * @param alpha Alpha
		 * @param thickness Thickness
		 */
		//noinspection OverlyComplexFunctionJS
		public static function strokeLine(canvas:Sprite, x1:Number, y1:Number, x2:Number, y2:Number, color:uint = DEFAULT_COLOR,
		                                  alpha:Number = DEFAULT_ALPHA, thickness:Number = DEFAULT_THICKNESS):void {
			canvas.graphics.lineStyle(thickness, color, alpha, true);
			canvas.graphics.moveTo(x1, y1);
			canvas.graphics.lineTo(x2, y2);
		}



		/**
		 * Draw bounding corners.
		 *
		 * @param canvas Canvas to draw on
		 * @param x X position
		 * @param y Y position
		 * @param width Width
		 * @param height Height
		 * @param padding Padding
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection OverlyComplexFunctionJS
		public static function strokeBounds(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH,
		                                    height:Number = DEFAULT_HEIGHT, padding:Number = 5, color:uint = DEFAULT_COLOR,
		                                    alpha:Number = DEFAULT_ALPHA):void {
			var w:Number = width - 1;
			var h:Number = height - 1;

			canvas.graphics.lineStyle(0, color, alpha, true);
			canvas.graphics.moveTo(x, padding + y);
			canvas.graphics.lineTo(x, y);
			canvas.graphics.lineTo(padding + x, y);
			canvas.graphics.moveTo(w - padding + x, y);
			canvas.graphics.lineTo(w + x, y);
			canvas.graphics.lineTo(w + x, padding + y);
			canvas.graphics.moveTo(w + x, h - padding + y);
			canvas.graphics.lineTo(w + x, h + y);
			canvas.graphics.lineTo(w - padding + x, h + y);
			canvas.graphics.moveTo(padding + x, h + y);
			canvas.graphics.lineTo(x, h + y);
			canvas.graphics.lineTo(x, h - padding + y);
		}
	}
}
