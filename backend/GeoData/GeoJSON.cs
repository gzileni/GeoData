using System;
namespace GeoData
{
	public class GeoJSON
	{
        public string? type { get; set; }
        public Feature[]? features { get; set; }
	}

    public class Properties
    {
    }

    public class Geometry
    {
        public string? type { get; set; }
        public List<List<List<double>>>? coordinates { get; set; }
    }

    public class Feature
    {
        public string? type { get; set; }
        public Properties? properties { get; set; }
        public Geometry? geometry { get; set; }
    }

}



