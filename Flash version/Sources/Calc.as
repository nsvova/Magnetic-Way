package  
{
	import adobe.utils.CustomActions;
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Calc 
	{
		
		static private var maxVector:b2Vec2 = new b2Vec2(0, 7);

		
		public function Calc() 
		{
			
		}
		
		static public function CreateVector(x_begin:Number, y_begin:Number, x_end:Number, y_end:Number):b2Vec2
		{
			return new b2Vec2(x_end - x_begin, y_end - y_begin);
		}
		
		
		
		static public function CreateVectorVelocity(mouse_x:Number, mouse_y:Number, personVec:b2Vec2):b2Vec2
		{
			var length:Number = 0;
			
			mouse_y = -mouse_y;
			personVec.y = -personVec.y;
			
			length = Math.sqrt(maxVector.x * maxVector.x + maxVector.y * maxVector.y);
			
			var vec:b2Vec2 = CreateVector(personVec.x, personVec.y, mouse_x, mouse_y);
			
			var _alpha:Number = alpha(maxVector, vec);
			
			var result:b2Vec2 = new b2Vec2(0, 0);
			
			var co:Number = Math.cos(_alpha);
			
			result.y = length *co;
			
			var y:Number = result.y;
			
			result.x = Math.sqrt( length * length - (y) * (y) );
			
			if (personVec.x > mouse_x) result.x = - result.x;
			result.y = - result.y;
			
			return result;
			
		}
		
		
		
		static public function CreateVectorVelocityWithEnergy(mouse_x:Number, mouse_y:Number, personVec:b2Vec2, maxEnergy:int, energy:int ):b2Vec2
		{
			var delta:int = (maxEnergy - energy) * 20;
			maxVector.y = maxVector.y - delta * maxVector.y / 100; 
			
			var length:Number = 0;
			
			mouse_y = -mouse_y;
			personVec.y = -personVec.y;
			
			length = Math.sqrt(maxVector.x * maxVector.x + maxVector.y * maxVector.y);
			
			var vec:b2Vec2 = CreateVector(personVec.x, personVec.y, mouse_x, mouse_y);
			
			var _alpha:Number = alpha(maxVector, vec);
			
			var result:b2Vec2 = new b2Vec2(0, 0);
			
			var co:Number = Math.cos(_alpha);
			
			result.y = length *co;
			
			var y:Number = result.y;
			
			result.x = Math.sqrt( length * length - (y) * (y) );
			
			if (personVec.x > mouse_x) result.x = - result.x;
			result.y = - result.y;
			
			maxVector.y = 7;
			
			return result;
			
		}
		
		
		static public function CreateVectorVelocityWithMaxVector(where:b2Vec2, personVec:b2Vec2, _maxVector:b2Vec2):b2Vec2
		{
			var length:Number = 0;
			
			where.y = -where.y;
			personVec.y = -personVec.y;
			
			length = Math.sqrt(_maxVector.x * _maxVector.x + _maxVector.y * _maxVector.y);
			
			var vec:b2Vec2 = CreateVector(personVec.x, personVec.y, where.x, where.y);
			
			var _alpha:Number = alpha(_maxVector, vec);
			
			var result:b2Vec2 = new b2Vec2(0, 0);
			
			var co:Number = Math.cos(_alpha);
			
			result.y = length *co;
			
			var y:Number = result.y;
			
			result.x = Math.sqrt( length * length - (y) * (y) );
			
			if (personVec.x > where.x) result.x = - result.x;
			result.y = - result.y;
			
			return result;
		}
		
		
		static public function isObjectInCircle(objectVec:b2Vec2, circleVec:b2Vec2, radius:Number):Boolean
		{
			/*if ( (objectVec.x >= (circleVec.x - radius) ) && (objectVec.y >= (circleVec.y - radius) ) &&
				 (objectVec.x <= (circleVec.x + radius) ) && (objectVec.y <= (circleVec.y + radius) ) )
				  {return true;}*/
				  
			if (Math.sqrt( (objectVec.x - circleVec.x)*(objectVec.x - circleVec.x) + ( objectVec.y - circleVec.y)*( objectVec.y - circleVec.y) ) <=
					radius )
					 return true;
			
			return false;
		}
		

		
		static public function alpha(vec1:b2Vec2, vec2:b2Vec2):Number
		{
			if (vec1.x == vec2.x) return 0;
			
			var _alpha:Number = Math.acos((vec1.x * vec2.x + vec1.y * vec2.y) / (Math.sqrt(vec1.x * vec1.x + vec1.y * vec1.y) * Math.sqrt(vec2.x * vec2.x + vec2.y * vec2.y) ) )
			return _alpha;
		}
		
		
		static public function CMeterToPixel(vec:b2Vec2, _worldScale:Number):b2Vec2
		{
			
			var newVec:b2Vec2 = new b2Vec2(vec.x, vec.y);
			
			newVec.x *= _worldScale;
			newVec.y *= _worldScale;
			
			return newVec;
		}
		
		static public function CPixelToMeter(x:Number, y:Number , _worldScale:Number):b2Vec2
		{
			var vec:b2Vec2 = new b2Vec2(x, y);
			vec.x /= _worldScale;
			vec.y /= _worldScale;
			
			return vec;
		}
		
		static public function GetDistanse(vec1:b2Vec2, vec2:b2Vec2):Number 
		{
			var result:Number = Math.sqrt( (vec1.x - vec2.x) * (vec1.x - vec2.x) + (vec1.y - vec2.y) * (vec1.y - vec2.y) );
			return result;
		}
		
	}

}