class Message {
  final String senderId;
  final String recipientId;
  final String text;
  final DateTime createdAt;

  const Message({
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  static List<Message> messgaes = [
    Message(
      senderId: '1',
      recipientId: '2',
      text: 'Hi, How it is going?',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10),
    ),
    Message(
      senderId: '1',
      recipientId: '2',
      text: 'I will be with my bestie today.',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 30),
      ),
    ),
    Message(
      senderId: '2',
      recipientId: '1',
      text: 'Yo, Ok, Have a great evening with your girl',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 120),
      ),
    ),
    Message(
      senderId: '2',
      recipientId: '1',
      text: 'See you soon!',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 200),
      ),
    ),
    Message(
      senderId: '1',
      recipientId: '3',
      text: 'Hey, how are you?',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10),
    ),
    Message(
      senderId: '1',
      recipientId: '3',
      text: 'I will hang here',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 120),
      ),
    ),
    Message(
      senderId: '3',
      recipientId: '1',
      text: 'I am doing very well, Can we see tonight?',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 200),
      ),
    ),
    Message(
      senderId: '3',
      recipientId: '1',
      text: 'We have not seen a long time',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 300),
      ),
    ),
    Message(
      senderId: '1',
      recipientId: '4',
      text: 'Hey, how are you?',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10),
    ),
    Message(
      senderId: '1',
      recipientId: '4',
      text: 'I am staying here today',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 120),
      ),
    ),
    Message(
      senderId: '4',
      recipientId: '1',
      text: 'Hey, I am good, thanks. What are you doing here today?',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 250),
      ),
    ),
    Message(
      senderId: '4',
      recipientId: '1',
      text: 'Everything alright?',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10).add(
        const Duration(seconds: 400),
      ),
    ),
    Message(
      senderId: '1',
      recipientId: '5',
      text: 'How it is going?',
      createdAt: DateTime(2022, 08, 01, 10, 10, 20),
    ),
    Message(
      senderId: '1',
      recipientId: '6',
      text: 'Hey, how are you?',
      createdAt: DateTime(2022, 08, 01, 10, 10, 40),
    ),
  ];
}
