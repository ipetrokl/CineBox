using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using CineBox.Services.StateMachine;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Cinema
{
    public class CinemaService : BaseCRUDService<Model.ViewModels.Cinema, Database.Cinema, CinemaSearchObject, CinemaInsertRequest, CinemaUpdateRequest>, ICinemaService
    {
        public CinemaService(ILogger<BaseService<Model.ViewModels.Cinema, Database.Cinema, CinemaSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
            
        }
    }
}

