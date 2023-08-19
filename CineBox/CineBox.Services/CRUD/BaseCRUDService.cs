using System;
using AutoMapper;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;

namespace CineBox.Services.CRUD
{
    //public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb> where TDb : class where T : class where TSearch : BaseSearchObject
    //{
    //    public BaseCRUDService(CineBoxV1Context context, IMapper mapper) : base(context, mapper)
    //    {
    //    }

    //    public virtual async Task<T> Insert(TInsert insert)
    //    {
    //        var set = _context.Set<TDb>();

    //        TDb entity = _mapper.Map<TDb>(insert);

    //        set.Add(entity);
    //        //await BeforeInsert(entity, insert);

    //        await _context.SaveChangesAsync();

    //        return _mapper.Map<T>(entity);
    //    }

    //    public virtual async Task<T> Update(int id, TUpdate update)
    //    {
    //        var set = _context.Set<TDb>();

    //        var entity = await set.FindAsync(id);

    //        _mapper.Map(update, entity);

    //        await _context.SaveChangesAsync();
    //        return _mapper.Map<T>(entity);
    //    }
    //}
}

