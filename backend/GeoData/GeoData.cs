using System;
using System.Configuration;
using Npgsql;
using Microsoft.EntityFrameworkCore;
using System.Reflection.Metadata;

namespace GeoData
{
	public class GeoData: DbContext
	{
        public DbSet<GeoJSON> Data { get; set; }
        public GeoData(DbContextOptions<GeoData> options)
            : base(options)
        {
        }
	}
}