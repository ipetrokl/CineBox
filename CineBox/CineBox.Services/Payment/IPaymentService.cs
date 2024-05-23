using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using Stripe;

namespace CineBox.Services.Payment
{
	public interface IPaymentService : ICRUDService<Model.ViewModels.Payment, PaymentSearchObject, PaymentInsertRequest, PaymentUpdateRequest>
	{
        Task<PaymentIntent> CreatePaymentIntent(decimal amount);
    }
}

