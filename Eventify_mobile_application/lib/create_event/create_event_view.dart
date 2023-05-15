import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/create_event/select_location.dart';
import 'package:eventify_frontend/create_event/select_tags.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const CreateEventView());

class CreateEventView extends StatelessWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NewEventForm();
  }
}

// Define a custom Form widget.
class NewEventForm extends StatefulWidget {
  const NewEventForm({Key? key}) : super(key: key);

  @override
  _NewEventFormState createState() => _NewEventFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _NewEventFormState extends State<NewEventForm> {
  // Create a text controller
  //and use it to retrieve the current value
  // of the TextField.

  int _maxPeople = 1;
  bool _useLocation = false;
  String infoTestString = '';
  List _tags = [
    ["0"],
    [""]
  ];
  double _posLat = 0;
  double _posLong = 0;
  String _date = '';
  String _time = '';
  int _hostID = 0;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadHostID();
    super.initState();
  }

  // fetch user id and place it to hostID when creating new event
  void loadHostID() async {
    prefs = await SharedPreferences.getInstance();
    _hostID = prefs.getInt("userID")!;
    print(_hostID);
  }

// SCREEN:

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      body: (Column(children: [
        /*viewTitle(context)*/
        Form(
            key: _formKey,
            child: Column(children: [
              titleForm(context),
              descriptionForm(context),
              selectTagsForm(context),
              selectLocationForm(context),
              maxPeopleForm(context),
              dateTimeForm(context),
              submit(context),
            ]))
      ])),
    );
  }

// WIDGETS:

  Widget viewTitle(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.amber,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        //margin: const EdgeInsets.only(bottom: 20),
        child: const Text(
          'Create new event',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }

  Widget titleForm(BuildContext context) {
    return Column(children: [
      const Text('Event title:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      TextFormField(
          autofocus: false,
          textAlign: TextAlign.center,
          controller: nameController,
          validator: (eventValue) {
            if (eventValue == null || eventValue.isEmpty) {
              return 'The event needs a title';
            }
            return null;
          }),
    ]);
  }

  Widget descriptionForm(BuildContext context) {
    return Column(children: [
      const Text('Event description:',
          style: TextStyle(fontWeight: FontWeight.bold)),
      TextFormField(
        autofocus: false,
        textAlign: TextAlign.center,
        controller: descriptionController,
        validator: (descriptionValue) {
          if (descriptionValue == null || descriptionValue.isEmpty) {
            return 'The event needs a description';
          }

          return null;
        },
      )
    ]);
  }

  Widget selectTagsForm(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: () => _showTagSelection(context),
              child: const Text('Select tags'))),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Selected tags:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        Text(_tags[1].toString()),
      ])
    ]);
  }

  Widget selectLocationForm(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Use Location',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Switch(
                value: _useLocation,
                onChanged: (bool newValue) {
                  setState(() {
                    _useLocation = newValue;
                  });
                }),
          ],
        ),
        (_useLocation)
            ? (Container(
                color: Colors.amber,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 40, right: 40),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _showLocationSelection(context),
                      child: const Text('Set Location',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Column(children: [
                      const Text('Location for your event:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(_posLat.toString() + ' ' + _posLong.toString()),
                    ]),
                  ],
                )))
            : (Container())
      ],
    );
  }

  Widget maxPeopleForm(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Max People: ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<int>(
          value: _maxPeople,
          icon: const Icon(
            Icons.arrow_drop_down_circle,
          ),
          iconSize: 20,
          elevation: 16,
          style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int? newValue) {
            setState(() {
              _maxPeople = newValue!;
            });
          },
          items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget dateTimeForm(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Text('Select date and time: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [
                ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () => _selectDate(context),
                    child: const Text('Select date')),
                Text(_date),
              ]),
              Column(
                children: [
                  ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () => _selectTime(context),
                      child: const Text('Select time')),
                  Text(_time)
                ],
              )
            ])
          ],
        ));
  }

// submit button and handling for the information
  Widget submit(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (_tags.isEmpty || _tags == [0] || _tags == 'null') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('You have to set at least one tag!')),
            );
          } else {
            if (_useLocation && (_posLat == 0 || _posLat == null)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'If you are using location You have to set it first!')),
              );
            } else {
              if (_date == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You have to set date!')),
                );
              } else {
                if (_time == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You have to set time!')),
                  );
                } else {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  sendData(nameController.text, descriptionController.text,
                      _tags[0], _posLat, _posLong, _date, _time, _maxPeople);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Processing Data: ' + infoTestString)),
                  );
                }
              }
            }
          }
        }
      },
      child: const Text('SUBMIT',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  // handling other sets:

  // gets tags from tag class
  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        _date =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        _time = "${selectedTime.hour}.${selectedTime.minute}";
      });
    }
  }

// gets location from location class
  void _showLocationSelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectLocation()),
    );

    var _latLong = result.toString().split(", ");

    setState(() {
      _posLat = double.parse(_latLong[0]);
      _posLong = double.parse(_latLong[1]);
    });
  }

// gets tags from tag class
  void _showTagSelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SelectTags()),
    );
    print('result:' + result.toString());
    setState(() {
      _tags = result;
    });
  }

  // sends data to database
  void sendData(String title, String description, List tagList, double posLat,
      double posLong, String date, String time, int maxPeople) {
    print('puusti');
    if (!_useLocation) {
      print('puusti1');
      createPostEvent(description, title, tagList, false, 0, 0, _hostID,
          maxPeople, 2, "2022-05-14T08:34:59.506", false);
      infoTestString = 'Event posted succesfully';
      ;
    } else {
      print('puusti2');
      createPostEvent(description, title, tagList, true, posLat, posLong,
          _hostID, maxPeople, 2, "2022-05-14T08:34:59.506", false);
      infoTestString = 'Event posted succesfully';
    }
  }
}
