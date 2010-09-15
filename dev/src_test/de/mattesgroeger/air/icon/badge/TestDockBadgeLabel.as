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
	import flexunit.framework.Assert;

	public class TestDockBadgeLabel 
	{
		[Test]
		public function construction() : void
		{
			var label : DockBadgeLabel = new DockBadgeLabel("test");
			
			Assert.assertEquals("test", label.label);
		}

		[Test]
		public function testMaxTextWidth() : void
		{
			var string : String = "i";
			
			for (var i : int = 0; i < 20; i++)
			{
				var label : DockBadgeLabel = new DockBadgeLabel(string, 150);
				
				Assert.assertTrue("label should be smaller or equal than 150px", (label.width <= 150));
			}
		}
		
		[Test]
		public function testAssignNullLabel() : void
		{
			var label : DockBadgeLabel = new DockBadgeLabel(null);
			
			Assert.assertEquals("", label.label);
		}
	}
}