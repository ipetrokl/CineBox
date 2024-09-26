using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Picture
{
    public class PictureService : BaseCRUDService<Model.ViewModels.Picture, Database.Picture, PictureSearchObject, PictureInsertRequest, PictureUpdateRequest>, IPictureService
    {
        public PictureService(ILogger<BaseService<Model.ViewModels.Picture, Database.Picture, PictureSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

