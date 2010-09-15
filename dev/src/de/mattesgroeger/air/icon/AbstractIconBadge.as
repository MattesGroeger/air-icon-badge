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
	import de.mattesgroeger.air.icon.assembler.IconAssembler;
	import de.mattesgroeger.air.icon.assembler.DefaultIconAssembler;
	import de.mattesgroeger.air.icon.builder.IconBuilder;
	import de.mattesgroeger.air.icon.builder.NullIconBuilder;
	import de.mattesgroeger.air.icon.event.InformationEvent;
	import de.mattesgroeger.air.icon.event.InformationType;
	import de.mattesgroeger.air.icon.updater.IconUpdater;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;

	[Event(name="information", type="de.mattesgroeger.air.icon.event.InformationEvent")]
	[Event(name="updateError", type="de.mattesgroeger.air.icon.event.UpdateErrorEvent")]
	public class AbstractIconBadge extends EventDispatcher implements IconBadge
	{
		protected var updater : IconUpdater;
		protected var assembler : IconAssembler;
		protected var invalidated : Boolean;
		
		public function AbstractIconBadge()
		{
			updater = createIconUpdater();
			assembler = createIconAssembler();
			
			initializeUpdater();
		}

		[Bindable]
		public function set label(label : String) : void
		{
			assembler.label = label;
			
			redraw();
		}

		public function get label() : String
		{
			return assembler.label;
		}

		[Bindable]
		public function set customIcon(icon : Bitmap) : void
		{
			assembler.customBackground = icon;
			
			redraw();
		}

		public function get customIcon() : Bitmap
		{
			return assembler.customBackground;
		}
		
		public function clearLabel() : void
		{
			label = null;
			
			redraw();
		}
		
		public function clearCustomIcon() : void
		{
			assembler.customBackground = null;
			
			redraw();
		}
		
		protected function createIconUpdater() : IconUpdater 
		{
			throw new IllegalOperationError("abstract method should be implemented");
		}

		protected function createIconAssembler() : IconAssembler 
		{
			var iconBuilder : IconBuilder = createIconBuilder();
			
			if (iconBuilder is NullIconBuilder)
				dispatchInformation(InformationType.NO_VALID_ICON_BUILDER_FOUND);
			
			return new DefaultIconAssembler(iconBuilder);
		}
		
		protected function createIconBuilder() : IconBuilder 
		{
			throw new IllegalOperationError("abstract method should be implemented");
		}
		
		protected function redraw() : void
		{
			if (updater.canUpdate() && assembler.canAssemble())
				proceedRedraw();
			else
				skipRedraw();
		}
		
		protected function proceedRedraw() : void 
		{
			invalidated = false;
			
			var icon : BitmapData = assembler.assemble();
			updater.update(icon);
			
			dispatchInformation(InformationType.ICON_UPDATED);
		}
		
		protected function skipRedraw() : void 
		{
			dispatchError(UpdateErrorEvent.UPDATE_ERROR, "Icon could not be updated. Maybe no custom icon has been defined. The icon is required in order to display the badge label on top of it.");
			
			invalidated = true;
		}

		protected function dispatchInformation(information : InformationType) : void 
		{
			dispatchEvent(new InformationEvent(InformationEvent.INFORMATION, information));
		}

		protected function dispatchError(type : String, message : String) : void 
		{
			dispatchEvent(new UpdateErrorEvent(type, message));
		}

		private function initializeUpdater() : void 
		{
			if (!updater.canUpdate())
				dispatchInformation(InformationType.OPERATING_SYSTEM_NOT_SUPPORTED);
		}
	}
}