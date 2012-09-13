/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-08-31
 @last-edit		2012-08-31
===============================================================================
*/
using UnityEngine;

/// <summary>
/// Representation of 2D vectors and points.
/// Useful when working with integers such as when working with
/// textures, grids, etc.
/// </summary>
public class IntVector2
{
	/// <summary>
	/// Horizontal component of the vector
	/// </summary>
    public int x;
	
	/// <summary>
	/// Vertical component of the vector
	/// </summary>
    public int y;
	
	/// <summary>
	/// Access the x or y component using [0] or [1] respectively
	/// </param>
	public int this[int index]{ get { return index == 0 ? x : y; } }
	
	/// <summary>
	/// Returns this vector with a magnitude of 1 (Read Only)
	/// </summary>
	public IntVector2 	normalized 	 { get { return new IntVector2(x / sqrMagnitude, y / sqrMagnitude); } }
	
	/// <summary>
	/// Returns the length of this vector (Read Only)
	/// </summary>
	public float 		magnitude 	 { get { return Mathf.Sqrt( x * x + y * y ); }  }
	
	/// <summary>
	/// Returns the squared length of this vector (Read Only)
	/// </summary>
	public int 		sqrMagnitude { get { return  x * x + y * y; }  }
	
		/// <summary>
	/// Constructs a new vector with given int x, y components
	/// </summary>
	public IntVector2(int x, int y){
		this.x = x;
		this.y = y;
	}
	
	/// <summary>
	/// Constructs a new vector with given float x, y components
	/// float values are truncated on construction
	/// </summary>
	public IntVector2(float x, float y){
		this.x = (int)( x );
		this.y = (int)( y );
	}
	
	/// <summary>
	/// Constructs a new vector with given Vector2
	/// float values are truncated on construction
	/// </summary>
	public IntVector2(Vector2 v){
		this.x = (int)( v.x );
		this.y = (int)( v.y );
	}
	
	/// <summary>
	/// Set x and y components of an existing IntVector2
	/// </summary>
	public void Set(int x, int y) {
        this.x = x;
		this.y = y;
    }
	
	/// <summary>
	/// Set x and y components of an existing IntVector2
	/// </summary>
	public void Scale(IntVector2 v) {
        x *= v.x;
		y *= v.y;
    }
	
	/// <summary>
	/// Makes this vector have a magnitude of 1
	/// </summary>
	public void Normalize(){
		float m = sqrMagnitude;
		x = (int)(x / m);
		y = (int)(y / m);
	}
	
	/// <summary>
	/// Returns a nicely formatted string for this vector
	/// </summary>
	override public string ToString() {
        return "[" + x + " " + y + "]";
    }
	
	/// <summary>
	/// Used to interact with code that needs a Vector2
	/// Use with care, as each call will return a new instance
	/// Don't call this in tight loops
	/// </summary>
	public Vector2 ToVector2() {
        return new Vector2(x, y);
    }
	
	/// <summary>
	/// Determines whether the specified <see cref="IntVector2"/> is equal to the current <see cref="AngryMole.IntVector2"/>.
	/// </summary>
	/// <param name='v'>
	/// The <see cref="IntVector2"/> to compare with the current <see cref="AngryMole.IntVector2"/>.
	/// </param>
	/// <returns>
	/// <c>true</c> if the specified <see cref="IntVector2"/> is equal to the current <see cref="AngryMole.IntVector2"/>;
	/// otherwise, <c>false</c>.
	/// </returns>
	public bool Equals(IntVector2 v){
		return v.x == x && v.y == y;
	}
	/// <summary>
	/// Determines whether the specified <see cref="IntVector2"/> is equal to the current <see cref="AngryMole.IntVector2"/>.
	/// </summary>
	/// <param name='v'>
	/// The <see cref="IntVector2"/> to compare with the current <see cref="AngryMole.IntVector2"/>.
	/// </param>
	/// <returns>
	/// <c>true</c> if the specified <see cref="IntVector2"/> is equal to the current <see cref="AngryMole.IntVector2"/>;
	/// otherwise, <c>false</c>.
	/// </returns>
	public override bool Equals(System.Object obj)
    {
        // If parameter is null return false.
        if (obj == null){
            return false;
        }

        // If parameter cannot be cast to IntVector2 return false.
        IntVector2 v = obj as IntVector2;
        if ((System.Object)v == null){
            return false;
        }

        // Return true if the fields match:
        return (x == v.x) && (y == v.y);
    }
	
	/// <summary>
	/// Create an identifier for the current vector
	/// </summary>
	public override int GetHashCode()
    {
        return x ^ y;
    }

	/// <summary>
	/// Shorthand for writing IntVector2(0, 0)
	/// </summary>
	public static IntVector2 zero 	{ get { return new IntVector2(0, 0);  } }

	/// <summary>
	/// Shorthand for writing IntVector2(1, 1)
	/// </summary>
	public static IntVector2 one 	{ get { return new IntVector2(1, 1);  } }
	
