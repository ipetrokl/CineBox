using System;
using System.Security.Cryptography;
using System.Text;
using AutoMapper;
using Azure.Core;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
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

        public override IQueryable<Database.User> AddFilter(IQueryable<Database.User> query, UserSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Where(x =>
                    x.Name.Contains(search.FTS)
                    || x.Username.Contains(search.FTS)
                    || x.Surname.Contains(search.FTS)
                    || x.Email.Contains(search.FTS)
                    || x.Phone.Contains(search.FTS));
            }

            if (!string.IsNullOrWhiteSpace(search?.Username))
            {
                filteredQuery = filteredQuery
                    .Where(x => x.Username == search.Username);
            }

            return filteredQuery;
        }

        public override IQueryable<User> AddInclude(IQueryable<User> query, UserSearchObject search)
        {
            if (search?.isRoleIncluded == true)
            {
                query = query.Include("UsersRoles.Role");
            }
            return base.AddInclude(query, search);
        }

        public async Task<Model.ViewModels.User> Login(string username, string password)
        {
            var entity = await _context.Users.Include("UsersRoles.Role").FirstOrDefaultAsync(x => x.Username == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.PasswordSalt, password);

            if (hash != entity.PasswordHash)
            {
                return null;
            }

            return _mapper.Map<Model.ViewModels.User>(entity);
        }
    }
}

