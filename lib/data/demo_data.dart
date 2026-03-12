import 'package:chat_application/models/conversation_model.dart';
import 'package:chat_application/models/user_model.dart';

class DemoData {
  static List<ConversationModel> demoConversations() {
    return [
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'John Doe',
        lastMessage: 'Hey, how are you?',
        lastMessageTime: '2:30 PM',
        uid: 'user1',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'Sarah Smith',
        lastMessage: 'See you tomorrow!',
        lastMessageTime: '1:15 PM',
        uid: 'user2',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'Mike Johnson',
        lastMessage: 'Thanks for the help',
        lastMessageTime: '12:45 PM',
        uid: 'user3',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'Emma Wilson',
        lastMessage: 'Sounds good to me',
        lastMessageTime: '11:20 AM',
        uid: 'user4',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'Alex Brown',
        lastMessage: 'Let me know when you arrive',
        lastMessageTime: '10:50 AM',
        uid: 'user5',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'Lisa Anderson',
        lastMessage: 'Perfect! Talk soon',
        lastMessageTime: '9:30 AM',
        uid: 'user6',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'James Taylor',
        lastMessage: 'Got it, thanks!',
        lastMessageTime: 'Yesterday',
        uid: 'user7',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'Sophie Martin',
        lastMessage: 'Can\'t wait!',
        lastMessageTime: 'Yesterday',
        uid: 'user8',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'David Garcia',
        lastMessage: 'All good on my end',
        lastMessageTime: '2 days ago',
        uid: 'user9',
      ),
      ConversationModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&s',
        name: 'Rachel Lee',
        lastMessage: 'Looking forward to it',
        lastMessageTime: '3 days ago',
        uid: 'user10',
      ),
    ];
  }

  static List<UserModel> getDemoUsers() {
    return [
      UserModel(
        image: 'https://i.pravatar.cc/150?img=1',
        name: 'Alice Johnson',
        email: 'alice@example.com',
        uid: 'user_001',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=2',
        name: 'Bob Smith',
        email: 'bob@example.com',
        uid: 'user_002',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=3',
        name: 'Charlie Brown',
        email: 'charlie@example.com',
        uid: 'user_003',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=4',
        name: 'Diana Prince',
        email: 'diana@example.com',
        uid: 'user_004',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=5',
        name: 'Eve Wilson',
        email: 'eve@example.com',
        uid: 'user_005',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=6',
        name: 'Frank Miller',
        email: 'frank@example.com',
        uid: 'user_006',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=7',
        name: 'Grace Lee',
        email: 'grace@example.com',
        uid: 'user_007',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=8',
        name: 'Henry Davis',
        email: 'henry@example.com',
        uid: 'user_008',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=9',
        name: 'Ivy Martinez',
        email: 'ivy@example.com',
        uid: 'user_009',
      ),
      UserModel(
        image: 'https://i.pravatar.cc/150?img=10',
        name: 'Jack Taylor',
        email: 'jack@example.com',
        uid: 'user_010',
      ),
    ];
  }
}


