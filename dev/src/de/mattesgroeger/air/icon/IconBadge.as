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
package de.mattesgroeger.air.icon 
{
	import flash.display.Bitmap;
	import flash.events.IEventDispatcher;
	
	/**
	 * Main interface for accessing all the icon features. You should 
	 * always programm to this interface to assure maximum 
	 * interchangeability.
	 */
	public interface IconBadge extends IEventDispatcher
	{
		/**
		 * The label that shows up on the badge. Keep in mind that 
		 * the space for your label is limited! If the label is 
		 * <tt>null</tt> or <tt>empty</tt> no badge will be displayed.
		 * 
		 * @default null
		 */
		function set label(label : String) : void;
		
		/**
		 * @private
		 */
		function get label() : String;
		
		/**
		 * Custom icon which will be used with the badge. This is only 
		 * nessacary if no icon has been defined within the application 
		 * descriptor.
		 * 
		 * @default null
		 */
		function set customIcon(icon : Bitmap) : void;
		
		/**
		 * @private
		 */
		function get customIcon() : Bitmap;
		
		/**
		 * Removes the current label and hides the badge.
		 */
		function clearLabel() : void;
		
		/**
		 * Removes any custom icon. Make sure you have specified an icon 
		 * within the descriptor, to show instead. The badge will remain.
		 */
		function clearCustomIcon() : void;
	}
}