using System;
using System.Security.Cryptography;
using System.Text;
using AutoMapper;
using Azure.Core;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using CineBox.Services.Picture;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Users
{
    public class UserService : BaseCRUDService<Model.ViewModels.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUserService
    {
        IPictureService _pictureService;

        public UserService(ILogger<BaseService<Model.ViewModels.User, Database.User, UserSearchObject>> logger, CineBoxContext context, IMapper mapper, IPictureService pictureService)
            : base(logger, context,mapper)
        {
            _pictureService = pictureService;
        }

        public override async Task BeforeInsert(User entity, UserInsertRequest request)
        {
            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);

            if (request.PictureData != null && request.PictureData.Length > 0)
            {
                var pictureInsertRequest = new PictureInsertRequest
                {
                    Picture1 = request.PictureData
                };

                var picture = await _pictureService.Insert(pictureInsertRequest);

                entity.PictureId = picture.Id;
            }
        }

        public override async Task BeforeUpdate(User entity, UserUpdateRequest request)
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
            query = query.Include(x => x.Picture);
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

        public override async Task<bool> Delete(int id)
        {
            var userEntity = await _context.Movies
                .Include(m => m.Picture)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (userEntity == null)
            {
                return false;
            }

            if (userEntity.PictureId.HasValue)
            {
                var pictureId = userEntity.PictureId.Value;

                var pictureUsageCount = await _context.Movies
                    .Where(m => m.PictureId == pictureId)
                    .CountAsync();

                if (pictureUsageCount == 1)
                {
                    var pictureEntity = await _context.Pictures.FindAsync(pictureId);
                    if (pictureEntity != null)
                    {
                        _context.Pictures.Remove(pictureEntity);
                    }
                }
            }

            _context.Movies.Remove(userEntity);
            await _context.SaveChangesAsync();

            return true;
        }

        public override async Task<Model.ViewModels.User> Update(int id, UserUpdateRequest update)
        {
            var set = _context.Set<Database.User>();
            var entity = await set.FindAsync(id);

            if (entity == null)
            {
                throw new KeyNotFoundException($"User with ID {id} not found.");
            }

            if (!string.IsNullOrWhiteSpace(update.Password))
            {
                await BeforeUpdate(entity, update);
            }

            if (update.PasswordConfirmation != null && update.PasswordConfirmation != update.Password)
            {
                throw new ArgumentException("Password and PasswordConfirmation do not match.");
            }

            _mapper.Map(update, entity, opts => opts.BeforeMap((src, dest) =>
            {
                src.Password = null;
                src.PasswordConfirmation = null;
            }));

            await BeforeUpdatePicture(entity, update);
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.ViewModels.User>(entity);
        }

        public async Task BeforeUpdatePicture(User entity, UserUpdateRequest request)
        {
            if (request.PictureData != null && request.PictureData.Length > 0)
            {
                if (entity.PictureId.HasValue)
                {
                    var pictureUpdateRequest = new PictureUpdateRequest
                    {
                        Picture1 = request.PictureData
                    };

                    await _pictureService.Update(entity.PictureId.Value, pictureUpdateRequest);
                }
                else
                {
                    var pictureInsertRequest = new PictureInsertRequest
                    {
                        Picture1 = request.PictureData
                    };

                    var picture = await _pictureService.Insert(pictureInsertRequest);
                    entity.PictureId = picture.Id;
                }
            }
        }

    }
}

