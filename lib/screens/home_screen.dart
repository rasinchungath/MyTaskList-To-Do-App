import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/bottomsheet.dart';
import 'package:todo_list_app/utils/cardtiles.dart';
import 'package:todo_list_app/utils/utils.dart';
import '../constants/colors.dart';
import '../helper/sql_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (_) => Bottomfield(
        titleController: _titleController,
        descriptionController: _descriptionController,
        id: id,
        onpressed: () async {
          if (id == null) {
            await _addItem();
          }

          if (id != null) {
            await _updateItem(id);
          }

          _titleController.clear();
          _descriptionController.clear();

          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _addItem() async {
    if (_titleController.text.isNotEmpty ||
        _descriptionController.text.isNotEmpty) {
      await SQLHelper.createItem(
          _titleController.text, _descriptionController.text);
      snackbar(
        context: context,
        content: 'Successfully added a task!',
      );
    } else {
      snackbar(
        context: context,
        content: 'Please add some taks',
      );
    }

    _refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    snackbar(
      context: context,
      content: 'Successfully updated a task!',
    );
    _refreshJournals();
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    snackbar(
      context: context,
      content: 'Successfully deleted a task!',
    );
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: appBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _journals.isEmpty
              ? Center(
                  child: Text(
                    'No tasks to display',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'All ToDos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _journals.length,
                          itemBuilder: (context, index) => Dismissible(
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              _deleteItem(_journals[index]['id']);
                            },
                            key: UniqueKey(),
                            background: Padding(
                              padding: const EdgeInsets.only(top: 6, bottom: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            child: CardTiles(
                              title: _journals[index]['title'],
                              description: _journals[index]['description'],
                              ontapped: () {
                                _showForm(
                                  _journals[index]['id'],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: floatingButton(
        onpressed: () => _showForm(null),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
