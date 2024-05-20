using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.News;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class NewsController : BaseCRUDController<Model.ViewModels.News, NewsSearchObject, NewsInsertRequest, NewsUpdateRequest>
    {

        public NewsController(INewsService service) : base(service)
        {

        }
    }
}

