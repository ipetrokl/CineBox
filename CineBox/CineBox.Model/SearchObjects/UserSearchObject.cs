using System;
namespace CineBox.Model.SearchObjects
{
	public class UserSearchObject: BaseSearchObject
	{
		public string? Name { get; set; }
		public string? FTS { get; set; }
	}
}

