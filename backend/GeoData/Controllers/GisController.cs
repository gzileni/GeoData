using Microsoft.AspNetCore.Mvc;

namespace GeoData.Controllers;

[ApiController]
[Route("[controller]")]
public class GisController : ControllerBase
{
    private readonly IConfiguration? _configuration;

    private readonly ILogger<GisController> _logger;

    public GisController(ILogger<GisController> logger)
    {
        _logger = logger;
    }

    [HttpGet(Name = "GetGis")]
    public IEnumerable<GisController> Get()
    {
        GeoDB gis = new(this._configuration.GetValue<string>("ConnectionStrings:GeoDB"));
        return gis.connectionUri;
    }


}

