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
        private readonly IPaymentService _paymentService;

        public PaymentController(IPaymentService service) : base(service)
        {
            _paymentService = service;
        }

        [HttpPost("create-payment-intent")]
        public async Task<IActionResult> CreatePaymentIntent([FromBody] PaymentRequest request)
        {
            var paymentIntent = await _paymentService.CreatePaymentIntent(request.Amount);
            return Ok(new { clientSecret = paymentIntent.ClientSecret });
        }
    }

    public class PaymentRequest
    {
        public decimal Amount { get; set; }
    }
}

