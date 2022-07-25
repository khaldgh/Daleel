import 'package:daleel/models/comment.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({Key? key, this.futureFunc, this.id}) : super(key: key);

  final futureFunc;
  final int? id;

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  Widget build(BuildContext context) {
    Places places = Provider.of<Places>(context, listen: false);
    var mediaQ = MediaQuery.of(context);
    Size size = mediaQ.size;
    double btm = mediaQ.viewInsets.bottom;
    print(btm);
    TextEditingController commentController = TextEditingController();
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: btm != 0.0 ? .6 : .1,
        minChildSize: .1,
        maxChildSize: .8,
        builder: (BuildContext context, ScrollController scrollController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(80, 244, 67, 54),
                  ),
                  child: TextField(
                    controller: commentController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '$btm',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onSubmitted: (comment) {
                      places.postComment(commentController.text, widget.id);
                      setState(() {});
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.futureFunc!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: CircleAvatar(backgroundImage: NetworkImage(
                              widget.futureFunc![index].user!.profilePic!)
                        ),
                        title: Text(
                          widget.futureFunc![index].user!.username!,
                          textAlign: TextAlign.right,
                          style: TextStyle(),
                        ),
                        subtitle: Text(
                          widget.futureFunc![index].comment!,
                          textAlign: TextAlign.right,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
