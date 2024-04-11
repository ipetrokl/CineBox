using System;
namespace CineBox.Model.SearchObjects
{
	public class UserSearchObject: BaseSearchObject
	{
		public string? FTS { get; set; }
		public bool? isRoleIncluded { get; set; }
	}
}

