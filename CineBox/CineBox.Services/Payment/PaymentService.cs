using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using PayPal.Api;
using Stripe;

namespace CineBox.Services.Payment
{
    public class PaymentService : BaseCRUDService<Model.ViewModels.Payment, Database.Payment, PaymentSearchObject, PaymentInsertRequest, PaymentUpdateRequest>, IPaymentService
    {
        private readonly StripePaymentService _stripePaymentService;
        private readonly PayPalPaymentService _payPalPaymentService;
        private readonly IConfiguration _configuration;

        public PaymentService(ILogger<BaseService<Model.ViewModels.Payment, Database.Payment, PaymentSearchObject>> logger, CineBoxContext context, IMapper mapper, StripePaymentService stripePaymentService, PayPalPaymentService payPalPaymentService, IConfiguration configuration) : base(logger, context, mapper)
        {
            _stripePaymentService = stripePaymentService;
            _payPalPaymentService = payPalPaymentService;
            _configuration = configuration;
        }

        public async Task<PaymentIntent> CreatePaymentIntent(decimal amount)
        {
            return await _stripePaymentService.CreatePaymentIntent(amount);
        }

        public async Task<PayPal.Api.Payment> CreatePayPalPayment(decimal amount)
        {
            var payPalPaymentService = new PayPalPaymentService(_configuration);
            var paymentResponse = await payPalPaymentService.CreatePayPalPaymentAsync(amount);

            var payment = new PayPal.Api.Payment
            {
                id = paymentResponse.PaymentId,
                links = new List<Links>
        {
            new Links
            {
                href = paymentResponse.RedirectUrl,
                rel = "approval_url",
                method = "REDIRECT"
            }
        }
            };

            return payment;
        }

        public override IQueryable<Database.Payment> AddFilter(IQueryable<Database.Payment> query, PaymentSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Include(x => x.Booking)
                    .Where(x => x.Booking.Id.ToString().Contains(search.FTS) || x.PaymentStatus.Contains(search.FTS));
            }

            return filteredQuery;
        }
    }
}

