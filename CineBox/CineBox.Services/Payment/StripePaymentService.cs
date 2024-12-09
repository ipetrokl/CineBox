using System;
using Stripe;

namespace CineBox.Services.Payment
{
	public class StripePaymentService
	{
        public StripePaymentService()
        {
            StripeConfiguration.ApiKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY") ?? "";
        }

        public async Task<PaymentIntent> CreatePaymentIntent(decimal amount, string currency = "eur")
        {
            var options = new PaymentIntentCreateOptions
            {
                Amount = (long)(amount * 100),
                Currency = currency,
            };
            var service = new PaymentIntentService();
            return await service.CreateAsync(options);
        }
    }
}

