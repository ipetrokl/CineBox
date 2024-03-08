using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Promotion
{
	public interface IPromotionService : ICRUDService<Model.ViewModels.Promotion, PromotionSearchObject, PromotionInsertRequest, PromotionUpdateRequest>
	{
	}
}

