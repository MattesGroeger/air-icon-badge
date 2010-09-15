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

	public class TestAbstractApplicationIconBadge 
	{
		private var assembler : FakeIconAssembler;
		private var updater : FakeIconUpdater;
		private var backgroundRetriever : FakeBackgroundRetriever;
		private var iconBadge : FakeIconBadge;

		[Before]
		public function setup() : void 
		{
			assembler = new FakeIconAssembler();
			updater = new FakeIconUpdater();
			backgroundRetriever = new FakeBackgroundRetriever();
			iconBadge = new FakeIconBadge(assembler, updater, backgroundRetriever); 
		}
		
		[After]
		public function teardown() : void 
		{
			assembler = null;
			updater = null;
			iconBadge = null;
		}

		[Test(async)]
		public function construction() : void 
		{
			iconBadge.addEventListener(InformationEvent.INFORMATION, Async.asyncHandler(this, handleInformation, 100));
		}

		private function handleInformation(event : InformationEvent, passThroughData : Object) : void 
		{
			Assert.assertObjectEquals(InformationType.DEFAULT_ICON_LOADED, event.information);
			Assert.assertNotNull(assembler.defaultBackground);
		}

		[Test(async)]
		public function loadingError() : void 
		{
			iconBadge = new FakeIconBadge(assembler, updater, new FakeBackgroundRetriever("custom error")); 
			iconBadge.addEventListener(InformationEvent.INFORMATION, Async.asyncHandler(this, handleErrorInformation, 100));
		}

		private function handleErrorInformation(event : InformationEvent, passThroughData : Object) : void 
		{
			Assert.assertObjectEquals(InformationType.DEFAULT_ICON_LOADING_FAILURE, event.information);
			Assert.assertContained("custom error", event.information.message);
			Assert.assertNull(assembler.defaultBackground);
		}

		[Test(async)]
		public function updateError() : void 
		{
			assembler.canBeAssembled = false;
			
			iconBadge = new FakeIconBadge(assembler, updater, new FakeBackgroundRetriever("custom error")); 
			iconBadge.addEventListener(UpdateErrorEvent.UPDATE_ERROR, Async.asyncHandler(this, handleUpdateError, 100));
			iconBadge.label = "test";
		}

		private function handleUpdateError(event : UpdateErrorEvent, passThroughData : Object) : void 
		{
			Assert.assertObjectEquals(UpdateErrorEvent.UPDATE_ERROR, event.type);
		}
	}
}

import de.mattesgroeger.air.icon.AbstractApplicationIconBadge;
import de.mattesgroeger.air.icon.assembler.IconAssembler;
import de.mattesgroeger.air.icon.background.BackgroundRetriever;
import de.mattesgroeger.air.icon.updater.IconUpdater;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.setTimeout;

class FakeIconBadge extends AbstractApplicationIconBadge
{
	private var fakeAssembler : IconAssembler;
	private var fakeUpdater : IconUpdater;
	private var fakeBackgroundRetriever : BackgroundRetriever;

	public function FakeIconBadge(assembler : IconAssembler, updater : IconUpdater, backgroundRetriever : BackgroundRetriever) 
	{
		fakeAssembler = assembler;
		fakeUpdater = updater;
		fakeBackgroundRetriever = backgroundRetriever;
		
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

	override protected function createBackgroundRetriever() : BackgroundRetriever 
	{
		return fakeBackgroundRetriever;
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

class FakeBackgroundRetriever extends EventDispatcher implements BackgroundRetriever
{
	private var error : String;
	private var _background : Bitmap;

	public function FakeBackgroundRetriever(error : String = null) 
	{
		this.error = error;
	}

	public function retrieve() : void
	{
		setTimeout(dispatchComplete, 50);
	}

	private function dispatchComplete() : void 
	{
		if (error != null)
		{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, error));
		}
		else
		{
			_background = new Bitmap(new BitmapData(100, 100));
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
	
	public function get background() : Bitmap
	{
		return _background;
	}
}