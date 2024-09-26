using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Picture
{
    public interface IPictureService : ICRUDService<Model.ViewModels.Picture, PictureSearchObject, PictureInsertRequest, PictureUpdateRequest>
    {
    }
}

