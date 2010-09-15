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
package de.mattesgroeger.air.icon.updater 
{
	import flash.desktop.Icon;
	import flash.desktop.NativeApplication;
	import flash.display.BitmapData;

	public class DockIconUpdater implements IconUpdater 
	{
		private var icon : Icon;

		public function DockIconUpdater() 
		{
			this.icon = getIcon();
		}
		
		public function canUpdate() : Boolean
		{
			return (icon != null);
		}

		public function update(newIcon : BitmapData) : void 
		{
			if (!canUpdate())
				return;
			
			icon.bitmaps = [newIcon];
		}

		protected function getIcon() : Icon 
		{
			return NativeApplication.nativeApplication.icon;
		}
	}
}