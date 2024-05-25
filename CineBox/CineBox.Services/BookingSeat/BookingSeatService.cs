using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.BookingSeat
{
    public class BookingSeatService : BaseCRUDService<Model.ViewModels.BookingSeat, Database.BookingSeat, BookingSeatSearchObject, BookingSeatInsertRequest, BookingSeatUpdateRequest>, IBookingSeatService
    {
        public BookingSeatService(ILogger<BaseService<Model.ViewModels.BookingSeat, Database.BookingSeat, BookingSeatSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.BookingSeat> AddFilter(IQueryable<Database.BookingSeat> query, BookingSeatSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.BookingIds != null && search.BookingIds.Any())
            {

                filteredQuery = filteredQuery.Where(x => search.BookingIds.Contains(x.BookingId));
            }

            return filteredQuery;
        }
    }
}

