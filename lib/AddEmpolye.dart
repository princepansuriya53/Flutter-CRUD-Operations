import 'package:flutter/material.dart';
import 'package:i_u_d/dataClass.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Function(Employee) onAddEmployee;
  final Function(Employee) onEditEmployee;
  final Employee? initialEmployee;

  const AddEmployeeScreen({
    required this.onAddEmployee,
    required this.onEditEmployee,
    this.initialEmployee,
  });

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialEmployee != null) {
      // Pre-fill the form if editing an existing employee
      nameController.text = widget.initialEmployee!.name;
      emailController.text = widget.initialEmployee!.email;
      phoneNumberController.text = widget.initialEmployee!.phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.initialEmployee != null ? 'Edit Employee' : 'Add Employee'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Phone Number'),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, foregroundColor: Colors.white),
            onPressed: () {
              saveEmployee();
            },
            child: Text(widget.initialEmployee != null
                ? 'Save Changes'
                : 'Add Employee'),
          ),
        ],
      ),
    );
  }

  void saveEmployee() {
    String name = nameController.text;
    String email = emailController.text;
    String phoneNumber = phoneNumberController.text;

    if (name.isNotEmpty && email.isNotEmpty && phoneNumber.isNotEmpty) {
      Employee editedEmployee = Employee(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
      );

      if (widget.initialEmployee != null) {
        // If editing an existing employee, call onEditEmployee
        widget.onEditEmployee(editedEmployee);
      } else {
        // If adding a new employee, call onAddEmployee
        widget.onAddEmployee(editedEmployee);
      }

      // Close the add/edit employee screen
      Navigator.pop(context);
    } else {
      // Show a snackbar or some feedback for incomplete data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    }
  }
}
