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
	import flash.system.Capabilities;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class DockBadgeLabel extends Sprite 
	{
		private static const FONT_TYPE : String = "Arial Bold";
		private static const FONT_TYPE_FALLBACK : String = "Arial";
		private static const FONT_SIZE : int = 50;
		private static const FONT_COLOR : Number = 0xffffff;
		
		private var labelTextField : TextField;
		private var maxWidth : int;

		public function DockBadgeLabel(label : String, maxWidth : int = 150)
		{
			this.maxWidth = maxWidth;
			
			createTextField();
			configureTextFormat();
			configureText();
			
			setLabel(label);
		}
		
		private function createTextField() : void
		{
			labelTextField = new TextField();
			addChild(labelTextField);
		}

		public function get label() : String
		{
			return labelTextField.text;
		}

		private function configureTextFormat() : void
		{
			var textFormat : TextFormat = new TextFormat();
			textFormat.font = FONT_TYPE;
			textFormat.size = FONT_SIZE;
			textFormat.color = FONT_COLOR;
			
			if (!isMac())
			{
				textFormat.font = FONT_TYPE_FALLBACK;
				textFormat.bold = true;
			}
			
			labelTextField.defaultTextFormat = textFormat;
		}

		private function isMac() : Boolean 
		{
			return Capabilities.os.toLowerCase().indexOf("mac") >= 0;
		}

		private function configureText() : void
		{
			labelTextField.autoSize = TextFieldAutoSize.LEFT;
			labelTextField.selectable = false;
			labelTextField.multiline = false;
		}

		private function setLabel(label : String) : void
		{
			label = (label == null) ? "" : label;
			
			labelTextField.text = label;
			
			if (width > maxWidth)
				cropText();
		}
		
		private function cropText() : void
		{
			var string : String = labelTextField.text;
			var stringLength : int = string.length;
			var centerIndex : int = Math.floor(string.length / 2);
			var startIndex : int = centerIndex;
			
			for (var cropCount : int = 0; cropCount < stringLength; cropCount++)
			{
				startIndex = centerIndex - Math.floor(cropCount / 2);
				
				var prefix : String = string.substring(0, startIndex);
				var postfix : String = string.substring(startIndex + cropCount, stringLength);
				var result : String = prefix + "..." + postfix;
				
				labelTextField.text = result;
				
				if (width <= maxWidth)
					return;
			}
		}
	}
}