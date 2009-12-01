package org.vancura.vaclav.far {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.far.events.FarHelperEvent;
	import org.vancura.vaclav.far.events.FarHelperProgressEvent;
	import org.vanrijkom.far.FarStream;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	
	
	public class FarHelper extends EventDispatcher {

		
		
		private var _stream:FarStream;
		private var _itemList:Array = new Array();
		private var _url:String;
		private var _isLoading:Boolean;
		private var _isLoaded:Boolean;

		
		
		public function FarHelper() {
			_stream = new FarStream();
			
			_stream.addEventListener(IOErrorEvent.IO_ERROR, _onFarIOError, false, 0, true);
			_stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onFarSecurityError, false, 0, true);
			_stream.addEventListener(Event.COMPLETE, _onFarDownloadDone, false, 0, true);
			
			// TODO: Unhandled IOError when 404
		}
		
		
		
		public function destroy():void {
			unload();
			
			_stream.removeEventListener(IOErrorEvent.IO_ERROR, _onFarIOError);
			_stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onFarSecurityError);
			_stream.removeEventListener(Event.COMPLETE, _onFarDownloadDone);
		}

		
		
		public function load(url:String):void {
			if(!_isLoading && !_isLoaded) {
				_url = url;
				_isLoading = true;
				_stream.loadFromURL(_url);
			}
		}
		
		
		
		public function unload():void {
			_isLoading = false;
			_isLoaded = false;
			_url = null;
			
			for each(var i:FarHelperItem in _itemList) {
				i.removeEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete);
				i.removeEventListener(FarHelperProgressEvent.ITEM_LOAD_PROGRESS, _onItemLoadProgress);
				i.removeEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadIOError);
				
				i.destroy();
			}
			_itemList = new Array();
			
			if(_stream.connected) {
				_stream.close();
			}
		}

		
		
		public function loadItem(index:String):void {
			for each(var i:FarHelperItem in _itemList) {
				if(i.index == index && i.isLoaded) {
					i.getData(index);
					
					return;
				}
			}
			
			var helperItem:FarHelperItem = new FarHelperItem(_stream);
			
			helperItem.addEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete, false, 0, true);
			helperItem.addEventListener(FarHelperProgressEvent.ITEM_LOAD_PROGRESS, _onItemLoadProgress, false, 0, true);
			helperItem.addEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadIOError, false, 0, true);
			
			_itemList.push(helperItem);
			
			helperItem.getData(index);
		}
		
		
		
		public function getItem(index:String):FarHelperItem {
			for each(var i:FarHelperItem in _itemList) {
				if(i.index == index) {
					return i;
				}
			}
			
			throw new Error(printf('Item "%s" not registered, use loadItem(index)', index));
		}

		
		
		public function get stream():FarStream {
			return _stream;
		}

		
		
		public function get isLoaded():Boolean {
			return _stream.loaded;
		}
		
		
		
		public function get isLoading():Boolean {
			return _isLoading;
		}
		
		
		
		public function get url():String {
			return _url;
		}
		
		
		
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
