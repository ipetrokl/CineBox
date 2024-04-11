using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Payment
{
    public class PaymentService : BaseCRUDService<Model.ViewModels.Payment, Database.Payment, PaymentSearchObject, PaymentInsertRequest, PaymentUpdateRequest>, IPaymentService
    {
        public PaymentService(ILogger<BaseService<Model.ViewModels.Payment, Database.Payment, PaymentSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
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

