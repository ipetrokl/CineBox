using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Actors
{
    public interface IActorService : ICRUDService<Model.ViewModels.Actor, ActorSearchObject, ActorInsertRequest, ActorUpdateRequest>
    {

    }
}