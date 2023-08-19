using System;
using System.Security.Cryptography;
using System.Text;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Services.Database;

namespace CineBox.Services.Users
{
    public class UserService : IUserService
    {
        CineBoxV1Context _context;
        public IMapper _mapper { get; set; }

        public UserService(CineBoxV1Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public List<Model.ViewModels.User> Get()
        {
            var entityList = _context.Users.ToList();

            return _mapper.Map<List<Model.ViewModels.User>>(entityList);
        }

        public Model.ViewModels.User Insert(UserInsertRequest request)
        {
            var entity = new User();
            _mapper.Map(request, entity);

            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);

            _context.Users.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Model.ViewModels.User>(entity);
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

        public Model.ViewModels.User Update(int id, UserUpdateRequest request)
        {
            var entity = _context.Users.Find(id);
            _mapper.Map(request, entity);

            _context.SaveChanges();

            return _mapper.Map<Model.ViewModels.User>(entity);
        }
    }
}

