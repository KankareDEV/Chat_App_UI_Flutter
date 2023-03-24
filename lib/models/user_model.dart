class User {
  final String id;
  final String name;
  final String imageUrl;

  const User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  static const List<User> users = [
    User(
      id: '1',
      name: 'John',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    ),
    User(
      id: '2',
      name: 'Mike Miller',
      imageUrl:
          'https://images.unsplash.com/photo-1595152452543-e5fc28ebc2b8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80',
    ),
    User(
      id: '3',
      name: 'Mary Land',
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80',
    ),
    User(
      id: '3',
      name: 'Mary',
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80',
    ),
    User(
      id: '4',
      name: 'Tom Bradley',
      imageUrl:
          'https://i.pinimg.com/736x/66/2f/74/662f7402fc45aeb404001cec62023286.jpg',
    ),
    User(
      id: '5',
      name: 'Jerry More',
      imageUrl:
          'https://images.unsplash.com/photo-1594344041337-0223bd103abe?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
    ),
  ];
}
