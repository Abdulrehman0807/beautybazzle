import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/bottom_bar/bottom_Nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentBookScreen extends StatefulWidget {
  // List<Services> srervice:List
  const AppointmentBookScreen({super.key});

  @override
  State<AppointmentBookScreen> createState() => _AppointmentBookScreenState();
}

class _AppointmentBookScreenState extends State<AppointmentBookScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTimeSlot;
  String? _selectedStylist;
  List<String> _selectedServices = []; // To store selected services

  final List<String> morningSlots = [
    '08:30 am',
    '09:30 am',
    '10:30 am',
    '11:30 am'
  ];
  final List<String> afternoonSlots = [
    '14:30 pm',
    '15:30 pm',
    '16:30 pm',
    '17:30 pm'
  ];

  final List<Map<String, dynamic>> stylists = [
    {
      'name': 'Sarah',
      'image': StaticData.myDp,
      'services': [
        'Haircut',
        'Hair Color',
        'Blow-dry',
        'Hair Straightening',
        'Highlight',
        'Hair Smoothing',
        'Hair Rebonding',
        'Hair Styling',
        'Hair Extension',
        'Hair Texturing',
      ],
    },
    {
      'name': 'Madelyn',
      'image': StaticData.myDp,
      'services': [
        'Facial',
        'Threading',
        'Waxing',
        'Clean-up',
        'Bleach',
        'Microdermabrasion',
        'Skin Polishing',
        'Skin Brightening',
        'Chemical Peels',
        'Skin Tightening',
      ],
    },
    {
      'name': 'Isabella',
      'image': StaticData.myDp,
      'services': [
        'Manicure',
        'Pedicure',
        'Nail Art',
        'Gel Nail',
        'Acrylic Nail',
        'Nail Extension',
        'Nail Polish',
        'Nail Shaping',
        'Nail Repair',
        'Nail Care',
      ],
    },
    {
      'name': 'Lily',
      'image': StaticData.myDp, // Add image path for Lily
      'services': [
        'Facial Massage',
        'Acne Treatment',
        'Anti-aging Facial',
        'Moisturizing Facial',
        'Deep Cleaning Facial',
      ],
    },
    {
      'name': 'Emily',
      'image': StaticData.myDp, // Add image path for Emily
      'services': [
        'Body Massage',
        'Aromatherapy',
        'Swedish Massage',
        'Hot Stone Massage',
        'Reflexology',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        builder: (context, double opacity, child) {
          return Opacity(
            opacity: opacity,
            child: Container(
              height: height,
              width: width,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: height * 0.03),
                      _buildHeader(height, width),
                      _buildBody(height, width),
                    ],
                  ),
                  _buildBookButton(height, width),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(double height, double width) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: Container(
            height: height * 0.09,
            width: width * 0.95,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                Text(
                  "Select Date & Time",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child:
                      Icon(Icons.calendar_month, size: 24, color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(double height, double width) {
    return Container(
      height: height * 0.88,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalendar(),
              _buildSectionTitle("Available Slot", width),
              _buildTimeSlots("Morning", morningSlots),
              _buildTimeSlots("Afternoon", afternoonSlots),
              _buildSectionTitle("Choose Specialist", width),
              _buildStylists(height),
              if (_selectedStylist != null) _buildServices(),
              SizedBox(height: height * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.pink[200],
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.pinkAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 13),
      child: Text(
        title,
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTimeSlots(String title, List<String> slots) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Wrap(
            spacing: 10,
            children: slots.map((slot) {
              return ChoiceChip(
                label: Text(slot),
                selected: _selectedTimeSlot == slot,
                onSelected: (selected) {
                  setState(() {
                    _selectedTimeSlot = selected ? slot : null;
                  });
                },
                selectedColor: Colors.pink[200],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStylists(double height) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stylists.map((stylist) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedStylist = stylist['name'];
                _selectedServices.clear();
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(stylist['image'] ?? ''),
                    radius: 30,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    stylist['name']!,
                    style: TextStyle(
                      color: _selectedStylist == stylist['name']
                          ? Colors.pink
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 13, top: 20),
          child: Text(
            "Related Services",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 10,
          children: stylists
              .firstWhere(
                  (stylist) => stylist['name'] == _selectedStylist)['services']
              .map<Widget>((service) {
            return ChoiceChip(
              label: Text(service),
              selected: _selectedServices.contains(service),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedServices.add(service);
                  } else {
                    _selectedServices.remove(service);
                  }
                });
              },
              selectedColor: Colors.pink[200],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBookButton(double height, double width) {
    return Positioned(
      bottom: 10,
      left: 60,
      right: 60,
      child: GestureDetector(
        onTap: _onBookAppointment,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                height: height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.pink[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onBookAppointment() {
    if (_selectedDay != null &&
        _selectedTimeSlot != null &&
        _selectedStylist != null &&
        _selectedServices.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) => TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Center(child: const Text("Appointment Confirmed")),
                    content: Text(
                      "Your appointment is set for ${_selectedDay!.toLocal().toString().split(' ')[0]} "
                      "at $_selectedTimeSlot with $_selectedStylist.\nSelected services:  ${_selectedServices.join(', ')}.",
                    ),
                    actions: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavBar(),
                                ));
                          },
                          child: Text("Thank You "),
                        ),
                      ),
                    ],
                  ),
                );
              }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all selections.")),
      );
    }
  }
}
