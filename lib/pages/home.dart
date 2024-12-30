import 'package:flutter/material.dart';
import 'package:to_do/utils/todo_list.dart';
import 'dart:convert' as convert ;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final controller = TextEditingController();
  List Tasks = [];
  void initState() {
    super.initState();
    getTasks(); // Fetch tasks when the app starts
  }
  void getTasks() async{
    try{
      final response = await http.get(Uri.parse('http://10.0.2.2/to_do_app/getTask.php'));
      Tasks.clear();
      if(response.statusCode ==200){
        final jsonResponse = convert.jsonDecode(response.body);
        setState(() {
          Tasks = jsonResponse.map((task) {
            return [
              task['task_text'],
              task['isComplete'] == "1",
              task['course'],
              task['id'],
            ];
          }).toList();
        });
      }
      else{
        throw Exception("failed to fetch");
      }
    }
    catch(e){
      print("error : $e");
    }
  }
  void addTask() async{
    String newTaskText = controller.text;
    String selectedCourse = "Course";
    try{
      final response = await http.post(
        Uri.parse('http://10.0.2.2/to_do_app/addTask.php'),
        body: {
          'task_text': newTaskText,
          'course': selectedCourse,
          'isComplete': '0',
        },
      );
      if (response.statusCode == 200){
        final jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success']){
          setState(() {
            Tasks.add([newTaskText, false, selectedCourse]);
            controller.clear();
          });
        }
        else {
          print("Failed to add task: ${jsonResponse['message']}");
        }
      }
      else {
        print("Error: ${response.statusCode}");
      }
    }
    catch(e){
      print("Error adding task: $e");
    }
  }

  void delete (int index) async{
    try{
      final taskId = Tasks[index][3];
      final response = await http.post(
        Uri.parse('http://10.0.2.2/to_do_app/deleteTask.php'),
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode({"id": taskId}),
      );

        if (response.statusCode == 200) {
         final jsonResponse = convert.jsonDecode(response.body);
         if (jsonResponse['success']) {
           setState(() {
            Tasks.removeAt(index);
          });
        } else {
          print("Error: ${jsonResponse['message']}");
        }
      } else {
        throw Exception("Failed to delete task");
      }
    }
    catch(e){
      print("Error: $e");
    }
    setState(() {
      Tasks.removeAt(index);
    });
  }

  void checkBoxChanged (int index){
    setState(() {
      Tasks[index][1] = !Tasks[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(title: Text("Nextask", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),centerTitle: true, backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,),
      body: ListView.builder(itemCount: Tasks.length,
          itemBuilder: (BuildContext context, index){
        return TodoList(taskName:Tasks[index][0],
        taskCompleted: Tasks[index][1],
          course: Tasks[index][2],
        onChanged: (value)=>{
          checkBoxChanged(index),
        },
          deleteTask: (context)=>{delete(index),},

        );
      }
      ),
      floatingActionButton: Row(
        children: [
           Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(height: 50,width: 300,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Add a new task",
                  filled: true,
                  fillColor: Colors.deepPurple.shade200 ,
                ),
              ),
            )
          )),
          FloatingActionButton(
            onPressed: (){
              addTask();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
