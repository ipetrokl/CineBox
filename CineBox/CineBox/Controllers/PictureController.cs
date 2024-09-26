using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Picture;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class PictureController : BaseCRUDController<Model.ViewModels.Picture, PictureSearchObject, PictureInsertRequest, PictureUpdateRequest>
    {

        public PictureController(IPictureService service) : base(service)
        {

        }
    }
}

