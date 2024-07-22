using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Model.ViewModels;
using CineBox.Services.Database;
using CineBox.Services.Messaging;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Ticket
{
    public class TicketService : BaseCRUDService<Model.ViewModels.Ticket, Database.Ticket, TicketSearchObject, TicketInsertRequest, TicketUpdateRequest>, ITicketService
    {
        private readonly IMessageProducer _messageProducer;

        public TicketService(ILogger<BaseService<Model.ViewModels.Ticket, Database.Ticket, TicketSearchObject>> logger, CineBoxContext context, IMapper mapper, IMessageProducer messageProducer) : base(logger, context, mapper)
        {
            _messageProducer = messageProducer;
        }

        public override IQueryable<Database.Ticket> AddFilter(IQueryable<Database.Ticket> query, TicketSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Where(x => x.TicketCode.Contains(search.FTS));
            }

            if (search?.currentDate != null && search?.UserId != null)
            {
                filteredQuery = filteredQuery
                   .Include(x => x.BookingSeat)
                        .ThenInclude(b => b.Booking)
                            .ThenInclude(c => c.Screening)
                                .ThenInclude(d => d.Movie)
                    .Include(x => x.BookingSeat)
                        .ThenInclude(b => b.Seat)
                            .ThenInclude(c => c.Hall)
                    .Where(x => x.BookingSeat.Booking.Screening.ScreeningTime.AddHours(1) >= search.currentDate && x.UserId == search.UserId);
            }

            return filteredQuery;
        }

        public override async Task<Model.ViewModels.Ticket> Insert(TicketInsertRequest insert)
        {

            var set = _context.Set<Database.Ticket>();

            Database.Ticket entity = _mapper.Map<Database.Ticket>(insert);
            
            set.Add(entity);
            await BeforeInsert(entity, insert);
            await _context.SaveChangesAsync();

            var savedTicket = await _context.Set<Database.Ticket>()
                .Include(x => x.BookingSeat)
                        .ThenInclude(b => b.Booking)
                            .ThenInclude(c => c.Screening)
                                .ThenInclude(d => d.Movie)
                .Include(x => x.BookingSeat)
                        .ThenInclude(b => b.Seat)
                            .ThenInclude(c => c.Hall)
                .Include(x => x.User)
                .FirstOrDefaultAsync(t => t.Id == entity.Id);

            if (entity != null)
            {
                ReservationNotifier reservation = new ReservationNotifier
                {
                    Id = entity.Id,
                    TicketCode = entity.TicketCode,
                    Seat = savedTicket?.BookingSeat?.Seat?.SeatNumber ?? 0,
                    Hall = savedTicket?.BookingSeat?.Seat?.Hall?.Name ?? "",
                    Name = savedTicket?.User?.Name ?? "",
                    Email = savedTicket?.User?.Email ?? "",
                    DateAndTime = savedTicket?.BookingSeat?.Booking?.Screening?.ScreeningTime ?? DateTime.MaxValue

                };

                _messageProducer.SendingObject(reservation);

            }

            return _mapper.Map<Model.ViewModels.Ticket>(entity);
        }

        public override IQueryable<Database.Ticket> AddInclude(IQueryable<Database.Ticket> query, TicketSearchObject? search = null)
        {
            return query
                 .Include(x => x.BookingSeat);

        }
    }
}

