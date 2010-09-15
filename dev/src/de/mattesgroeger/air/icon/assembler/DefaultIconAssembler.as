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
package de.mattesgroeger.air.icon.assembler 
{
	import de.mattesgroeger.air.icon.builder.IconBuilder;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class DefaultIconAssembler implements IconAssembler
	{
		private var iconBuilder : IconBuilder;
		
		private var _label : String;
		private var _defaultBackground : Bitmap;
		private var _customBackground : Bitmap;

		public function DefaultIconAssembler(iconBuilder : IconBuilder) 
		{
			this.iconBuilder = iconBuilder;
		}
		
		public function set label(label : String) : void
		{
			_label = label;
		}
		
		public function get label() : String
		{
			return _label;
		}

		public function set defaultBackground(background : Bitmap) : void 
		{
			_defaultBackground = background;
		}
		
		public function get defaultBackground() : Bitmap
		{
			return _defaultBackground;
		}

		public function set customBackground(background : Bitmap) : void 
		{
			_customBackground = background;
		}
		
		public function get customBackground() : Bitmap
		{
			return _customBackground;
		}

		public function canAssemble() : Boolean 
		{
			return (getCurrentBackgroundIcon() != null);
		}
		
		public function assemble() : BitmapData 
		{
			var background : Bitmap = getCurrentBackgroundIcon();
			
			iconBuilder.createNewIcon(background.width, background.height);
			
			iconBuilder.addBackground(background);
			iconBuilder.addBadge(label);
			
			return iconBuilder.getIcon();
		}

		private function getCurrentBackgroundIcon() : Bitmap 
		{
			return (customBackground != null) ? customBackground : defaultBackground;
		}
	}
}