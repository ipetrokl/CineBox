using System;
using Microsoft.Extensions.Configuration;
using PayPal.Api;

namespace CineBox.Services.Payment
{
    public class PayPalPaymentService
    {
        private readonly IConfiguration _configuration;

        public PayPalPaymentService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        private APIContext GetApiContext()
        {
            var config = new Dictionary<string, string>
            {
                { "clientId", _configuration["PayPal:ClientId"] },
                { "clientSecret", _configuration["PayPal:ClientSecret"] },
                { "mode", _configuration["PayPal:Mode"] }
            };

            var accessToken = new OAuthTokenCredential(config).GetAccessToken();
            return new APIContext(accessToken);
        }

        public PayPal.Api.Payment CreatePayment(decimal amount, string returnUrl, string cancelUrl)
        {
            var apiContext = GetApiContext();

            var payment = new PayPal.Api.Payment
            {
                intent = "sale",
                payer = new Payer { payment_method = "paypal" },
                transactions = new List<Transaction>
                {
                    new Transaction
                    {
                        description = "CineBox Payment",
                        invoice_number = Guid.NewGuid().ToString(),
                        amount = new Amount { currency = "USD", total = amount.ToString("F2") }
                    }
                },
                redirect_urls = new RedirectUrls
                {
                    cancel_url = cancelUrl,
                    return_url = returnUrl
                }
            };

            return payment.Create(apiContext);
        }
    }
}

