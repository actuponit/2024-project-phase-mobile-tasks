import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/domain/entities/user_data.dart';
import '../blocs/bloc/chat_bloc.dart';
import '../widgets/chat_box.dart';
import '../widgets/message_contaner.dart';
import '../widgets/profile_pic_widget.dart';

class ChatPage extends StatelessWidget {
  final UserEntity user;
  const ChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AppBar(
              toolbarHeight: 65,
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 14, 8, 1)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfilePicWidget(
                      bgColor: Color.fromARGB(255, 228, 146, 119), radius: 30),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(14, 8, 1, 1),
                          ),
                        ),
                        const Text(
                          '8 members, 5 Online',
                          style: TextStyle(
                            color: Color.fromARGB(255, 121, 124, 123),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.call_outlined,
                      color: Color.fromARGB(255, 14, 8, 1)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.videocam_outlined,
                    color: Color.fromARGB(255, 14, 8, 1),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 95.0),
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatMessageLoadedState) {
                  var messages = state.messages;
                  return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: messages[index].sender?.id == user.id
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        crossAxisAlignment: messages[index].sender?.id == user.id
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.start,
                        children: messages[index].sender?.id == user.id
                            ? [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: ProfilePicWidget(
                                    bgColor:
                                        Color.fromARGB(255, 228, 146, 119),
                                    radius: 25),
                                ),
                                Column(
                                  crossAxisAlignment: index % 2 == 0
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Annei Ellison',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    WithTime(
                                      text:
                                          messages[index].content,
                                      isCurrentUser: false,
                                      type: 'text',
                                      image:
                                          'https://images.unsplash.com/photo-1557863618-9643198cb07b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Njd8fFRveW90YSUyMFY4JTIwcGF0cm9sfGVufDB8fDB8fHww',
                                      time: '09:25 AM',
                                    ),
                                  ],
                                ),
                              ]
                            : [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        'You',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    WithTime(
                                      text: messages[index].content,
                                      isCurrentUser: true,
                                      type: messages[index].type.name,
                                      image:
                                          'https://images.unsplash.com/photo-1557863618-9643198cb07b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Njd8fFRveW90YSUyMFY4JTIwcGF0cm9sfGVufDB8fDB8fHww',
                                      time: '09:25 AM',
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: ProfilePicWidget(
                                      bgColor:
                                          Color.fromARGB(255, 228, 146, 119),
                                      radius: 25),
                                ),
                              ],
                      ),
                    );
                  },
                );
                } else if (state is ChatMessageLoadingState) {
                  return const CircularProgressIndicator();
                } else {
                  return Center(child: Text('Unkown State ${state.runtimeType}'),);
                }
              },
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MessageBox(),
          ),
        ]),
      ),
    );
  }
}
