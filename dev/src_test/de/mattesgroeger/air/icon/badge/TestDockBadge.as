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

	public class TestDockBadge 
	{
		[Test]
		public function construction() : void 
		{
			var badge : DockBadge = new DockBadge("test");
			
			assertResult(badge);
		}

		[Test]
		public function constructionWithNullLabel() : void 
		{
			var badge : DockBadge = new DockBadge(null);
			
			assertResult(badge);
		}
		
		[Test]
		public function constructionWithVeryLongLabel() : void 
		{
			var badge : DockBadge = new DockBadge("abcdefghijklmnopqrstuvwxyz0123456789!\"§$%&/()=?`´+#-.,");
			
			assertResult(badge);
		}

		private function assertResult(badge : DockBadge) : void 
		{
			Assert.assertTrue("unexpected badge width, should be greater than 0", (badge.width > 0));
			Assert.assertTrue("unexpected badge height, should be greater than 0", (badge.height > 0));
		}
	}
}
