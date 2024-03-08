using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Booking
{
    public class BookingService : BaseCRUDService<Model.ViewModels.Booking, Database.Booking, BookingSearchObject, BookingInsertRequest, BookingUpdateRequest>, IBookingService
    {
        public BookingService(ILogger<BaseService<Model.ViewModels.Booking, Database.Booking, BookingSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

