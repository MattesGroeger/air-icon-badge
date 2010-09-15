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
	import de.mattesgroeger.air.icon.event.UpdateErrorEvent;
	import flexunit.framework.Assert;

	import de.mattesgroeger.air.icon.event.InformationEvent;
	import de.mattesgroeger.air.icon.event.InformationType;

	import org.flexunit.async.Async;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class TestAbstractIconBadge 
	{
		private var assembler : FakeIconAssembler;
		private var updater : FakeIconUpdater;
		private var iconBadge : FakeIconBadge;

		[Before]
		public function setup() : void 
		{
			assembler = new FakeIconAssembler();
			updater = new FakeIconUpdater();
			iconBadge = new FakeIconBadge(assembler, updater); 
		}
		
		[After]
		public function teardown() : void 
		{
			assembler = null;
			updater = null;
			iconBadge = null;
		}

		[Test(async)]
		public function setLabel() : void 
		{
			iconBadge.addEventListener(InformationEvent.INFORMATION, Async.asyncHandler(this, handleIconUpdated, 100), false, 0, true);
			
			iconBadge.label = "test";
			
			Assert.assertTrue(assembler.assembled);
			Assert.assertEquals("test", assembler.label);
			Assert.assertTrue(updater.updated);
		}

		private function handleIconUpdated(event : InformationEvent, passThroughData : Object) : void 
		{
			Assert.assertObjectEquals(InformationType.ICON_UPDATED, event.information);
		}

		[Test(async)]
		public function setLabelWithMissingData() : void 
		{
			assembler.canBeAssembled = false;
			iconBadge.addEventListener(UpdateErrorEvent.UPDATE_ERROR, Async.asyncHandler(this, handleUpdateFailure, 100), false, 0, true);
			
			iconBadge.label = "test";
		}

		private function handleUpdateFailure(event : UpdateErrorEvent, passThroughData : Object) : void 
		{
			Assert.assertObjectEquals(UpdateErrorEvent.UPDATE_ERROR, event.type);
		}

		[Test]
		public function clearLabel() : void 
		{
			iconBadge.label = "test";
			
			iconBadge.clearLabel();
			
			Assert.assertTrue(assembler.assembled);
			Assert.assertNull(assembler.label);
			Assert.assertTrue(updater.updated);
		}

		[Test]
		public function setCustomIcon() : void 
		{
			var icon : Bitmap = new Bitmap(new BitmapData(100, 100));
			iconBadge.customIcon = icon;
			
			Assert.assertTrue(assembler.assembled);
			Assert.assertObjectEquals(icon, assembler.customBackground);
			Assert.assertTrue(updater.updated);
		}

		[Test]
		public function clearCustomIcon() : void 
		{
			iconBadge.customIcon = new Bitmap(new BitmapData(100, 100));
			
			iconBadge.clearCustomIcon();
			
			Assert.assertTrue(assembler.assembled);
			Assert.assertNull(assembler.customBackground);
			Assert.assertTrue(updater.updated);
		}
	}
}

import de.mattesgroeger.air.icon.AbstractIconBadge;
import de.mattesgroeger.air.icon.assembler.IconAssembler;
import de.mattesgroeger.air.icon.updater.IconUpdater;

import flash.display.Bitmap;
import flash.display.BitmapData;

class FakeIconBadge extends AbstractIconBadge
{
	private var fakeAssembler : IconAssembler;
	private var fakeUpdater : IconUpdater;

	public function FakeIconBadge(assembler : IconAssembler, updater : IconUpdater) 
	{
		fakeAssembler = assembler;
		fakeUpdater = updater;
		
		super();
	}

	override protected function createIconAssembler() : IconAssembler 
	{
		return fakeAssembler;
	}
	
	override protected function createIconUpdater() : IconUpdater 
	{
		return fakeUpdater;
	}
}

class FakeIconAssembler implements IconAssembler
{
	public var assembled : Boolean;
	public var canBeAssembled : Boolean = true;
	
	private var _label : String;
	private var _defaultBackground : Bitmap;
	private var _customBackground : Bitmap;

	public function canAssemble() : Boolean
	{
		return canBeAssembled;
	}
	
	public function assemble() : BitmapData
	{
		assembled = true;
		
		return null;
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
}

class FakeIconUpdater implements IconUpdater
{
	public var updated : Boolean = false;
	
	public function canUpdate() : Boolean
	{
		return true;
	}
	
	public function update(icon : BitmapData) : void
	{
		updated = true;
	}
}