using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Ticket
{
	public interface ITicketService : ICRUDService<Model.ViewModels.Ticket, TicketSearchObject, TicketInsertRequest, TicketUpdateRequest>
	{
	}
}

