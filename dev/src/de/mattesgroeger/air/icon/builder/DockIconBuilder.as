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
package de.mattesgroeger.air.icon.builder 
{
	import de.mattesgroeger.air.icon.badge.DockBadge;

	import flash.display.Bitmap;

	public class DockIconBuilder extends AbstractIconBuilder
	{
		private static const ICON_SCALING_FACTOR : Number = 0.3684;
		private static const ICON_RIGHT_OFFSET_FACTOR : Number = 0.0135;
		
		override public function addBadge(label : String) : void
		{
			if (isLabelInvalid(label))
				return;
			
			var badge : DockBadge = new DockBadge(label);
			
			scaleBadge(badge);
			positionBadge(badge);
			
			container.addChild(badge);
		}

		private function isLabelInvalid(label : String) : Boolean 
		{
			return (label == null || label.length == 0);
		}

		private function scaleBadge(badgeBitmap : Bitmap) : void 
		{
			var targetBadgeHeight : Number = icon.height * ICON_SCALING_FACTOR;
			badgeBitmap.scaleX = badgeBitmap.scaleY = targetBadgeHeight / badgeBitmap.height;
		}

		private function positionBadge(badgeBitmap : Bitmap) : void 
		{
			var targetBadgeRightOffset : Number = icon.width * ICON_RIGHT_OFFSET_FACTOR;
			badgeBitmap.x = icon.width - badgeBitmap.width - targetBadgeRightOffset;
		}
	}
}