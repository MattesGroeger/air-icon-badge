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
	
	import flexunit.framework.Assert;

	public class TestInformationType 
	{
		private static const EXPRESSION_MESSAGE : String = "start ${expression} end";
		
		private var information : InformationType;

		[Before]
		public function before() : void 
		{
			information = new InformationType(0, EXPRESSION_MESSAGE);
		}

		[Test]
		public function construction() : void 
		{
			var information : InformationType = new InformationType(0, "test");
			
			Assert.assertEquals("0", information.code);
			Assert.assertEquals("test", information.message);
		}

		[Test]
		public function setExpression() : void 
		{
			information.setExpression("expression", "middle");
			
			Assert.assertEquals("start middle end", information.message);
		}

		[Test]
		public function setExpressionMissmatch() : void 
		{
			information.setExpression("expressio", "middle");
			
			Assert.assertEquals(EXPRESSION_MESSAGE, information.message);
		}

		[Test]
		public function setExpressionMultiAssignment() : void 
		{
			information.setExpression("expression", "middle");
			information.setExpression("expression", "center");
			
			Assert.assertEquals("start middle end", information.message);
		}
	}
}