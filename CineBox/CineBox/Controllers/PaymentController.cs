using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Payment;
using Microsoft.AspNetCore.Mvc;
using PayPal.Api;

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

        [HttpPost("create-paypal-payment")]
        public async Task<IActionResult> CreatePayPalPayment([FromBody] PaymentRequest request)
        {
            var payment = await _paymentService.CreatePayPalPayment(request.Amount, "https://your-redirect-url/success", "https://your-redirect-url/cancel");
            return Ok(payment);
        }
    }

    public class PaymentRequest
    {
        public decimal Amount { get; set; }
    }
}

