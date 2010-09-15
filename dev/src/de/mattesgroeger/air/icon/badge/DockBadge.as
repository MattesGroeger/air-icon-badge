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

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;

	public class DockBadge extends Bitmap
	{
		private var badgeLabel : DockBadgeLabel;
		private var badgeBackground : DockBadgeBackground;

		public function DockBadge(label : String)
		{
			badgeLabel = createLabel(label);
			badgeBackground = createBackground();
			
			correctLabelPosition();
			renderBadgeBitmap();
		}
		
		private function createLabel(label : String) : DockBadgeLabel
		{
			var dockBadgeLabel : DockBadgeLabel = new DockBadgeLabel(label);
			dockBadgeLabel.x = 18;
			dockBadgeLabel.y = 18;
			
			return dockBadgeLabel;
		}
		
		private function createBackground() : DockBadgeBackground
		{
			var dockBadgeBackground : DockBadgeBackground = new DockBadgeBackground(badgeLabel.width + 32, badgeLabel.height + 34, SnapMode.CEIL);
			
			var shadow : DropShadowFilter = new DropShadowFilter(1, 45, 0x333333, .8, 7, 7);
			dockBadgeBackground.filters = [shadow];
			
			return dockBadgeBackground;
		}
		
		private function correctLabelPosition() : void
		{
			if (badgeLabel.x + badgeLabel.width < badgeBackground.width)
				badgeLabel.x = badgeBackground.width / 2 - badgeLabel.width / 2;
		}
		
		private function renderBadgeBitmap() : void
		{
			var container : Sprite = new Sprite();
			container.addChild(badgeBackground);
			container.addChild(badgeLabel);
			
			var badgeBitmapData : BitmapData = new BitmapData(container.width, container.height + 2, true, 0x000000ff);
			badgeBitmapData.draw(container, null, null, null, null, true);
			
			bitmapData = badgeBitmapData;
			smoothing = true;
		}
	}
}