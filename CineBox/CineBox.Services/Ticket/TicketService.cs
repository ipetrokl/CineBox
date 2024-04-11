using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Ticket
{
    public class TicketService : BaseCRUDService<Model.ViewModels.Ticket, Database.Ticket, TicketSearchObject, TicketInsertRequest, TicketUpdateRequest>, ITicketService
    {
        public TicketService(ILogger<BaseService<Model.ViewModels.Ticket, Database.Ticket, TicketSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Ticket> AddFilter(IQueryable<Database.Ticket> query, TicketSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Where(x => x.TicketCode.Contains(search.FTS));
            }

            return filteredQuery;
        }
    }
}

