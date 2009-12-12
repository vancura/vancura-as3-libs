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

package org.vancura.vaclav.far {
	import br.com.stimuli.string.printf;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	import org.vancura.vaclav.far.events.FarHelperEvent;
	import org.vancura.vaclav.far.events.FarHelperProgressEvent;
	import org.vanrijkom.far.FarStream;

	/**
	 * Class: FarHelper
	 *
	 * FAR Helper class.
	 *
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class FarHelper extends EventDispatcher {


		private var _stream:FarStream;
		private var _itemList:Array = new Array();
		private var _url:String;
		private var _isLoading:Boolean;
		private var _isLoaded:Boolean;



		/**
		 * FAR Helper constructor.
		 */
		public function FarHelper() {
			// create new stream
			_stream = new FarStream();

			// add event listeners
			_stream.addEventListener(IOErrorEvent.IO_ERROR, _onFarIOError, false, 0, true);
			_stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onFarSecurityError, false, 0, true);
			_stream.addEventListener(Event.COMPLETE, _onFarDownloadDone, false, 0, true);

			// TODO: Unhandled IOError when 404
		}



		/**
		 * FAR Helper destructor.
		 */
		public function destroy():void {
			// unload if loading
			unload();

			// remove event listeners
			_stream.removeEventListener(IOErrorEvent.IO_ERROR, _onFarIOError);
			_stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onFarSecurityError);
			_stream.removeEventListener(Event.COMPLETE, _onFarDownloadDone);
		}



		/**
		 * Load a FAR.
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
		 * @param index Index name
		 */
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
			throw new Error(printf('Item "%s" not registered, use loadItem(index)', index));
		}



		// Getters & setters
		// -----------------


		/**
		 * Get Stream pointer.
		 * @return Stream pointer
		 */
		public function get stream():FarStream {
			return _stream;
		}



		/**
		 * Get loaded flag.
		 * @return Loaded flag
		 */
		public function get isLoaded():Boolean {
			return _stream.loaded;
		}



		/**
		 * Get loading flag.
		 * @return Loading flag
		 */
		public function get isLoading():Boolean {
			return _isLoading;
		}



		/**
		 * Get FAR URL.
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
			dispatchEvent(event.clone());
		}



		private function _onFarIOError(event:IOErrorEvent):void {
			_isLoading = false;
			_isLoaded = false;

			dispatchEvent(new FarHelperEvent(FarHelperEvent.STREAM_IO_ERROR, false, false, null, event.text));
			dispatchEvent(event.clone());
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
	}
}
