using System.Data.Common;

namespace GeoData;

public class Gis
{
    public DateOnly Date { get; set; }

    public int TemperatureC { get; set; }

    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);

    public string? Summary { get; set; }

    public async Task getListGis ()
    {
        
    }
}

