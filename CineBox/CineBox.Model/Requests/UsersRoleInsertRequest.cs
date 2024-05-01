using System;
namespace CineBox.Model.Requests
{
	public class UsersRoleInsertRequest
	{

        public int UserId { get; set; }

        public int RoleId { get; set; }

        public DateTime DateOfModification { get; set; }
    }
}

