using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Screening;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class ScreeningController : BaseCRUDController<Model.ViewModels.Screening, ScreeningSearchObject, ScreeningInsertRequest, ScreeningUpdateRequest>
    {

        public ScreeningController(IScreeningService service) : base(service)
        {

        }
    }
}

