import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String editData;
  final int editId;
  const EditPage(this.editId, this.editData, {super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.editData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter the title',
                border: OutlineInputBorder(
                    //
                    ),
              ),
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: const Text('Update'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
