import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:uuid/uuid.dart';
import 'package:beautybazzle/model/addsalon/addsalon.dart';

class SalonAppointmentScreen extends StatefulWidget {
  final SalonModel salon;

  const SalonAppointmentScreen({Key? key, required this.salon})
      : super(key: key);

  @override
  _SalonAppointmentScreenState createState() => _SalonAppointmentScreenState();
}

class _SalonAppointmentScreenState extends State<SalonAppointmentScreen> {
  int selectedSlotIndex = -1;
  DateTime selectedDate = DateTime.now();
  SalonSlot? selectedSlot;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Appointment ',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Salon Info Header
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(widget.salon.SalonPicture ?? ''),
                  backgroundColor: Colors.pink[100],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.salon.SalonName ?? 'Salon',
                          style: theme.textTheme.titleLarge),
                      SizedBox(height: 4),
                      Text(widget.salon.salonDescription ?? '',
                          style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Date Picker
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Date', style: theme.textTheme.titleMedium),
                SizedBox(height: 8),
                Container(
                  height: 100,
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: selectedDate,
                    onDateChange: (date) {
                      setState(() {
                        selectedDate = date;
                        selectedSlotIndex = -1;
                        selectedSlot = null;
                      });
                    },
                    selectionColor: Colors.pink,
                    selectedTextColor: Colors.white,
                    dateTextStyle:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ) ??
                            TextStyle(color: Colors.grey), // Fallback if null
                  ),
                ),
              ],
            ),
          ),

          // Available Slots
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available Time Slots',
                      style: theme.textTheme.titleMedium),
                  SizedBox(height: 8),
                  Expanded(
                    child: _buildSlotsGrid(size),
                  ),
                ],
              ),
            ),
          ),

          // Confirm Button
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: selectedSlot == null || isLoading
                  ? null
                  : _confirmAppointment,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('CONFIRM APPOINTMENT',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotsGrid(Size size) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('salon_slots')
          .doc(widget.salon.SalonId)
          .collection('slots')
          .where('date', isEqualTo: Timestamp.fromDate(selectedDate))
          .where('isAvailable', isEqualTo: true)
          .orderBy('startTime')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.schedule, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text('No available slots for this date',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Text('Please try another date',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        final slots = snapshot.data!.docs
            .map((doc) => SalonSlot.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: slots.length,
          itemBuilder: (context, index) {
            final slot = slots[index];
            return _buildSlotItem(slot, index);
          },
        );
      },
    );
  }

  Widget _buildSlotItem(SalonSlot slot, int index) {
    final isSelected = selectedSlotIndex == index;
    return GestureDetector(
      onTap: () => setState(() {
        selectedSlotIndex = index;
        selectedSlot = slot;
      }),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink[200] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.grey,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(slot.startTime,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(slot.endTime,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmAppointment() async {
    if (selectedSlot == null) return;

    setState(() => isLoading = true);

    try {
      final appointmentId = Uuid().v4();
      final userId = widget.salon.SalonId;
      final userName = widget.salon.SalonName; // Replace with actual user name

      // Create appointment document
      await FirebaseFirestore.instance
          .collection('salon_appointments')
          .doc(appointmentId)
          .set({
        'appointmentId': appointmentId,
        'salonId': widget.salon.SalonId,
        'salonName': widget.salon.SalonName,
        'salonImage': widget.salon.SalonPicture,
        'userId': userId,
        'userName': userName,
        'date': Timestamp.fromDate(selectedDate),
        'slot': selectedSlot!.toMap(),
        'status': 'confirmed',
        'createdAt': Timestamp.now(),
        'services': [], 
        'totalPrice': 0.0, 
      });

      // Update slot availability
      await FirebaseFirestore.instance
          .collection('salon_slots')
          .doc(widget.salon.SalonId)
          .collection('slots')
          .doc(selectedSlot!.slotId)
          .update({'isAvailable': false});

      // Show success message
      Fluttertoast.showToast(
        msg: "Appointment booked successfully!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error booking appointment: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
}

class SalonSlot {
  final String slotId;
  final String salonId;
  final String startTime;
  final String endTime;
  final bool isAvailable;
  final String day;
  final DateTime date;

  SalonSlot({
    required this.slotId,
    required this.salonId,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.day,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'slotId': slotId,
      'salonId': salonId,
      'startTime': startTime,
      'endTime': endTime,
      'isAvailable': isAvailable,
      'day': day,
      'date': Timestamp.fromDate(date),
    };
  }

  factory SalonSlot.fromMap(Map<String, dynamic> map) {
    return SalonSlot(
      slotId: map['slotId'] ?? '',
      salonId: map['salonId'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      isAvailable: map['isAvailable'] ?? false,
      day: map['day'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}
