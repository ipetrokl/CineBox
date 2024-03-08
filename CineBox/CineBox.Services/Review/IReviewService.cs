using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Review
{
	public interface IReviewService : ICRUDService<Model.ViewModels.Review, ReviewSearchObject, ReviewInsertRequest, ReviewUpdateRequest>
	{
		
	}
}

