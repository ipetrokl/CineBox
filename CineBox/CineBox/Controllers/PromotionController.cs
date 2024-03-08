using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Promotion;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class PromotionController : BaseCRUDController<Model.ViewModels.Promotion, PromotionSearchObject, PromotionInsertRequest, PromotionUpdateRequest>
    {

        public PromotionController(IPromotionService service) : base(service)
        {

        }
    }
}

