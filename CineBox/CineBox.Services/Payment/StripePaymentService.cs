using System;
using Stripe;

namespace CineBox.Services.Payment
{
	public class StripePaymentService
	{
        public StripePaymentService()
        {
            StripeConfiguration.ApiKey = Environment.GetEnvironmentVariable("Stripe__ApiKey") ?? "sk_test_51PJftNCAqDQvgEGdk2nBewQDfGsLxBWhNmpZnT57RhIFRs4p4nBuYXLS8qNKvgJI5Q3s463GCADUyM4qvGhNe9W000hy47MQkZ";
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

