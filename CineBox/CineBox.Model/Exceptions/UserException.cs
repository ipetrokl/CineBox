using System;
using System.Text;

namespace CineBox.Model.Exceptios
{
    public class UserException : Exception
	{
		public UserException(string message): base(message)
		{

		}
	}
}

