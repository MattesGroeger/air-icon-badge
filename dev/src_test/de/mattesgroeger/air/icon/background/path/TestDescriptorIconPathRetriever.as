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
package de.mattesgroeger.air.icon.background.path 
{
	import flexunit.framework.Assert;

	public class TestDescriptorIconPathRetriever 
	{
		[Test]
		public function construction() : void 
		{
			new DescriptorIconPathProvider(<xml/>);
		}
		
		[Test]
		public function getLargestIcon() : void 
		{
			var descriptor : XML = <application xmlns="http://ns.adobe.com/air/application/1.5" minimumPatchLevel="0">
										<icon>
									        <image16x16>icons/IconA.png</image16x16>
									        <image32x32>icons/IconB.png</image32x32>
									        <image48x48>icons/IconC.png</image48x48>
									        <image128x128>icons/IconD.png</image128x128>
									    </icon>
									</application>;
			
			var retriever : DescriptorIconPathProvider = new DescriptorIconPathProvider(descriptor);
			var path : String = retriever.getIconPath();
			
			Assert.assertEquals("unexpected file path", "icons/IconD.png", path);
		}
		
		[Test]
		public function getLargestIconWithUnsortedImageNodes() : void 
		{
			var descriptor : XML = <application xmlns="http://ns.adobe.com/air/application/1.5" minimumPatchLevel="0">
										<icon>
									        <image16x16>icons/IconA.png</image16x16>
									        <image48x48>icons/IconC.png</image48x48>
									        <image32x32>icons/IconB.png</image32x32>
									    </icon>
									</application>;
			
			var retriever : DescriptorIconPathProvider = new DescriptorIconPathProvider(descriptor);
			var path : String = retriever.getIconPath();
			
			Assert.assertEquals("unexpected file path", "icons/IconC.png", path);
		}
		
		[Test]
		public function getLargestIconWithOneImageNode() : void 
		{
			var descriptor : XML = <application xmlns="http://ns.adobe.com/air/application/1.5" minimumPatchLevel="0">
										<icon>
									        <image16x16>icons/Icon_16x16.png</image16x16>
									    </icon>
									</application>;
			
			var retriever : DescriptorIconPathProvider = new DescriptorIconPathProvider(descriptor);
			var path : String = retriever.getIconPath();
			
			Assert.assertEquals("unexpected file path", "icons/Icon_16x16.png", path);
		}
		
		[Test]
		public function getLargestIconWithNoImageNodes() : void 
		{
			var descriptor : XML = <application xmlns="http://ns.adobe.com/air/application/1.5" minimumPatchLevel="0"></application>;
			var retriever : DescriptorIconPathProvider = new DescriptorIconPathProvider(descriptor);
			
			try
			{
				retriever.getIconPath();
			}
			catch (e : IconPathError)
			{
				Assert.assertObjectEquals("unexpected icon path error", IconPathError.ICON_PATH_NOT_FOUND, e);
				return;
			}
			
			Assert.fail("no image path found error expected");
		}
		
		[Test]
		public function getLargestIconWithDescriptorNull() : void 
		{
			var retriever : DescriptorIconPathProvider = new DescriptorIconPathProvider(null);
			
			try
			{
				retriever.getIconPath();
			}
			catch (e : IconPathError)
			{
				Assert.assertObjectEquals("unexpected icon path error", IconPathError.ICON_PATH_NOT_FOUND, e);
				return;
			}
			
			Assert.fail("no image path found error expected");
		}
	}
}