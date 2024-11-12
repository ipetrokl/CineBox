using System;
using CineBox.Model.Reports;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Hall;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class HallController : BaseCRUDController<Model.ViewModels.Hall, HallSearchObject, HallInsertRequest, HallUpdateRequest>
    {
        private readonly IHallService _hallService;

        public HallController(IHallService service) : base(service)
        {
            _hallService = service;
        }

        [HttpGet("occupancy")]
        public async Task<List<HallOccupancyReport>> GetHallOccupancyReport([FromQuery] DateTime selectedDate, [FromQuery] int cinemaId)
        {
            return await _hallService.GetHallOccupancyReportAsync(selectedDate, cinemaId);
        }
    }
}

