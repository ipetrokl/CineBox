using System;
namespace CineBox.Services.Helper
{
	public static class PictureHelper
	{
        public static byte[] ConvertImageToByteArray(string imagePath)
        {
            return File.ReadAllBytes(imagePath);
        }
    }
}

