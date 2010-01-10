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
 * * Attribution � You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver � Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights � In no way are any of the following rights affected by the license:
 *	         - Your fair dealing or fair use rights � All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 *	         - The author's moral rights � In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 *	         - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. � Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice � For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.core.utils {

	public class DateUtils {



		/**
		 * Constructor.
		 */
		public function DateUtils() {
		}



		/**
		 Formats a Date object for display. Acts almost identically to the PHP <code>date</code> function.
		 CASA
		 <table border="1">
		 <tr style="background-color:#e1e1e1;">
		 <th style="width:150px;">Format character</th>
		 <th>Description</th>
		 <th style="width:200px;">Example returned values</th>
		 </tr>
		 <tr>
		 <td>d</td>
		 <td>Day of the month, 2 digits with leading zeros.</td>
		 <td>01 to 31</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>D</td>
		 <td>A textual representation of a day, three letters.</td>
		 <td>Mon through Sun</td>
		 </tr>
		 <tr>
		 <td>j</td>
		 <td>Day of the month without leading zeros.</td>
		 <td>1 to 31</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>l</td>
		 <td>A full textual representation of the day of the week.</td>
		 <td>Sunday through Saturday</td>
		 </tr>
		 <tr>
		 <td>N</td>
		 <td>ISO-8601 numeric representation of the day of the week.</td>
		 <td>1 (for Monday) through 7 (for Sunday)</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>S</td>
		 <td>English ordinal suffix for the day of the month, 2 characters.</td>
		 <td>st, nd, rd or th</td>
		 </tr>
		 <tr>
		 <td>w</td>
		 <td>Numeric representation of the day of the week.</td>
		 <td>0 (for Sunday) through 6 (for Saturday)</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>z</td>
		 <td>The day of the year (starting from 0).</td>
		 <td>0 through 365</td>
		 </tr>
		 <tr>
		 <td>W</td>
		 <td>ISO-8601 week number of year, weeks starting on Monday.</td>
		 <td>Example: 42 (the 42nd week in the year)</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>F</td>
		 <td>A full textual representation of a month, such as January or March.</td>
		 <td>January through December</td>
		 </tr>
		 <tr>
		 <td>m</td>
		 <td>Numeric representation of a month, with leading zeros.</td>
		 <td>01 through 12</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>M</td>
		 <td>A short textual representation of a month, three letters.</td>
		 <td>Jan through Dec</td>
		 </tr>
		 <tr>
		 <td>n</td>
		 <td>Numeric representation of a month, without leading zeros.</td>
		 <td>1 through 12</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>t</td>
		 <td>Number of days in the given month.</td>
		 <td>28 through 31</td>
		 </tr>
		 <tr>
		 <td>L</td>
		 <td>Determines if it is a leap year.</td>
		 <td>1 if it is a leap year, 0 otherwise</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>o or Y</td>
		 <td>A full numeric representation of a year, 4 digits.</td>
		 <td>Examples: 1999 or 2003</td>
		 </tr>
		 <tr>
		 <td>y</td>
		 <td>A two digit representation of a year.</td>
		 <td>Examples: 99 or 03</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>a</td>
		 <td>Lowercase Ante meridiem and Post meridiem.</td>
		 <td>am or pm</td>
		 </tr>
		 <tr>
		 <td>A</td>
		 <td>Uppercase Ante meridiem and Post meridiem.</td>
		 <td>AM or PM</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>B</td>
		 <td>Swatch Internet time.</td>
		 <td>000 through 999</td>
		 </tr>
		 <tr>
		 <td>g</td>
		 <td>12-hour format of an hour without leading zeros.</td>
		 <td>1 through 12</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>G</td>
		 <td>24-hour format of an hour without leading zeros.</td>
		 <td>0 through 23</td>
		 </tr>
		 <tr>
		 <td>h</td>
		 <td>12-hour format of an hour with leading zeros.</td>
		 <td>01 through 12</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>H</td>
		 <td>24-hour format of an hour with leading zeros.</td>
		 <td>00 through 23</td>
		 </tr>
		 <tr>
		 <td>i</td>
		 <td>Minutes with leading zeros.</td>
		 <td>00 to 59</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>s</td>
		 <td>Seconds, with leading zeros.</td>
		 <td>00 through 59</td>
		 </tr>
		 <tr>
		 <td>I</td>
		 <td>Determines if the date is in daylight saving time.</td>
		 <td>1 if Daylight Saving Time, 0 otherwise</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>O</td>
		 <td>Difference to coordinated universal time (UTC) in hours.</td>
		 <td>Example: +0200</td>
		 </tr>
		 <tr>
		 <td>P</td>
		 <td>Difference to Greenwich time (GMT/UTC) in hours with colon between hours and minutes.</td>
		 <td>Example: +02:00</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>e or T</td>
		 <td>Timezone abbreviation.</td>
		 <td>Examples: EST, MDT</td>
		 </tr>
		 <tr>
		 <td>Z</td>
		 <td>Timezone offset in seconds.</td>
		 <td>-43200 through 50400</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>c</td>
		 <td>ISO 8601 date.</td>
		 <td>2004-02-12T15:19:21+00:00</td>
		 </tr>
		 <tr>
		 <td>r</td>
		 <td>RFC 2822 formatted date.</td>
		 <td>Example: Thu, 21 Dec 2000 16:01:07 +0200</td>
		 </tr>
		 <tr style="background-color:#f0f5f9;">
		 <td>U</td>
		 <td>Seconds since the Unix Epoch.</td>
		 <td>Example: 1171479314</td>
		 </tr>
		 </table>

		 @param dateToFormat: The Date object you wish to format.
		 @param formatString: The format of the outputted date String. See the format characters options above.
		 @usageNote You can prevent a recognized character in the format string from being expanded by escaping it with a preceding <code>^</code>.
		 @example
		 <code>
		 trace(formatDate(new Date(), "l ^t^h^e dS ^of F Y h:i:s A"));
		 </code>
		 */
		public static function formatDate(dateToFormat:Date, formatString:String):String {
			var returnString:String = '';
			var char:String;
			var i:int = -1;
			var l:uint = formatString.length;
			var t:Number;

			while(++i < l) {
				char = formatString.substr(i, 1);

				if(char == '^')
					returnString += formatString.substr(++i, 1);
				else {
					switch(char) {
						// Day of the month, 2 digits with leading zeros
						case 'd' :
							returnString += NumberUtils.addLeadingZero(dateToFormat.getDate());
							break;
						// A textual representation of a day, three letters
						case 'D' :
							returnString += getDayAbbrAsString(dateToFormat.getDay());
							break;
						// Day of the month without leading zeros
						case 'j' :
							returnString += dateToFormat.getDate().toString();
							break;
						// A full textual representation of the day of the week
						case 'l' :
							returnString += getDayAsString(dateToFormat.getDay());
							break;
						// ISO-8601 numeric representation of the day of the week
						case 'N' :
							t = dateToFormat.getDay();

							if(t == 0)
								t = 7;

							returnString += t.toString();
							break;
						// English ordinal suffix for the day of the month, 2 characters
						case 'S' :
							returnString += NumberUtils.getOrdinalSuffix(dateToFormat.getDate());
							break;
						// Numeric representation of the day of the week
						case 'w' :
							returnString += dateToFormat.getDay().toString();
							break;
						// The day of the year (starting from 0)
						case 'z' :
							returnString += NumberUtils.addLeadingZero(getDayOfTheYear(dateToFormat)).toString();
							break;
						// ISO-8601 week number of year, weeks starting on Monday
						case 'W' :
							returnString += NumberUtils.addLeadingZero(getWeekOfTheYear(dateToFormat)).toString();
							break;
						// A full textual representation of a month, such as January or March
						case 'F' :
							returnString += getMonthAsString(dateToFormat.getMonth());
							break;
						// Numeric representation of a month, with leading zeros
						case 'm' :
							returnString += NumberUtils.addLeadingZero(dateToFormat.getMonth() + 1);
							break;
						// A short textual representation of a month, three letters
						case 'M' :
							returnString += getMonthAbbrAsString(dateToFormat.getMonth());
							break;
						// Numeric representation of a month, without leading zeros
						case 'n' :
							returnString += (dateToFormat.getMonth() + 1).toString();
							break;
						// Number of days in the given month
						case 't' :
							returnString += getDaysInMonth(dateToFormat.getMonth(), dateToFormat.getFullYear()).toString();
							break;
						// Whether it is a leap year
						case 'L' :
							returnString += (isLeapYear(dateToFormat.getFullYear())) ? '1' : '0';
							break;
						// A full numeric representation of a year, 4 digits
						case 'o' :
						case 'Y' :
							returnString += dateToFormat.getFullYear().toString();
							break;
						// A two digit representation of a year
						case 'y' :
							returnString += dateToFormat.getFullYear().toString().substr(-2);
							break;
						// Lowercase Ante meridiem and Post meridiem
						case 'a' :
							returnString += getMeridiem(dateToFormat.getHours()).toLowerCase();
							break;
						// Uppercase Ante meridiem and Post meridiem
						case 'A' :
							returnString += getMeridiem(dateToFormat.getHours());
							break;
						// Swatch Internet time
						case 'B' :
							returnString += NumberUtils.format(getInternetTime(dateToFormat), 3, null, '0');
							break;
						// 12-hour format of an hour without leading zeros
						case 'g' :
							t = dateToFormat.getHours();

							if(t == 0)
								t = 12; else if(t > 12)
								t -= 12;

							returnString += t.toString();
							break;
						// 24-hour format of an hour without leading zeros
						case 'G' :
							returnString += dateToFormat.getHours().toString();
							break;
						// 12-hour format of an hour with leading zeros
						case 'h' :
							t = dateToFormat.getHours() + 1;

							if(t == 0)
								t = 12; else if(t > 12)
								t -= 12;

							returnString += NumberUtils.addLeadingZero(t);
							break;
						// 24-hour format of an hour with leading zeros
						case 'H' :
							returnString += NumberUtils.addLeadingZero(dateToFormat.getHours());
							break;
						// Minutes with leading zeros
						case 'i' :
							returnString += NumberUtils.addLeadingZero(dateToFormat.getMinutes());
							break;
						// Seconds, with leading zeros
						case 's' :
							returnString += NumberUtils.addLeadingZero(dateToFormat.getSeconds());
							break;
						// Whether or not the date is in daylights savings time
						case 'I' :
							returnString += (isDaylightSavings(dateToFormat)) ? '1' : '0';
							break;
						// Difference to Greenwich time (GMT/UTC) in hours
						case 'O' :
							returnString += getFormattedDifferenceFromUTC(dateToFormat);
							break;
						case 'P' :
							returnString += getFormattedDifferenceFromUTC(dateToFormat, ':');
							break;
						// Timezone identifier
						case 'e' :
						case 'T' :
							returnString += getTimezone(dateToFormat);
							break;
						// Timezone offset (GMT/UTC) in seconds.
						case 'Z' :
							returnString += Math.round(getDifferenceFromUTCInSeconds(dateToFormat)).toString();
							break;
						// ISO 8601 date
						case 'c' :
							returnString += dateToFormat.getFullYear() + "-" + NumberUtils.addLeadingZero(dateToFormat.getMonth() + 1) + "-" + NumberUtils.addLeadingZero(dateToFormat.getDate()) + "T" + NumberUtils.addLeadingZero(dateToFormat.getHours()) + ":" + NumberUtils.addLeadingZero(dateToFormat.getMinutes()) + ":" + NumberUtils.addLeadingZero(dateToFormat.getSeconds()) + getFormattedDifferenceFromUTC(dateToFormat, ':');
							break;
						// RFC 2822 formatted date
						case 'r' :
							returnString += getDayAbbrAsString(dateToFormat.getDay()) + ', ' + dateToFormat.getDate() + ' ' + getMonthAbbrAsString(dateToFormat.getMonth()) + ' ' + dateToFormat.getFullYear() + ' ' + NumberUtils.addLeadingZero(dateToFormat.getHours()) + ':' + NumberUtils.addLeadingZero(dateToFormat.getMinutes()) + ':' + NumberUtils.addLeadingZero(dateToFormat.getSeconds()) + ' ' + getFormattedDifferenceFromUTC(dateToFormat);
							break;
						// Seconds since the Unix Epoch (January 1 1970 00:00:00 GMT)
						case 'U' :
							t = Math.round(dateToFormat.getTime() / 1000);
							returnString += t.toString();
							break;
						default :
							returnString += formatString.substr(i, 1);
					}
				}
			}


			return returnString;
		}



		/**
		 Converts W3C ISO 8601 date strings into a Date object.
		 CASA

		 @param iso8601: A valid ISO 8601 formatted String.
		 @return Returns a Date object of the specified date and time of the ISO 8601 string in universal time.
		 @see <a href="http://www.w3.org/TR/NOTE-datetime">W3C ISO 8601 specification</a>
		 @example
		 <code>
		 trace(iso8601ToDate("1994-11-05T08:15:30-05:00").toString());
		 </code>
		 */
		public static function iso8601ToDate(iso8601:String):Date {
			var parts:Array = iso8601.toUpperCase().split('T');
			var date:Array = parts[0].split('-');
			var time:Array = (parts.length <= 1) ? new Array() : parts[1].split(':');
			var year:uint = ObjectUtils.isEmpty(date[0]) ? 0 : Number(date[0]);
			var month:uint = ObjectUtils.isEmpty(date[1]) ? 0 : Number(date[1] - 1);
			var day:uint = ObjectUtils.isEmpty(date[2]) ? 1 : Number(date[2]);
			var hour:int = ObjectUtils.isEmpty(time[0]) ? 0 : Number(time[0]);
			var minute:uint = ObjectUtils.isEmpty(time[1]) ? 0 : Number(time[1]);
			var second:uint = 0;
			var millisecond:uint = 0;

			if(time[2] != undefined) {
				var index:int = time[2].length;
				var temp:Number;
				if(time[2].indexOf('+') > -1)
					index = time[2].indexOf('+'); else if(time[2].indexOf('-') > -1)
					index = time[2].indexOf('-'); else if(time[2].indexOf('Z') > -1)
					index = time[2].indexOf('Z');

				if(isNaN(index)) {
					temp = Number(time[2].slice(0, index));
					second = Math.floor(temp);
					millisecond = 1000 * ((temp % 1) / 1);
				}

				if(index != time[2].length) {
					var offset:String = time[2].slice(index);
					var userOffset:Number = getDifferenceFromUTCInHours(new Date(year, month, day));

					switch(offset.charAt(0)) {
						case '+' :
						case '-' :
							hour -= userOffset + Number(offset.slice(0));
							break;
						case 'Z' :
							hour -= userOffset;
							break;
					}
				}
			}

			return new Date(year, month, day, hour, minute, second, millisecond);
		}



		/**
		 Converts the month number into the full month name.
		 CASA

		 @param month: The month number (0 for January, 1 for February, and so on).
		 @return Returns a full textual representation of a month, such as January or March.
		 @example
		 <code>
		 var myDate:Date = new Date(2000, 0, 1);

		 trace(getMonthAsString(myDate.getMonth())); // Traces January
		 </code>
		 */
		public static function getMonthAsString(month:Number):String {
			var monthNamesFull:Array = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
			return monthNamesFull[month];
		}



		/**
		 Converts the month number into the month abbreviation.
		 CASA

		 @param month: The month number (0 for January, 1 for February, and so on).
		 @return Returns a short textual representation of a month, three letters.
		 @example
		 <code>
		 var myDate:Date = new Date(2000, 0, 1);

		 trace(getMonthAbbrAsString(myDate.getMonth())); // Traces Jan
		 </code>
		 */
		public static function getMonthAbbrAsString(month:Number):String {
			return getMonthAsString(month).substr(0, 3);
		}



		/**
		 Converts the day of the week number into the full day name.
		 CASA

		 @param day: An integer representing the day of the week (0 for Sunday, 1 for Monday, and so on).
		 @return Returns a full textual representation of the day of the week.
		 @example
		 <code>
		 var myDate:Date = new Date(2000, 0, 1);

		 trace(getDayAsString(myDate.getDay())); // Traces Saturday
		 </code>
		 */
		public static function getDayAsString(day:Number):String {
			var dayNamesFull:Array = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
			return dayNamesFull[day];
		}



		/**
		 Converts the day of the week number into the day abbreviation.
		 CASA

		 @param day: An integer representing the day of the week (0 for Sunday, 1 for Monday, and so on).
		 @return Returns a textual representation of a day, three letters.
		 @example
		 <code>
		 var myDate:Date = new Date(2000, 0, 1);

		 trace(getDayAbbrAsString(myDate.getDay())); // Traces Sat
		 </code>
		 */
		public static function getDayAbbrAsString(day:Number):String {
			return getDayAsString(day).substr(0, 3);
		}



		/**
		 Finds the number of days in the given month.
		 CASA

		 @param year: The full year.
		 @param month: The month number (0 for January, 1 for February, and so on).
		 @return The number of days in the month; 28 through 31.
		 @example
		 <code>
		 var myDate:Date = new Date(2000, 0, 1);

		 trace(getDaysInMonth(myDate.getFullYear(), myDate.getMonth())); // Traces 31
		 </code>
		 */
		public static function getDaysInMonth(year:Number, month:Number):uint {
			return (new Date(year, ++month, 0)).getDate();
		}



		/**
		 Determines if time is Ante meridiem or Post meridiem.
		 CASA

		 @param hours: The hour to find the meridiem of (an integer from 0 to 23).
		 @return Returns either <code>"AM"</code> or <code>"PM"</code>
		 @example
		 <code>
		 trace(getMeridiem(17)); // Traces PM
		 </code>
		 */
		public static function getMeridiem(hours:Number):String {
			return (hours < 12) ? 'AM' : 'PM';
		}



		/**
		 Determines the difference between two dates.
		 CASA

		 @param startDate: The starting date.
		 @param endDate: The ending date.
		 @return Returns the difference in milliseconds between the two dates.
		 @example
		 <code>
		 trace(ConversionUtil.millisecondsToDays(getTimeBetween(new Date(2007, 0, 1), new Date(2007, 0, 11)))); // Traces 10
		 </code>
		 */
		public static function getTimeBetween(startDate:Date, endDate:Date):Number {
			return endDate.getTime() - startDate.getTime();
		}



		/**
		 Determines the time remaining until a certain date.
		 CASA

		 @param startDate: The starting date.
		 @param endDate: The ending date.
		 @return Returns an Object with the properties <code>days</code>, <code>hours</code>, <code>minutes</code>, <code>seconds</code> and <code>milliseconds</code> defined as numbers.
		 @example
		 <code>
		 var countdown:Object = getCountdownUntil(new Date(2006, 11, 31, 21, 36), new Date(2007, 0, 1));
		 trace("There are " + countdown.hours + " hours and " + countdown.minutes + " minutes until the new year!");
		 </code>
		 */
		public static function getCountdownUntil(startDate:Date, endDate:Date):Object {
			var daysUntil:Number = ConversionUtils.millisecondsToDays(getTimeBetween(startDate, endDate));
			var hoursUntil:Number = ConversionUtils.daysToHours(daysUntil % 1);
			var minsUntil:Number = ConversionUtils.hoursToMinutes(hoursUntil % 1);
			var secsUntil:Number = ConversionUtils.minutesToSeconds(minsUntil % 1);
			var milliUntil:Number = ConversionUtils.secondsToMilliseconds(secsUntil % 1);

			return {
				days:         int(daysUntil),
				hours:        int(hoursUntil),
				minutes:      int(minsUntil),
				seconds:      int(secsUntil),
				milliseconds: int(milliUntil)};
		}



		/**
		 Determines the difference to coordinated universal time (UTC) in seconds.
		 CASA

		 @param d: Date object to find the time zone offset of.
		 @return Returns the difference in seconds from UTC.
		 */
		public static function getDifferenceFromUTCInSeconds(d:Date):int {
			return ConversionUtils.minutesToSeconds(d.getTimezoneOffset());
		}



		/**
		 Determines the difference to coordinated universal time (UTC) in hours.
		 CASA

		 @param d: Date object to find the time zone offset of.
		 @return Returns the difference in hours from UTC.
		 */
		public static function getDifferenceFromUTCInHours(d:Date):int {
			return ConversionUtils.minutesToHours(d.getTimezoneOffset());
		}



		/**
		 Formats the difference to coordinated undefined time (UTC).
		 CASA

		 @param d: Date object to find the time zone offset of.
		 @param separator: The character(s) that separates the hours from minutes.
		 @return Returns the formatted time difference from UTC.
		 */
		public static function getFormattedDifferenceFromUTC(d:Date, separator:String = ""):String {
			var pre:String = (-d.getTimezoneOffset() < 0) ? '-' : '+';

			return pre + NumberUtils.addLeadingZero(Math.floor(getDifferenceFromUTCInHours(d))) + separator + NumberUtils.addLeadingZero(d.getTimezoneOffset() % 60);
		}



		/**
		 Determines the time zone of the user from a Date object.
		 CASA

		 @param d: Date object to find the time zone of.
		 @return Returns the time zone abbreviation.
		 @example
		 <code>
		 trace(getTimezone(new Date()));
		 </code>
		 */
		public static function getTimezone(d:Date):String {
			var timeZones:Array = new Array('IDLW', 'NT', 'HST', 'AKST', 'PST', 'MST', 'CST', 'EST', 'AST', 'ADT', 'AT', 'WAT', 'GMT', 'CET', 'EET', 'MSK', 'ZP4', 'ZP5', 'ZP6', 'WAST', 'WST', 'JST', 'AEST', 'AEDT', 'NZST');
			var hour:uint = Math.round(12 + -(d.getTimezoneOffset() / 60));

			if(isDaylightSavings(d))
				hour--;

			return timeZones[hour];
		}



		/**
		 Determines if year is a leap year or a common year.
		 CASA

		 @param year: The full year.
		 @return Returns <code>true</code> if year is a leap year; otherwise <code>false</code>.
		 @example
		 <code>
		 var myDate:Date = new Date(2000, 0, 1);

		 trace(isLeapYear(myDate.getFullYear())); // Traces true
		 </code>
		 */
		public static function isLeapYear(year:Number):Boolean {
			return getDaysInMonth(year, 1) == 29;
		}



		/**
		 Determines if or not the date is in daylight saving time.
		 CASA

		 @param d: Date to find if it is during daylight savings time.
		 @return Returns <code>true</code> if daylight savings time; otherwise <code>false</code>.
		 */
		public static function isDaylightSavings(d:Date):Boolean {
			var months:uint = 12;
			var offset:uint = d.getTimezoneOffset();
			var offsetCheck:Number;

			while(months--) {
				offsetCheck = (new Date(d.getFullYear(), months, 1)).getTimezoneOffset();

				if(offsetCheck != offset)
					return (offsetCheck > offset);
			}

			return false;
		}



		/**
		 Converts current time into Swatch internet time or beats.
		 CASA

		 @param d: Date object to convert.
		 @return Returns time in beats (0 to 999).
		 */
		public static function getInternetTime(d:Date):Number {
			var beats:uint = ((d.getUTCHours() + 1 + ConversionUtils.minutesToHours(d.getUTCMinutes()) + ConversionUtils.secondsToHours(d.getUTCSeconds())) / 0.024);
			return (beats > 1000) ? beats - 1000 : beats;
		}



		/**
		 Gets the current day out of the total days in the year (starting from 0).
		 CASA

		 @param d: Date object to find the current day of the year from.
		 @return Returns the current day of the year (0-364 or 0-365 on a leap year).
		 */
		public static function getDayOfTheYear(d:Date):uint {
			var firstDay:Date = new Date(d.getFullYear(), 0, 1);
			return (d.getTime() - firstDay.getTime()) / 86400000;
		}



		/**
		 Determines the week number of year, weeks start on Mondays.
		 CASA

		 @param d: Date object to find the current week number of.
		 @return Returns the the week of the year the date falls in.
		 */
		public static function getWeekOfTheYear(d:Date):uint {
			var firstDay:Date = new Date(d.getFullYear(), 0, 1);
			var dayOffset:uint = 9 - firstDay.getDay();
			var firstMonday:Date = new Date(d.getFullYear(), 0, (dayOffset > 7) ? dayOffset - 7 : dayOffset);
			var currentDay:Date = new Date(d.getFullYear(), d.getMonth(), d.getDate());
			var weekNumber:uint = (ConversionUtils.millisecondsToDays(currentDay.getTime() - firstMonday.getTime()) / 7) + 1;

			return (weekNumber == 0) ? getWeekOfTheYear(new Date(d.getFullYear() - 1, 11, 31)) : weekNumber;
		}



		/**
		 Determines if two Dates are the same time.
		 CASA

		 @param first: First Date to compare to <code>second</code>.
		 @param second: Second Date to compare to <code>first</code>.
		 @return Returns <code>true</code> if Dates are the same; otherwise <code>false</code>.
		 */
		public static function equals(first:Date, second:Date):Boolean {
			return first.valueOf() == second.valueOf();
		}



		/** Utility function for generating time code given a number seconds.
		 * OpenVideoPlayer
		 */
		public static function timeCode(sec:Number):String {
			var h:Number = Math.floor(sec / 3600);
			var m:Number = Math.floor((sec % 3600) / 60);
			var s:Number = Math.floor((sec % 3600) % 60);
			return (h == 0 ? "" : (h < 10 ? "0" + h.toString() + ":" : h.toString() + ":")) + (m < 10 ? "0" + m.toString() : m.toString()) + ":" + (s < 10 ? "0" + s.toString() : s.toString());
		}



		/**
		 *  Compares two dates.
		 * OpenVideoPlayer
		 *  @param d1 The first date to compare.
		 *
		 *  @param d2 The second date to compare.
		 *
		 *  @return -1 if the first date is earlier than the second. 0 if the dates are equal. 1 if the first date is later than the second.
		 */
		public static function compare(d1:Date, d2:Date):Number {
			var d1Ts:Number = d1.getTime();
			var d2Ts:Number = d2.getTime();

			var result:Number = -1;

			if(d1Ts == d2Ts)
				result = 0; else if(d1Ts > d2Ts)
				result = 1;

			return result;
		}
	}
}
