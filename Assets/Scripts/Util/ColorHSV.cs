// ColorHSV
// by Matthew
// http://forum.unity3d.com/threads/12031-create-random-colors?p=84625&viewfull=1#post84625
// converted to C# by Deozaan

using UnityEngine;

// A color in HSV space
class ColorHSV {

	private float _h = 0f;
	private float _s = 0f;
	private float _v = 0f;
	private float _a = 0f;

	// Construct with optional alpha (which defaults to 1)
	public ColorHSV(float h, float s, float v, float a) {
		this._h = h;
		this._s = s;
		this._v = v;
		this._a = a;
	}


	// Create from an RGBA color object
	public ColorHSV(Color color) {
		float min = Mathf.Min(Mathf.Min(color.r, color.g), color.b);
		float max = Mathf.Max(Mathf.Max(color.r, color.g), color.b);
		float delta = max - min;

		// value is our max color
		this._v = max;

		// saturation is percent of max
		if (!Mathf.Approximately(max, 0))
			this._s = delta / max;
		else {
			// all colors are zero, no saturation and hue is undefined
			this._s = 0;
			this._h = -1;
			return;
		}

		// grayscale image if min and max are the same
		if (Mathf.Approximately(min, max)) {
			this._v = max;
			this._s = 0;
			this._h = -1;
			return;
		}

		// hue depends which color is max (this creates a rainbow effect)
		if (color.r == max)
			this._h = (color.g - color.b) / delta;// between yellow & magenta
		else if (color.g == max)
			this._h = 2 + (color.b - color.r) / delta; // between cyan & yellow
		else
			this._h = 4 + (color.r - color.g) / delta; // between magenta & cyan

		// turn hue into 0-360 degrees
		this._h *= 60;
		if (this._h < 0)
			this._h += 360;
	}

	// Return an RGBA color object
	public Color ToColor() {
		// no saturation, we can return the value across the board (grayscale)
		if (this._s == 0)
			return new Color(this._v, this._v, this._v, this._a);

		// which chunk of the rainbow are we in?
		float sector = this._h / 60;
		// split across the decimal (ie 3.87 into 3 and 0.87)
		int i;
		i = (int)Mathf.Floor(sector);
		float f = sector - i;

		float v = this._v;
		float p = v * (1 - _s);
		float q = v * (1 - _s * f);
		float t = v * (1 - _s * (1 - f));

		// build our rgb color
		Color color = new Color(0, 0, 0, this._a);

		switch (i) {
			case 0:
				color.r = v;
				color.g = t;
				color.b = p;
				break;
			case 1:
				color.r = q;
				color.g = v;
				color.b = p;
				break;
			case 2:
				color.r = p;
				color.g = v;
				color.b = t;
				break;
			case 3:
				color.r = p;
				color.g = q;
				color.b = v;
				break;
			case 4:
				color.r = t;
				color.g = p;
				color.b = v;
				break;
			default:
				color.r = v;
				color.g = p;
				color.b = q;
				break;
		}

		return color;
	}

	// Format nicely
	new public string ToString() {
		return string.Format("h: {0:0.00}, s: {1:0.00}, v: {2:0.00}, a: {3:0.00}", _h, _s, _v, _a);
	}
}
