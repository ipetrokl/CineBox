using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Payment
{
    public class PaymentService : BaseCRUDService<Model.ViewModels.Payment, Database.Payment, PaymentSearchObject, PaymentInsertRequest, PaymentUpdateRequest>, IPaymentService
    {
        public PaymentService(ILogger<BaseService<Model.ViewModels.Payment, Database.Payment, PaymentSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

