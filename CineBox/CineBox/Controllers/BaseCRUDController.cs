using System;
using CineBox.Model;
using CineBox.Services;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{

    [Route("[controller]")]
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where T : class where TSearch : class
    {
        protected new readonly ICRUDService<T, TSearch, TInsert, TUpdate> _service;
        
        public BaseCRUDController(ICRUDService<T, TSearch, TInsert, TUpdate> service)
            : base(service)
        {
            _service = service;
        }

        [HttpPost]
        public virtual async Task<T> Insert(TInsert insert)
        {
            return await _service.Insert(insert);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, TUpdate update)
        {
            return await _service.Update(id, update);
        }
    }
}

