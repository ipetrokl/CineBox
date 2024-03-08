using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Seat
{
    public interface ISeatService : ICRUDService<Model.ViewModels.Seat, SeatSearchObject, SeatInsertRequest, SeatUpdateRequest>
    {
        
    }
}