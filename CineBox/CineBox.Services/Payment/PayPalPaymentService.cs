using Microsoft.Extensions.Configuration;
using PayPal.Api;

public class PayPalPaymentService
{
    private readonly IConfiguration _configuration;

    public PayPalPaymentService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    private async Task<PayPalPaymentResponse> CreatePayPalPayment(decimal amount)
    {
        var config = new Dictionary<string, string>
        {
            { "clientId", _configuration["PayPal:ClientId"] },
            { "clientSecret", _configuration["PayPal:ClientSecret"] },
            { "mode", _configuration["PayPal:Mode"] }
        };

        var accessToken = new OAuthTokenCredential(config).GetAccessToken();
        var apiContext = new APIContext(accessToken);

        var transaction = new Transaction
        {
            description = "CineBox Payment",
            invoice_number = Guid.NewGuid().ToString(),
            amount = new Amount
            {
                currency = "EUR",
                total = amount.ToString("F2"),
            },
        };

        var payer = new Payer
        {
            payment_method = "paypal"
        };

        var payment = new PayPal.Api.Payment
        {
            intent = "sale",
            payer = payer,
            transactions = new List<Transaction> { transaction },
            redirect_urls = new RedirectUrls
            {
                cancel_url = "https://www.google.com/",
                return_url = "https://www.paypal.com/"
            }
        };

        try
        {
            var createdPayment = payment.Create(apiContext);

            var approvalUrl = createdPayment.links.FirstOrDefault(l => l.rel.Equals("approval_url"))?.href;

            var paymentResponse = new PayPalPaymentResponse
            {
                PaymentId = createdPayment.id,
                RedirectUrl = approvalUrl
            };

            return paymentResponse;
        }
        catch (PayPal.PaymentsException ex)
        {
            Console.WriteLine($"PayPal Error: {ex.Response}");
            throw;
        }
    }

    public async Task<PayPalPaymentResponse> CreatePayPalPaymentAsync(decimal amount)
    {
        var paymentResponse = await CreatePayPalPayment(amount);
        return paymentResponse;
    }
}

public class PayPalPaymentResponse
{
    public string PaymentId { get; set; }
    public string RedirectUrl { get; set; }
}
