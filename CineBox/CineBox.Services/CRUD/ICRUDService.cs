using System;
namespace CineBox.Services.CRUD
{
	public interface ICRUDService<T, TSearch, TInsert, TUpdate> : IService<T, TSearch> where TSearch : class
	{
        Task<T> Insert(TInsert insert);
        Task<T> Update(int id, TUpdate update);
    }
}

