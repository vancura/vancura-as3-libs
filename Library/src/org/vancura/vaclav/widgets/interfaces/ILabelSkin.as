/***********************************************************************************************************************
 * Some methods Copyrighted by their authors, specified in ASDocs.
 * If not specified elsewhere: Copyright (c) 2010 Vaclav Vancura.
 *
 * Contact me at vaclav@vancura.org, @vancura or at my homepage at http://vaclav.vancura.org.
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Licensed under Attribution 3.0 Czech Republic (http://creativecommons.org/licenses/by/3.0/cz/deed.en_GB).
 *
 * That means you are free:
 * * to copy, distribute, display, and perform the work
 * * to make derivative works
 *
 * Under the following conditions::
 * * Attribution Ñ You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver Ñ Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights Ñ In no way are any of the following rights affected by the license:
 * 	        - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.interfaces {


	public interface ILabelSkin extends ISkinnable, IConfigSkin {

		function get hAlign():String;
		function set hAlign(value:String):void;

		function get vAlign():String;
		function set vAlign(value:String):void;

		function get bold():Boolean;
		function set bold(value:Boolean):void;

		function get blockIndent():Number;
		function set blockIndent(value:Number):void;

		function get bullet():Boolean;
		function set bullet(value:Boolean):void;

		function get color():uint;
		function set color(value:uint):void;

		function get font():String;
		function set font(value:String):void;

		function get indent():Number;
		function set indent(value:Number):void;

		function get italic():Boolean;
		function set italic(value:Boolean):void;

		function get kerning():Boolean;
		function set kerning(value:Boolean):void;

		function get leading():Number;
		function set leading(value:Number):void;

		function get letterSpacing():Number;
		function set letterSpacing(value:Number):void;

		function get size():Number;
		function set size(value:Number):void;

		function get underline():Boolean;
		function set underline(value:Boolean):void;

		function get url():String;
		function set url(value:String):void;

		function get alpha():Number;
		function set alpha(value:Number):void;

		function get filters():Array;
		function set filters(value:Array):void;

		function get sharpness():Number;
		function set sharpness(value:Number):void;

		function get thickness():Number;
		function set thickness(value:Number):void;

		function get paddingTop():Number;
		function set paddingTop(value:Number):void;

		function get paddingBottom():Number;
		function set paddingBottom(value:Number):void;

		function get paddingLeft():Number;
		function set paddingLeft(value:Number):void;

		function get paddingRight():Number;
		function set paddingRight(value:Number):void;

		function get marginLeft():Number;
		function set marginLeft(value:Number):void;

		function get marginRight():Number;
		function set marginRight(value:Number):void;

	}
}
