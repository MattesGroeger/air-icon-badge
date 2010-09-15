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
	import flexunit.framework.Assert;

	import flash.display.Bitmap;

	public class TestAirIconBadge 
	{
		private var fakeIcon : FakeIcon;
		private var fakeFaktory : FakeFactory;

		[Before]
		public function setup() : void 
		{
			fakeIcon = new FakeIcon();
			fakeFaktory = new FakeFactory(fakeIcon);
			
			AirIconBadge.factory = fakeFaktory;
		}

		[After]
		public function teardown() : void 
		{
			fakeIcon = null;
			fakeFaktory = null;
			
			AirIconBadge.reset();
		}

		[Test]
		public function defaultFactory() : void 
		{
			AirIconBadge.reset();
			
			Assert.assertTrue("unexpected factory type", (AirIconBadge.factory is AirIconBadgeFactroy));
			Assert.assertNotNull("iconBadge should not be null", AirIconBadge.iconBadge);
		}

		[Test]
		public function customFactory() : void 
		{
			var icon : IconBadge = new FakeIcon();
			var fakeFactory : IconBadgeFactory = new FakeFactory(icon);
			AirIconBadge.label = "test1";
			
			AirIconBadge.factory = fakeFactory;
			AirIconBadge.label = "test2";
			var iconBadge : IconBadge = AirIconBadge.iconBadge;
			
			Assert.assertTrue("unexpected factory object", (AirIconBadge.factory == fakeFactory));
			Assert.assertNotNull("iconBadge should not be null", AirIconBadge.iconBadge);
			Assert.assertEquals("unexpected iconBadge instance", icon, iconBadge);
		}

		[Test]
		public function setLabel() : void 
		{
			AirIconBadge.label = "test";
			
			Assert.assertTrue("set label should be called", fakeIcon.setLabelCalled);
		}
		
		[Test]
		public function getLabel() : void 
		{
			var label : String = AirIconBadge.label;
			
			Assert.assertEquals("test", label);
		}

		[Test]
		public function setCustomIcon() : void 
		{
			AirIconBadge.customIcon = FakeIcon.BITMAP;
			
			Assert.assertTrue("set customIcon should be called", fakeIcon.setCustomIconCalled);
		}
		
		[Test]
		public function getCustomIcon() : void 
		{
			var icon : Bitmap = AirIconBadge.customIcon;
			
			Assert.assertEquals(FakeIcon.BITMAP, icon);
		}

		[Test]
		public function clearLabel() : void 
		{
			AirIconBadge.clearLabel();
			
			Assert.assertTrue("clearLabel should be called", fakeIcon.clearLabelCalled);
		}

		[Test]
		public function clearCustomIcon() : void 
		{
			AirIconBadge.clearCustomIcon();
			
			Assert.assertTrue("clearCustomIcon should be called", fakeIcon.clearCustomIconCalled);
		}
	}
}

import de.mattesgroeger.air.icon.IconBadge;
import de.mattesgroeger.air.icon.IconBadgeFactory;

import flash.display.Bitmap;
import flash.events.EventDispatcher;

class FakeFactory implements IconBadgeFactory
{
	private var iconBadge : IconBadge;

	public function FakeFactory(iconBadge : IconBadge) 
	{
		this.iconBadge = iconBadge;
	}

	public function create() : IconBadge
	{
		return iconBadge;
	}
}

class FakeIcon extends EventDispatcher implements IconBadge
{
	public static const BITMAP : Bitmap = new Bitmap();
	
	public var clearLabelCalled : Boolean;
	public var clearCustomIconCalled : Boolean;
	public var setLabelCalled : Boolean;
	public var setCustomIconCalled : Boolean;

	public function clearLabel() : void
	{
		clearLabelCalled = true;
	}
	
	public function clearCustomIcon() : void
	{
		clearCustomIconCalled = true;
	}
	
	public function get label() : String
	{
		return "test";
	}
	
	public function get customIcon() : Bitmap
	{
		return BITMAP;
	}
	
	public function set label(label : String) : void
	{
		setLabelCalled = true;
	}
	
	public function set customIcon(icon : Bitmap) : void
	{
		setCustomIconCalled = true;
	}
}