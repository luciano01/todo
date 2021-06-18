import 'package:flutter/material.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Task name',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3),
                            ),
                            child: Icon(Icons.today,
                                color: Theme.of(context).accentColor),
                          ),
                          title: Text('Friday 18, January'),
                          subtitle: Text('Select a date'),
                        ),
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3),
                            ),
                            child: Icon(Icons.access_time_rounded,
                                color: Theme.of(context).accentColor),
                          ),
                          title: Text('11:15 AM'),
                          subtitle: Text('Select a time'),
                        ),
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3),
                            ),
                            child: Icon(Icons.notifications_none_outlined,
                                color: Theme.of(context).accentColor),
                          ),
                          title: Text('Remind me'),
                          subtitle: Text('Notification'),
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('Create Task'),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
