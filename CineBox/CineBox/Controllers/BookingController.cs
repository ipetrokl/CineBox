using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Booking;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class BookingController : BaseCRUDController<Model.ViewModels.Booking, BookingSearchObject, BookingInsertRequest, BookingUpdateRequest>
    {

        public BookingController(IBookingService service) : base(service)
        {

        }
    }
}

