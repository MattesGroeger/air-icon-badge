/*
 * Copyright (c) 2010 Mattes Groeger
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package de.mattesgroeger.air.icon.background
{
	import flash.events.EventDispatcher;
	import de.mattesgroeger.air.icon.background.path.DescriptorIconPathProvider;
	import de.mattesgroeger.air.icon.background.path.IconPathError;
	import de.mattesgroeger.air.icon.background.path.IconPathProvider;

	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="error", type="flash.events.ErrorEvent")]
	public class DefaultBackgroundRetriever extends EventDispatcher implements BackgroundRetriever
	{
		private var backgroundIcon : Bitmap;

		public function retrieve() : void
		{
			var pathProvider : IconPathProvider = createPathProvider();
			
			try
			{
				var backgroundPath : String = pathProvider.getIconPath();
			}
			catch (e : IconPathError)
			{
				trace(e.message);
				return;
			}
			
			loadBackground(backgroundPath);
		}
		
		public function get background() : Bitmap 
		{
			return backgroundIcon;
		}
		
		protected function createPathProvider() : IconPathProvider 
		{
			var applicationDescriptor : XML = NativeApplication.nativeApplication.applicationDescriptor;
			
			return new DescriptorIconPathProvider(applicationDescriptor);
		}
		
		private function loadBackground(backgroundPath : String) : void 
		{
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleIconLoadComplete, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleIconLoadError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleIconLoadError, false, 0, true);
			loader.load(new URLRequest(backgroundPath));
		}
		
		private function handleIconLoadComplete(event : Event) : void
		{
			var loaderInfo : LoaderInfo = LoaderInfo(event.target);
			backgroundIcon = Bitmap(loaderInfo.content);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function handleIconLoadError(event : ErrorEvent) : void
		{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.text));
		}
	}
}