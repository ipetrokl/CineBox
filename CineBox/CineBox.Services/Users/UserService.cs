using System;
using System.Security.Cryptography;
using System.Text;
using AutoMapper;
using Azure.Core;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using CineBox.Services.StateMachine;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Users
{
    public class UserService : BaseCRUDService<Model.ViewModels.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUserService
    {
        public UserService(ILogger<BaseService<Model.ViewModels.User, Database.User, UserSearchObject>> logger, CineBoxContext context, IMapper mapper)
            : base(logger, context,mapper)
        {
        }

        public override async Task BeforeInsert(User entity, UserInsertRequest request)
        {
            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);
        }

        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public override IQueryable<User> AddFilter(IQueryable<User> query, UserSearchObject search)
        {
            if (!string.IsNullOrEmpty(search.Name))
            {
                query = query.Where(x => x.Name.StartsWith(search.Name));
            }

            if (!string.IsNullOrEmpty(search.FTS))
            {
                query = query.Where(x => x.Name.Contains(search.FTS));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<User> AddInclude(IQueryable<User> query, UserSearchObject search)
        {
            if (search?.isRoleIncluded == true)
            {
                query = query.Include("UsersRoles.Role");
            }
            return base.AddInclude(query, search);
        }
    }
}

