package org.vancura.vaclav.core {

	
	
	/**
	 * Generate a random string.
	 * @param newLength Length of the result string
	 * @param userAlphabet Set of chars to be used
	 * @return Random string
	 */
	/*
	 *	Method: randomString
	 *	
	 *	Generate random String.
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 *
	 *	Parameters:
	 *
	 *		length	- String length (default 10)
	 *		chars	- Chars used (default 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') 
	 *		
	 *	Returns:
	 *			
	 *		Random String
	 */
	public function randomString(length:uint = 10, chars:String = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):String {
		var alphabet:Array = chars.split('');
		var alphabetLength:int = alphabet.length;
		var randomLetters:String = '';
		
		for(var j:uint = 0;j < length; j++) {
			randomLetters += alphabet[int(Math.floor(Math.random() * alphabetLength))];
		}
		
		return randomLetters;
	}
}
