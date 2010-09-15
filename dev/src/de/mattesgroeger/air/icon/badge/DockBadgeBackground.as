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
package de.mattesgroeger.air.icon.badge
{
	import de.mattesgroeger.air.icon.badge.enum.Direction;
	import de.mattesgroeger.air.icon.badge.enum.SnapMode;

	import flash.display.GradientType;
	import flash.display.GraphicsPathCommand;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class DockBadgeBackground extends Shape 
	{
		public static const CIRCLE_APEX_COUNT : int = 26;
		
		private var targetWidth : int;
		private var targetHeight : int;
		private var snapMode : SnapMode;
		
		private var radius : Number;
		private var staightLineApexCount : Number;
		private var scaleFactor : Number;
		
		private var apexSideLength : Number;
		private var apexHeight : Number;
		private var segmentRadians : Number;
		private var centerPoint : Point;
		private var prevPoint : Point;
		
		private var commands : Vector.<int> = new Vector.<int>();
		private var coords : Vector.<Number> = new Vector.<Number>();
		
		public function DockBadgeBackground(targetWidth : int, targetHeight : int, snapMode : SnapMode) 
		{
			this.targetWidth = targetWidth;
			this.targetHeight = targetHeight;
			this.snapMode = (snapMode == null) ? SnapMode.CEIL : snapMode;
			
			initializeMembers();
			calculateCoords();
			drawBadge();
		}

		private function initializeMembers() : void
		{
			radius = targetHeight / 2;
			
			var segmentAngle : Number = 360 / CIRCLE_APEX_COUNT;
			segmentRadians = segmentAngle * Math.PI / 180;
			apexSideLength = calculateApexLength();
			apexHeight = (apexSideLength / 2 * Math.sqrt(3)); // use isosceles triangles for apex
			
			scaleFactor = targetHeight / (targetHeight + 2 * apexHeight); // scale down to fit into given height
			var staightLineApexCountNonRounded : Number = (targetWidth - targetHeight) / (apexSideLength * scaleFactor);
			staightLineApexCount = (snapMode == SnapMode.FLOOR) ? Math.floor(staightLineApexCountNonRounded) : Math.ceil(staightLineApexCountNonRounded);
		}
		
		private function calculateApexLength() : Number
		{
			var prevPoint : Point = new Point(0, radius);
			var centerPoint : Point = new Point(0, 0);
			
			var nextPoint : Point = calculateNextPointOnCurve(prevPoint, centerPoint);
			var apexSideVector : Point = nextPoint.subtract(prevPoint);
			
			return apexSideVector.length;
		}
		
		private function calculateCoords() : void
		{
			calculateStartCoord();
			calculateCurveCoords(CIRCLE_APEX_COUNT / 2);
			calculateStraightLineCoords(staightLineApexCount, Direction.RIGHT);
			calculateCurveCoords(CIRCLE_APEX_COUNT / 2);
			calculateStraightLineCoords(staightLineApexCount, Direction.LEFT);
		}
		
		private function calculateStartCoord() : void
		{
			centerPoint = new Point(radius + apexHeight, radius + apexHeight);
			prevPoint = centerPoint.add(new Point(0, radius));
			
			pushCoords(prevPoint, GraphicsPathCommand.MOVE_TO);
		}

		private function calculateCurveCoords(count : int) : void
		{
			var nextPoint : Point = new Point();
			var apexPoint : Point = new Point();
			
			for (var j : int = 0; j < count; j++) 
			{
				nextPoint = calculateNextPointOnCurve(prevPoint, centerPoint);
				apexPoint = calculateCurveApexPoint(prevPoint, nextPoint, centerPoint);
				
				pushCoords(apexPoint);
				pushCoords(nextPoint);
				
				prevPoint = nextPoint.clone();
			}
		}
		
		private function calculateStraightLineCoords(count : int, direction : Direction) : void
		{
			var nextPoint : Point = new Point();
			var apexPoint : Point = new Point();
			
			for (var j : int = 0; j < count; j++) 
			{
				nextPoint = prevPoint.add(new Point(apexSideLength * direction.factor, 0));
				apexPoint = calculateStraightLineApexPoint(prevPoint, nextPoint, direction);
				centerPoint = centerPoint.add(new Point(apexSideLength, 0));
				
				pushCoords(apexPoint);
				pushCoords(nextPoint);
				
				prevPoint = nextPoint.clone();
			}
		}

		private function calculateCurveApexPoint(prevPoint : Point, nextPoint : Point, centerPoint : Point) : Point
		{
			var apexHalfSideVector : Point = getApexHalfSideVector(prevPoint, nextPoint);
			var vectorToLastPoint : Point = prevPoint.subtract(centerPoint);
			var vectorToApex : Point = vectorToLastPoint.add(apexHalfSideVector);
			vectorToApex.normalize(vectorToLastPoint.length + apexHeight);
			vectorToApex = vectorToApex.add(centerPoint);
			
			return vectorToApex;
		}
		
		private function calculateStraightLineApexPoint(prevPoint : Point, nextPoint : Point, direction : Direction) : Point
		{
			var apexHalfSideVector : Point = getApexHalfSideVector(prevPoint, nextPoint);
			var apexHeightVector : Point = new Point(0, -1 * direction.factor);
			apexHeightVector.normalize(apexHeight);
			
			return prevPoint.add(apexHalfSideVector.add(apexHeightVector));
		}
		
		private function getApexHalfSideVector(prevPoint : Point, nextPoint : Point) : Point
		{
			var apexHalfSideVector : Point = nextPoint.subtract(prevPoint);
			apexHalfSideVector.x /= 2;
			apexHalfSideVector.y /= 2;
			
			return apexHalfSideVector;
		}

		private function calculateNextPointOnCurve(prevPoint : Point, centerPoint : Point) : Point
		{
			var newPoint : Point = new Point();
			
			newPoint.x = (prevPoint.x - centerPoint.x) * Math.cos(segmentRadians) - (prevPoint.y - centerPoint.y) * Math.sin(segmentRadians) + centerPoint.x;
			newPoint.y = (prevPoint.x - centerPoint.x) * Math.sin(segmentRadians) + (prevPoint.y - centerPoint.y) * Math.cos(segmentRadians) + centerPoint.y;
			
			return newPoint;
		}

		private function pushCoords(prevPoint : Point, command : int = 2) : void
		{
			commands.push(command);
			coords.push(prevPoint.x * scaleFactor, prevPoint.y * scaleFactor);
		}
		
		private function drawBadge() : void
		{
			var matrix : Matrix = new Matrix();
			matrix.createGradientBox(targetWidth, targetHeight, Math.PI/4, 0, 0); 
			
			graphics.beginGradientFill(GradientType.LINEAR, [0xcd3c1e, 0xcd3c1e], [1, 1], [100, 255], matrix);
			graphics.drawPath(commands, coords);
			graphics.endFill();
		}
	}
}