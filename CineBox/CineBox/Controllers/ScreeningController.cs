using System;
using CineBox.Model.Reports;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Screening;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class ScreeningController : BaseCRUDController<Model.ViewModels.Screening, ScreeningSearchObject, ScreeningInsertRequest, ScreeningUpdateRequest>
    {
        private readonly IScreeningService _screnningService;

        public ScreeningController(IScreeningService service) : base(service)
        {
            _screnningService = service;
        }

        [HttpGet("termins")]
        public async Task<List<ScreeningBookingReport>> GetTopScreeningTimesAsync()
        {
            return await _screnningService.GetTopScreeningTimesAsync();
        }
    }
}

