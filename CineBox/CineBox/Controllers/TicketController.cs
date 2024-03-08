using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Ticket;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class TicketController : BaseCRUDController<Model.ViewModels.Ticket, TicketSearchObject, TicketInsertRequest, TicketUpdateRequest>
    {

        public TicketController(ITicketService service) : base(service)
        {

        }
    }
}

