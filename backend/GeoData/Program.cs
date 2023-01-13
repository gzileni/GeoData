using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using GeoData;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.col[col.Count - 1]

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

// Console.WriteLine($"Provider: {gdata.Database.ProviderName}");

app.Run();

