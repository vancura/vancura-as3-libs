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
 *	         - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 *	         - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 *	         - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

/**
 Creates a standardized way of describing and storing percentages. You can store and receive percentages in two different formats; regular percentage or as an decimal percentage.

 If percent is 37.5% a regular percentage would be expressed as <code>37.5</code> while the decimal percentage will be expressed <code>0.375</code>.

 @author Aaron Clinger
 @author Mike Creighton
 @version 02/16/09
 */
package org.vancura.vaclav.core.types {
	public class Percent {


		protected var _percent:Number;



		/**
		 Creates a new Percent.

		 @param percentage: Percent formated at a percentage or an decimal percentage.
		 @param isDecimalPercentage: Indicates if the parameter <code>percentage</code> is a decimal percentage <code>true</code>, or regular percentage <code>false</code>.
		 */
		public function Percent(percentage:Number = 0, isDecimalPercentage:Boolean = true) {
			super();

			if(isDecimalPercentage) {
				this.decimalPercentage = percentage;
			}
			else {
				this.percentage = percentage;
			}
		}



		/**
		 The percent expressed as a regular percentage. 37.5% would be expressed as <code>37.5</code>.
		 */
		public function get percentage():Number {
			return 100 * this._percent;
		}



		public function set percentage(percent:Number):void {
			this._percent = percent * .01;
		}



		/**
		 The percent expressed as a decimal percentage. 37.5% would be expressed as <code>0.375</code>.
		 */
		public function get decimalPercentage():Number {
			return this._percent;
		}



		public function set decimalPercentage(percent:Number):void {
			this._percent = percent;
		}



		/**
		 Determines if the percent specified in the <code>percent</code> parameter is equal to this percent object.

		 @param percent: A Percent object.
		 @return Returns <code>true</code> if percents are identical; otherwise <code>false</code>.
		 */
		public function equals(percent:Percent):Boolean {
			return this.decimalPercentage == percent.decimalPercentage;
		}



		/**
		 @return A new percent object with the same value as this percent.
		 */
		public function clone():Percent {
			return new Percent(this.decimalPercentage);
		}



		public function valueOf():Number {
			return this.decimalPercentage;
		}



		public function toString():String {
			return this.decimalPercentage.toString();
		}
	}
}
