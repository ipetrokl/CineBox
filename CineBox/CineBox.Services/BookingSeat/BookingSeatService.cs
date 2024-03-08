using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.BookingSeat
{
    public class BookingSeatService : BaseCRUDService<Model.ViewModels.BookingSeat, Database.BookingSeat, BookingSeatSearchObject, BookingSeatInsertRequest, BookingSeatUpdateRequest>, IBookingSeatService
    {
        public BookingSeatService(ILogger<BaseService<Model.ViewModels.BookingSeat, Database.BookingSeat, BookingSeatSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

