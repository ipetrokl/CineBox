using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Seat
{
    public class SeatService : BaseCRUDService<Model.ViewModels.Seat, Database.Seat, SeatSearchObject, SeatInsertRequest, SeatUpdateRequest>, ISeatService
    {
        public SeatService(ILogger<BaseService<Model.ViewModels.Seat, Database.Seat, SeatSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}