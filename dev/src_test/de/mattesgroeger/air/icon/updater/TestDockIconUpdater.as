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
	
	import flexunit.framework.Assert;

	import flash.desktop.Icon;
	import flash.display.BitmapData;

	public class TestDockIconUpdater 
	{
		[Test]
		public function construction() : void 
		{
			new DockIconUpdater();
		}

		[Test]
		public function updateWithUnsupportedOperatingSystem() : void 
		{
			var updater : DockIconUpdater = new FakeDockIconUpdater(null);
			updater.update(new BitmapData(100, 100));
			
			Assert.assertFalse(updater.canUpdate());
		}

		[Test]
		public function update() : void 
		{
			var bitmapData : BitmapData = new BitmapData(100, 100);
			var icon : Icon = new Icon();
			var updater : DockIconUpdater = new FakeDockIconUpdater(icon);
			
			updater.update(bitmapData);
			
			Assert.assertNotNull(icon.bitmaps);
			Assert.assertEquals("1", icon.bitmaps.length);
			Assert.assertObjectEquals(bitmapData, icon.bitmaps[0]);
		}
	}
}

import de.mattesgroeger.air.icon.updater.DockIconUpdater;

import flash.desktop.Icon;

class FakeDockIconUpdater extends DockIconUpdater
{
	private var icon : Icon;
	
	public function FakeDockIconUpdater(icon : Icon) 
	{
		this.icon = icon;
		
		super();
	}

	override protected function getIcon() : Icon 
	{
		return icon;
	}
}