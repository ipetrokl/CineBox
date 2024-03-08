using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Review;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class ReviewController : BaseCRUDController<Model.ViewModels.Review, ReviewSearchObject, ReviewInsertRequest, ReviewUpdateRequest>
    {

        public ReviewController(IReviewService service) : base(service)
        {

        }
    }
}

