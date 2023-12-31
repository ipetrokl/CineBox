﻿using System;
using AutoMapper;
using CineBox.Model;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace CineBox.Services
{
	public class BaseService<T, TDb, TSearch> : IService<T, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
	{
        protected IMapper _mapper { get; set; }
        protected CineBoxV1Context _context;

        public BaseService(CineBoxV1Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual async Task<PagedResult<T>> Get(TSearch search)
        {
            var query = _context.Set<TDb>().AsQueryable();

            PagedResult<T> result = new PagedResult<T>();

            result.Count = await query.CountAsync();

            query = AddFilter(query, search);

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            result.Result = _mapper.Map<List<T>>(list);

            return result;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch search)
        {
            return query;
        }
    }
}

