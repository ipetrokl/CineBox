using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.BookingSeat;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class BookingSeatController : BaseCRUDController<Model.ViewModels.BookingSeat, BookingSeatSearchObject, BookingSeatInsertRequest, BookingSeatUpdateRequest>
    {

        public BookingSeatController(IBookingSeatService service) : base(service)
        {

        }
    }
}

