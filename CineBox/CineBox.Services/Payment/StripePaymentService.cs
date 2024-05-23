using System;
using Stripe;

namespace CineBox.Services.Payment
{
	public class StripePaymentService
	{
        public StripePaymentService()
        {
            StripeConfiguration.ApiKey = "sk_test_51PJftNCAqDQvgEGdk2nBewQDfGsLxBWhNmpZnT57RhIFRs4p4nBuYXLS8qNKvgJI5Q3s463GCADUyM4qvGhNe9W000hy47MQkZ";
        }

        public async Task<PaymentIntent> CreatePaymentIntent(decimal amount, string currency = "usd")
        {
            var options = new PaymentIntentCreateOptions
            {
                Amount = (long)(amount * 100), // Amount is in cents
                Currency = currency,
            };
            var service = new PaymentIntentService();
            return await service.CreateAsync(options);
        }
    }
}

