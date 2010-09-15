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
package de.mattesgroeger.air.icon.event 
{
	import flash.system.Capabilities;

	public class InformationType 
	{
		public static const ICON_UPDATED : InformationType = 
			new InformationType(0, "the icon has been updated");
		
		public static const NO_DEFAULT_ICON_LOADED_YET : InformationType = 
			new InformationType(1, "no default icon has been loaded yet");
		
		public static const DEFAULT_ICON_LOADED : InformationType = 
			new InformationType(2, "the default icon has been loaded");
		
		public static const DEFAULT_ICON_LOADING_FAILURE : InformationType = 
			new InformationType(3, "default icon could not be loaded because of the following error: ${message}");
		
		public static const OPERATING_SYSTEM_NOT_SUPPORTED : InformationType = 
			new InformationType(4, "your operating system (" + Capabilities.os + ") is not supported");
		
		public static const NO_VALID_ICON_BUILDER_FOUND : InformationType = 
			new InformationType(5, "no valid icon builder could be created, this may result from your currently used operating system or flash runtime");
		
		private var _code : uint;
		private var _message : String;

		public function InformationType(code : uint, message : String) 
		{
			_code = code;
			_message = message;
		}
		
		public function get code() : uint
		{
			return _code;
		}
		
		public function get message() : String
		{
			return _message;
		}

		public function setExpression(expression : String, value : String) : void 
		{
			_message = _message.replace("${" + expression + "}", value);
		}
	}
}