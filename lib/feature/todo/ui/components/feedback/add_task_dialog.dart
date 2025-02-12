import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key, required this.onSend});
  final ValueSetter<({String title, String description})> onSend;
  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: "Description",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            titleController.clear();
            descriptionController.clear();
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (titleController.text.isEmpty ||
                descriptionController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Title or Description cannot be empty")),
              );
              return;
            }
            try {
              widget.onSend((
                title: titleController.text,
                description: descriptionController.text
              ));
              titleController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error adding task: $e")),
              );
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
