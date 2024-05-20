using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.News
{
    public interface INewsService : ICRUDService<Model.ViewModels.News, NewsSearchObject, NewsInsertRequest, NewsUpdateRequest>
    {
    }
}