	/// <summary>
	/// Shorthand for writing IntVector2(-1, 0)
	/// </summary>
	public static IntVector2 left 	{ get { return new IntVector2(-1, 0); } }
	
	/// <summary>
	/// Shorthand for writing IntVector2(0, -1)
	/// </summary>
	public static IntVector2 up 	{ get { return new IntVector2(0, -1); } }
	
	/// <summary>
	/// Shorthand for writing IntVector2(1, 0)
	/// </summary>
	public static IntVector2 right	{ get { return new IntVector2(1, 0);  } }
	
	/// <summary>
	/// Shorthand for writing IntVector2(0, 1)
	/// </summary>
	public static IntVector2 down 	{ get { return new IntVector2(0, 1);  } }
	
	/// <summary>
	/// Multiplies two vectors component-wise
	/// Every component in the result is a component of a multiplied by the same component of b
	/// </summary>
	public static IntVector2 Scale(IntVector2 a, IntVector2 b) {
        return new IntVector2( a.x * b.x, a.y * b.y );
    }
	
	/// <summary>
	/// Linearly interpolates between two vectors.
	/// Interpolates between from and to by amount t.
	/// t is clamped between [0...1]. When t = 0 returns from. 
	/// When t = 1 returns to. When t = 0.5 returns the average of from and to.
	/// </summary>
	public static IntVector2 Lerp(IntVector2 a, IntVector2 b, float t) {
		if( t < 0 ){
			return a;
		} else if( t > 1 ){
			return b;
		} else {
			return new IntVector2( a.x * t + b.x * (1 - t), a.y * t + b.y * (1 - t));
		}
    }
	
	/// <summary>
	/// Dot Product of two vectors
	/// 
	/// For normalized vectors Dot returns 1 if they point in exactly the same direction; 
	/// -1 if they point in completely opposite directions; 
	/// and a number in between for other cases (e.g. Dot returns zero if vectors are perpendicular).
	/// 
	/// For vectors of arbitrary length the Dot return values are similar: 
	/// they get larger when the angle between vectors decreases.
	/// </summary>
	public static float Dot(IntVector2 a, IntVector2 b) {
		return a.x * b.x + a.y * b.y;
    }
	
	/// <summary>
	/// Returns a vector that is made from the smallest components of two vectors.
	/// </summary>
	public static IntVector2 Min(IntVector2 a, IntVector2 b) {
		return new IntVector2(a.x < b.x ? a.x : b.x, a.y < b.y ? a.y : b.y );
    }
	
	/// <summary>
	/// Returns a vector that is made from the largest components of two vectors.
	/// </summary>
	public static IntVector2 Max(IntVector2 a, IntVector2 b) {
		return new IntVector2(a.x > b.x ? a.x : b.x, a.y > b.y ? a.y : b.y );
    }
	
	/// <summary>
	/// Adds two vectors
	/// </returns>
	public static IntVector2 operator +(IntVector2 a, IntVector2 b){
		return new IntVector2(a.x + b.x, a.y + b.y);
    }
	
	/// <summary>
	/// Subtracts one vector from another
	/// </returns>
	public static IntVector2 operator -(IntVector2 a, IntVector2 b){
		return new IntVector2(a.x - b.x, a.y - b.y);
    }
	
	/// <summary>
	/// Multiplies a vector by an int
	/// </returns>
	public static IntVector2 operator *(IntVector2 a, int b){
		return new IntVector2(a.x * b, a.y * b);
    }
	
	/// <summary>
	/// Multiplies a vector by an int
	/// </returns>
	public static IntVector2 operator *(int a, IntVector2 b){
		return new IntVector2(a * b.x, a * b.y);
    }
	
	/// <summary>
	/// Multiplies a vector by a float
	/// </returns>
	public static IntVector2 operator *(IntVector2 a, float b){
		return new IntVector2(a.x * b, a.y * b);
    }
	
	/// <summary>
	/// Multiplies a vector by a float
	/// </returns>
	public static IntVector2 operator *(float a, IntVector2 b){
		return new IntVector2(a * b.x, a * b.y);
    }
	
	/// <summary>
	/// Divides a vector by a number
	/// Divides each component of a by an int d
	/// </returns>
	public static IntVector2 operator /(IntVector2 a, int d){
		return new IntVector2(a.x / d, a.y / d);
    }
	
	/// <summary>
	/// Divides a vector by a number
	/// Divides each component of a by a float d
	/// </returns>
	public static IntVector2 operator /(IntVector2 a, float d){
		return new IntVector2(a.x / d, a.y / d);
    }
	
	/// <summary>
	/// Returns true if the vectors are equal
	/// </returns>
	public static bool operator ==(IntVector2 a, IntVector2 b){
		return a.x == b.x && a.y == b.y;
    }
	
	/// <summary>
	/// Returns true if the vectors are different
	/// </returns>
	public static bool operator !=(IntVector2 a, IntVector2 b){
		return a.x != b.x || a.y != b.y;
    }

}
