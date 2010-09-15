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
	public class DescriptorIconPathProvider implements IconPathProvider
	{
		private var applicationDescriptor : XML;
		
		public function DescriptorIconPathProvider(applicationDescriptor : XML) 
		{
			this.applicationDescriptor = applicationDescriptor;
		}

		public function getIconPath() : String 
		{
			if (applicationDescriptor == null)
				throw IconPathError.ICON_PATH_NOT_FOUND;
			
			var icon : IconData = getIconDataFromDescriptor();
			
			return icon.path;
		}

		private function getIconDataFromDescriptor() : IconData 
		{
			var imageNodes : XMLList = parseImageNodes(applicationDescriptor);
			var icon : IconData = getLargestIconData(imageNodes);
            
			if (icon == null)
				throw IconPathError.ICON_PATH_NOT_FOUND;
			
			return icon;
		}

		private function parseImageNodes(descriptor : XML) : XMLList 
		{
			return descriptor..*.(/image\d+x\d+/i.test(name())==true);
		}

		private function getLargestIconData(imageNodes : XMLList) : IconData 
		{
			var largestIcon : IconData;
			
			for each (var image : XML in imageNodes)
            {
				var currentIcon : IconData = createIconDataFromXml(image);
				
				if (largestIcon == null || largestIcon.size < currentIcon.size)
					largestIcon = currentIcon;
			}
			
			return largestIcon;
		}

		private function createIconDataFromXml(imageNode : XML) : IconData
		{
			var imagePath : String = imageNode.toString();
			var nodeName : String = imageNode.localName();
			var results : Array = nodeName.match(/(\d+)$/);
	    	
	    	return new IconData(imagePath, results[1]);
		}
	}
}

class IconData
{
	public var path : String;
	public var size : int;
	
	public function IconData(path : String, size : int)
	{
		this.path = path;
		this.size = size;
	}
}