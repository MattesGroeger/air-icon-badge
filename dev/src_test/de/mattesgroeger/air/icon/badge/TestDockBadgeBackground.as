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
package de.mattesgroeger.air.icon.badge 
{
	import de.mattesgroeger.air.icon.badge.enum.SnapMode;

	import org.flexunit.Assert;

	public class TestDockBadgeBackground 
	{
		[Test]
		public function construction() : void
		{
			new DockBadgeBackground(100, 100, SnapMode.CEIL);
		}
		
		[Test]
		public function ceilSnapMode() : void
		{
			testCeilSnapModeRange(100, 150);
		}
		
		private function testCeilSnapModeRange(from : int, to : int) : void
		{
			for (var currentWidth : int = from; currentWidth < to; currentWidth++)
			{
				testCeilSnapWidth(currentWidth);
			}
		}
		
		private function testCeilSnapWidth(currentWidth : int) : void
		{
			var badge : DockBadgeBackground = new DockBadgeBackground(currentWidth, 100, SnapMode.CEIL);
			
			Assert.assertTrue("badge width should not be smaller than defined width", (badge.width >= currentWidth));
			Assert.assertTrue("badge height should not be greater than defined height", (badge.height <= 100));
		}
		
		[Test]
		public function floorSnapMode() : void
		{
			testFloorSnapModeRange(100, 150);
		}
		
		private function testFloorSnapModeRange(from : int, to : int) : void
		{
			for (var currentWidth : int = from; currentWidth < to; currentWidth++)
			{
				testFloorSnapWidth(currentWidth);
			}
		}
		
		private function testFloorSnapWidth(currentWidth : int) : void
		{
			var badge : DockBadgeBackground = new DockBadgeBackground(currentWidth, 100, SnapMode.FLOOR);
			
			Assert.assertTrue("badge width should not be greater than defined width", (badge.width <= currentWidth));
			Assert.assertTrue("badge height should not be greater than defined height", (badge.height <= 100));
		}

		[Test]
		public function testMinWidth() : void
		{
			var badge : DockBadgeBackground = new DockBadgeBackground(50, 100, SnapMode.FLOOR);
			
			Assert.assertTrue("badge width should be greater or equal than height", (badge.width >= badge.height));
		}
	}
}