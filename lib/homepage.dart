import 'package:flutter/material.dart';
import 'package:i_u_d/AddEmpolye.dart';
import 'package:i_u_d/dataClass.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> employees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: employees.isEmpty
          ? const Center(child: Text('No Employees added yet.'))
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ListTile(
                    title: Text("Name:- ${employees[index].name}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mail:- ${employees[index].email}"),
                        Text("Contact:- ${employees[index].phoneNumber}"),
                      ],
                    ),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => editEmployee(index)),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteEmployee(index))
                    ]),
                  )),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEmployeeScreen(
                onAddEmployee: addEmployee,
                // ignore: avoid_types_as_parameter_names
                onEditEmployee: (Employee) {
                  setState(() {});
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void addEmployee(Employee newEmployee) {
    setState(() {
      employees.add(newEmployee);
    });
  }

  void editEmployee(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEmployeeScreen(
          onEditEmployee: (editedEmployee) {
            setState(() {
              employees[index] = editedEmployee;
            });
          },
          initialEmployee: employees[index],
          onAddEmployee: (employee) {
            setState(() {
              setState(() {
                employees.add(employee);
              });
            });
          },
        ),
      ),
    );
  }

  void deleteEmployee(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Employee'),
          content: const Text('Are you sure you want to delete this employee?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  employees.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
