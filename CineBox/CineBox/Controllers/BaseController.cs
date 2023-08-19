using System;
using CineBox.Model;
using CineBox.Model.Requests;
using CineBox.Services;
using CineBox.Services.Users;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{

    [Route("[controller]")]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        private readonly IService<T, TSearch> _service;

        public BaseController(IService<T, TSearch> service)
        {
            _service = service;
        }

        [HttpGet()]
        public async Task<PagedResult<T>> Get([FromQuery]TSearch search)
        {
            return await _service.Get(search);
        }
    }
}

