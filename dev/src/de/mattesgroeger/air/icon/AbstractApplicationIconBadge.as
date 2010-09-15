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
	import de.mattesgroeger.air.icon.background.BackgroundRetriever;
	import de.mattesgroeger.air.icon.background.DefaultBackgroundRetriever;
	import de.mattesgroeger.air.icon.event.UpdateErrorEvent;
	import de.mattesgroeger.air.icon.event.InformationType;

	import flash.events.ErrorEvent;
	import flash.events.Event;

	public class AbstractApplicationIconBadge extends AbstractIconBadge 
	{
		protected var backgroundRetriever : BackgroundRetriever;
		
		private var backgroundLoaded : Boolean;
		
		public function AbstractApplicationIconBadge()
		{
			backgroundRetriever = createBackgroundRetriever();
			
			super();
			
			initializeBackgroundRetriever();
		}
		
		protected function createBackgroundRetriever() : BackgroundRetriever 
		{
			return new DefaultBackgroundRetriever();
		}

		protected function initializeBackgroundRetriever() : void 
		{
			backgroundRetriever.addEventListener(Event.COMPLETE, handleBackgroundRetrieved, false, 0, true);
			backgroundRetriever.addEventListener(ErrorEvent.ERROR, handleBackgroundError, false, 0, true);
			backgroundRetriever.retrieve();
		}

		protected override function skipRedraw() : void 
		{
			if (backgroundLoaded)
				dispatchError(UpdateErrorEvent.UPDATE_ERROR, "Icon could not be updated. Maybe no valid custom icon has been defined. The icon is required in order to display the badge label. Make sure to assign a valid customIcon or a valid application icon in the descriptor file of your Air application.");
			else
				dispatchInformation(InformationType.NO_DEFAULT_ICON_LOADED_YET);
			
			invalidated = true;
		}

		private function handleBackgroundError(event : ErrorEvent) : void 
		{
			backgroundLoaded = true;
			
			var information : InformationType = InformationType.DEFAULT_ICON_LOADING_FAILURE;
			information.setExpression("message", event.text);
			
			dispatchInformation(information);
			
			if (invalidated)
				redraw();
		}

		private function handleBackgroundRetrieved(event : Event) : void 
		{
			backgroundLoaded = true;
			assembler.defaultBackground = backgroundRetriever.background;
			
			dispatchInformation(InformationType.DEFAULT_ICON_LOADED);
			
			if (invalidated)
				redraw();
		}
	}
}