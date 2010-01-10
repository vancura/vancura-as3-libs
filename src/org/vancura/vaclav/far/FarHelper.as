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

package org.vancura.vaclav.far {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

	import org.vancura.vaclav.far.events.FarHelperEvent;
	import org.vancura.vaclav.far.events.FarHelperProgressEvent;
	import org.vanrijkom.far.FarStream;

	/**
	 * FAR Helper class.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class FarHelper extends EventDispatcher {


		private var _stream:FarStream;
		private var _itemList:Array = new Array();
		private var _url:String;
		private var _isLoading:Boolean;
		private var _isLoaded:Boolean;



		/**
		 * Constructor.
		 */
		public function FarHelper() {
			// create new stream
			_stream = new FarStream();

			// add event listeners
			_stream.addEventListener(IOErrorEvent.IO_ERROR, _onFarIOError, false, 0, true);
			_stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onFarSecurityError, false, 0, true);
			_stream.addEventListener(Event.COMPLETE, _onFarDownloadDone, false, 0, true);
			_stream.addEventListener(ProgressEvent.PROGRESS, _onStreamLoadProgress, false, 0, true);

			// TODO: Unhandled IOError when 404 (should be fine now, test it)
		}



		/**
		 * Destructor.
		 */
		public function destroy():void {
			// unload if loading
			unload();

			// remove event listeners
			_stream.removeEventListener(IOErrorEvent.IO_ERROR, _onFarIOError);
			_stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onFarSecurityError);
			_stream.removeEventListener(Event.COMPLETE, _onFarDownloadDone);
			_stream.removeEventListener(ProgressEvent.PROGRESS, _onStreamLoadProgress);
		}



		/**
		 * Load a FAR.
		 *
		 * @param url FAR url
		 */
		public function load(url:String):void {
			if(!_isLoading && !_isLoaded) {
				_url = url;
				_isLoading = true;
				_stream.loadFromURL(_url);
			}
		}



		/**
		 * Unload a FAR.
		 */
		public function unload():void {
			// reset flags
			_isLoading = false;
			_isLoaded = false;
			_url = null;

			// remove event listeners from all items and destroy them
			for each(var i:FarHelperItem in _itemList) {
				i.removeEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete);
				i.removeEventListener(FarHelperProgressEvent.ITEM_LOAD_PROGRESS, _onItemLoadProgress);
				i.removeEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadIOError);
				i.destroy();
			}
			_itemList = new Array();

			// close stream
			if(_stream.connected) {
				_stream.close();
			}
		}



		/**
		 * Load item by its index name.
		 *
		 * @param index Index name
		 */
		//noinspection FunctionWithMultipleReturnPointsJS
		public function loadItem(index:String):void {
			// check out if the item was already loaded
			for each(var i:FarHelperItem in _itemList) {
				if(i.index == index && i.isLoaded) {
					// yeah, it was. just get data
					i.getData(index);
					return;
				}
			}

			// no, the item was not loaded yet
			// add it
			var helperItem:FarHelperItem = new FarHelperItem(_stream);

			// add event listeners
			helperItem.addEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete, false, 0, true);
			helperItem.addEventListener(FarHelperProgressEvent.ITEM_LOAD_PROGRESS, _onItemLoadProgress, false, 0, true);
			helperItem.addEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadIOError, false, 0, true);

			// store reference
			_itemList.push(helperItem);

			// get data
			helperItem.getData(index);
		}



		/**
		 * Get the item by its index name.
		 *
		 * @param index Index name
		 * @return Helper item
		 * @see FarHelper
		 * @throws Error if item is not registered
		 */
		public function getItem(index:String):FarHelperItem {
			// try to find the item
			for each(var i:FarHelperItem in _itemList) {
				if(i.index == index) {
					return i;
				}
			}

			// item not found
			throw new Error('Item "' + index + '" not registered, use loadItem(index)');
		}



		// Getters & setters
		// -----------------


		/**
		 * Get Stream pointer.
		 *
		 * @return Stream pointer
		 */
		public function get stream():FarStream {
			return _stream;
		}



		/**
		 * Get loaded flag.
		 *
		 * @return Loaded flag
		 */
		public function get isLoaded():Boolean {
			return _stream.loaded;
		}



		/**
		 * Get loading flag.
		 *
		 * @return Loading flag
		 */
		public function get isLoading():Boolean {
			return _isLoading;
		}



		/**
		 * Get FAR URL.
		 *
		 * @return FAR URL
		 */
		public function get url():String {
			return _url;
		}



		// Event listeners
		// ---------------


		private function _onFarSecurityError(event:SecurityErrorEvent):void {
			_isLoading = false;
			_isLoaded = false;

			dispatchEvent(new FarHelperEvent(FarHelperEvent.STREAM_SECURITY_ERROR, false, false, null, event.text));
		}



		private function _onFarIOError(event:IOErrorEvent):void {
			_isLoading = false;
			_isLoaded = false;

			dispatchEvent(new FarHelperEvent(FarHelperEvent.STREAM_IO_ERROR, false, false, null, event.text));
		}



		private function _onFarDownloadDone(event:Event):void {
			_isLoading = false;
			_isLoaded = true;

			dispatchEvent(new FarHelperEvent(FarHelperEvent.STREAM_DOWNLOAD_DONE, false, false));
		}



		private function _onItemLoadIOError(event:FarHelperEvent):void {
			dispatchEvent(event.clone());
		}



		private function _onItemLoadProgress(event:FarHelperProgressEvent):void {
			dispatchEvent(event.clone());
		}



		private function _onItemLoadComplete(event:FarHelperEvent):void {
			dispatchEvent(event.clone());
		}



		private function _onStreamLoadProgress(event:ProgressEvent):void {
			var p:Number = 1 / (event.bytesTotal / event.bytesLoaded);

			dispatchEvent(new FarHelperProgressEvent(FarHelperProgressEvent.STREAM_LOAD_PROGRESS, false, false, null, p));
		}
	}
}
