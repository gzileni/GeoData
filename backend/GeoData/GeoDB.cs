using System;
using System.Configuration;
using Npgsql;
using Microsoft.EntityFrameworkCore;

namespace GeoData
{
	public partial class GeoDB
	{
        public string? connectionUri { get; private set; }
        public GeoDB(string? connection)
		{
			this.connectionUri = connection;
			Console.WriteLine($"Connection: {this.connectionUri}");
		}

    }
}