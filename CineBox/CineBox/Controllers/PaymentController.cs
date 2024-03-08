using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Payment;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class PaymentController : BaseCRUDController<Model.ViewModels.Payment, PaymentSearchObject, PaymentInsertRequest, PaymentUpdateRequest>
    {

        public PaymentController(IPaymentService service) : base(service)
        {

        }
    }
}

