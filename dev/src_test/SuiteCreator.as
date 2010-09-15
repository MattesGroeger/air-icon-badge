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
package  
{
	import de.mattesgroeger.air.icon.TestAbstractApplicationIconBadge;
	import de.mattesgroeger.air.icon.TestAbstractIconBadge;
	import de.mattesgroeger.air.icon.TestAirIconBadge;
	import de.mattesgroeger.air.icon.assembler.TestIconAssembler;
	import de.mattesgroeger.air.icon.background.TestBackgroundRetriever;
	import de.mattesgroeger.air.icon.background.path.TestDescriptorIconPathRetriever;
	import de.mattesgroeger.air.icon.badge.TestDockBadge;
	import de.mattesgroeger.air.icon.badge.TestDockBadgeBackground;
	import de.mattesgroeger.air.icon.badge.TestDockBadgeLabel;
	import de.mattesgroeger.air.icon.builder.TestDockIconBuilder;
	import de.mattesgroeger.air.icon.builder.TestNullIconBuilder;
	import de.mattesgroeger.air.icon.event.TestInformationEvent;
	import de.mattesgroeger.air.icon.event.TestInformationType;
	import de.mattesgroeger.air.icon.updater.TestDockIconUpdater;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SuiteCreator
	{
		public var iconAssembler : TestIconAssembler;
		
		public var dockBadgeBackground : TestDockBadgeBackground;
		public var dockBadgeLabel : TestDockBadgeLabel;
		public var dockBadge : TestDockBadge;
		
		public var descriptorIconPathRetriever : TestDescriptorIconPathRetriever;
		public var backgroundRetriever : TestBackgroundRetriever;
		
		public var dockIconBuilder : TestDockIconBuilder;
		public var nullIconBuilder : TestNullIconBuilder;
		
		public var informationEvent : TestInformationEvent;
		public var informationType : TestInformationType;
		
		public var dockIconUpdater : TestDockIconUpdater;
		
		public var abstractApplicationBadgeIcon : TestAbstractApplicationIconBadge;
		public var abstractIconBadge : TestAbstractIconBadge;
		public var icon : TestAirIconBadge;
	}
}