import 'dart:async';
import 'package:beautybazzle/model/appoinment/appoinment.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/bottom_bar/bottom_Nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentReminderScreen extends StatefulWidget {
  const AppointmentReminderScreen({super.key});

  @override
  State<AppointmentReminderScreen> createState() =>
      _AppointmentReminderScreenState();
}

class _AppointmentReminderScreenState extends State<AppointmentReminderScreen> {
  StreamSubscription<QuerySnapshot>? _appointmentsStream;
  List<AppointmentModel> _appointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  @override
  void dispose() {
    _appointmentsStream?.cancel();
    super.dispose();
  }

  Future<void> _loadAppointments() async {
    final userId = StaticData.userModel!.UserId;

    _appointmentsStream?.cancel(); // cancel previous stream if any

    _appointmentsStream = FirebaseFirestore.instance
        .collection('salon_appointments')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: false)
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        final List<AppointmentModel> fetched = [];
        for (var doc in snapshot.docs) {
          try {
            fetched.add(AppointmentModel.fromMap(doc.data()));
          } catch (e) {
            print("Error parsing appointment: $e");
          }
        }

        setState(() {
          _appointments = fetched;
          _isLoading = false;
        });
      }
    }, onError: (error) {
      print("Stream error: $error");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          children: [
            _buildAppBar(width),
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _appointments.isEmpty
                      ? _buildEmptyState()
                      : _buildAppointmentsList(height, width),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double width) {
    return Padding(
      padding: EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            ),
          ),
          Text(
            "Appointment Reminder",
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.pink[200],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 60, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            "No Appointments Scheduled",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Book an appointment to see it here",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadAppointments,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
              foregroundColor: Colors.white,
            ),
            child: Text("Refresh"),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList(double height, double width) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        final appointment = _appointments[index];
        return _buildAppointmentCard(appointment, height, width);
      },
    );
  }

  Widget _buildAppointmentCard(
      AppointmentModel appointment, double height, double width) {
    final date = appointment.date;
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final formattedTime = appointment.slot['startTime'] ?? '';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        height: height * 0.18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          title: Text(
            "Appointment Confirmed",
            style: TextStyle(
              fontSize: width * 0.042,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                "Your appointment is set for $formattedDate at $formattedTime",
                style: TextStyle(
                  fontSize: width * 0.036,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "With: ${appointment.salonName}",
                style: TextStyle(
                  fontSize: width * 0.036,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Services: ${appointment.services.join(', ')}",
                style: TextStyle(
                  fontSize: width * 0.036,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.notifications_active, color: Colors.pink[200]),
            onPressed: () {
              // Notification reminder logic can be placed here
            },
          ),
        ),
      ),
    );
  }
}
