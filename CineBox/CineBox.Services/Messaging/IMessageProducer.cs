using System;
namespace CineBox.Services.Messaging
{
	public interface IMessageProducer
	{
        public void SendingMessage(string message);
        public void SendingObject<T>(T obj);
    }
}

