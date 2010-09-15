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
	
	/**
	 * This class will provide a static interface for configuring the 
	 * application IconBadge. By default the IconBadge for the current
	 * operating system will be created internally. If no corresponding 
	 * IconBadge can be found a NullIconBadge will be used to avoid 
	 * exceptions. You can override this by assigning a custom factory. 
	 */
	public class AirIconBadge 
	{
		private static var _factory : IconBadgeFactory;
		private static var _iconBadge : IconBadge;
		
		/**
		 * The factory will be used to get an IconBadge instance the first
		 * time it is needed. If not set, an instance of AirIconBadgeFactroy
		 * will be used instead.
		 * 
		 * @param factory
		 */
		public static function set factory(factory : IconBadgeFactory) : void
		{
			_factory = factory;
			
			initialize();
		}
		
		/**
		 * @private
		 */
		public static function get factory() : IconBadgeFactory
		{
			if (_iconBadge == null)
				initialize();
			
			return _factory;
		}
		
		/**
		 * Returns an instance of the IconBadge that was created by the 
		 * factory. This is usefull if you want to register for events 
		 * or if you want to use special functions of the IconBadge.
		 * Otherwise you can use all static methods of this class which 
		 * will be delegated to the instance.
		 * 
		 * @return IconBadge
		 */
		public static function get iconBadge() : IconBadge
		{
			if (_iconBadge == null)
				initialize();
			
			return _iconBadge;
		}

		/**
		 * The label that shows up on the badge. Keep in mind that 
		 * the space for your label is limited! If the label is 
		 * <tt>null</tt> or <tt>empty</tt> no badge will be displayed.
		 * 
		 * @default null
		 */
		public static function set label(label : String) : void
		{
			if (_iconBadge == null)
				initialize();
			
			_iconBadge.label = label;
		}
		
		/**
		 * @private
		 */
		public static function get label() : String
		{
			if (_iconBadge == null)
				initialize();
			
			return _iconBadge.label;
		}
		
		/**
		 * Custom icon which will be used with the badge. This is only 
		 * nessacary if no icon has been defined within the application 
		 * descriptor.
		 * 
		 * @default null
		 */
		public static function set customIcon(icon : Bitmap) : void
		{
			if (_iconBadge == null)
				initialize();
			
			_iconBadge.customIcon = icon;
		}
		
		/**
		 * @private
		 */
		public static function get customIcon() : Bitmap
		{
			if (_iconBadge == null)
				initialize();
			
			return _iconBadge.customIcon;
		}
		
		/**
		 * Removes the current label and hides the badge.
		 */
		public static function clearLabel() : void
		{
			if (_iconBadge == null)
				initialize();
			
			_iconBadge.clearLabel();
		}
		
		/**
		 * Removes any custom icon. Make sure you have specified an icon 
		 * within the descriptor, to show instead. The badge will remain.
		 */
		public static function clearCustomIcon() : void
		{
			if (_iconBadge == null)
				initialize();
			
			_iconBadge.clearCustomIcon();
		}
		
		/**
		 * @private
		 */
		internal static function reset() : void
		{
			_factory = null;
			_iconBadge = null;
		}

		private static function initialize() : void 
		{
			if (_factory == null)
				_factory = new AirIconBadgeFactroy();
			
			_iconBadge = _factory.create();
		}
	}
}