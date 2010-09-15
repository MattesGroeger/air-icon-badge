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
package de.mattesgroeger.air.icon.background 
{
	import flash.events.ErrorEvent;
	import flexunit.framework.Assert;

	import org.flexunit.async.Async;

	import flash.events.Event;

	public class TestBackgroundRetriever 
	{
		private var retriever : DefaultBackgroundRetriever;

		[Test(async)]
		public function construction() : void 
		{
			retriever = new FakeBackgroundRetriever("assets/icon.png");
			retriever.addEventListener(Event.COMPLETE, Async.asyncHandler(this, handleValidIconComplete, 500), false, 0, true);
			retriever.retrieve();
		}
		
		private function handleValidIconComplete(event : Event, passThroughData : Object) : void
		{
			Assert.assertNotNull(retriever.background);
			Assert.assertEquals("128", retriever.background.width);
		}
		
		[Test(async)]
		public function loadFromInvalidIconPath() : void 
		{
			retriever = new FakeBackgroundRetriever("assets/not_found.png");
			retriever.addEventListener(ErrorEvent.ERROR, Async.asyncHandler(this, handleInvalidIconPathError, 500), false, 0, true);
			retriever.retrieve();
		}
		
		private function handleInvalidIconPathError(event : ErrorEvent, passThroughData : Object) : void
		{
			Assert.assertNull(retriever.background);
		}
	}
}

import de.mattesgroeger.air.icon.background.DefaultBackgroundRetriever;
import de.mattesgroeger.air.icon.background.path.IconPathProvider;

class FakeBackgroundRetriever extends DefaultBackgroundRetriever
{
	private var expectedPath : String;

	public function FakeBackgroundRetriever(expectedPath : String) 
	{
		this.expectedPath = expectedPath;
		
		super();
	}

	override protected function createPathProvider() : IconPathProvider 
	{
		return new FakeIconPathProvider(expectedPath);
	}
}

class FakeIconPathProvider implements IconPathProvider
{
	private var expectedPath : String;
	
	public function FakeIconPathProvider(expectedPath : String) 
	{
		this.expectedPath = expectedPath;
		
		super();
	}

	public function getIconPath() : String
	{
		return expectedPath;
	}
}