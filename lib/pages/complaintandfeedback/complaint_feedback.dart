import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// Color constants matching the CSS palette
const Color red900603 = Color(0xFF900603);
const Color redB10707 = Color(0xFFB10707);
const Color grayF3F4F6 = Color(0xFFF3F4F6);
const Color grayF9FAFB = Color(0xFFF9FAFB);
const Color grayE5E7EB = Color(0xFFE5E7EB);
const Color grayD1D5DB = Color(0xFFD1D5DB);
const Color gray6B7280 = Color(0xFF6B7280);
const Color gray111827 = Color(0xFF111827);
const Color green065F46 = Color(0xFF065F46);
const Color redB91C1C = Color(0xFFB91C1C);
const Color amber92400E = Color(0xFF92400E);
const Color grayD1FAE5 = Color(0xFFD1FAE5);
const Color whiteColor = Colors.white;

// Entry widget
void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: SafeArea(child: ComplaintFeedback()),
      backgroundColor: grayF3F4F6,
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class ComplaintFeedback extends StatefulWidget {
  const ComplaintFeedback({Key? key}) : super(key: key);

  @override
  ComplaintFeedbackState createState() => ComplaintFeedbackState();
}

class ComplaintFeedbackState extends State<ComplaintFeedback> {
  // Form fields
  String type = '';
  String category = '';
  String priority = 'Low';
  String subject = '';
  String description = '';
  String contactMethod = '';

  String formMessage = '';
  bool isFormSuccess = false;

  List<Ticket> tickets = [];

  bool isChatOpen = false;
  bool showDetailsModal = false;
  Ticket? selectedTicket;

  // Controllers for text fields
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  // Responsive layout constraints
  static const double maxContentWidth = 1200;

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void resetForm() {
    setState(() {
      type = '';
      category = '';
      priority = 'Low';
      subject = '';
      description = '';
      contactMethod = '';
      subjectController.clear();
      descriptionController.clear();
    });
  }

  void handleSubmit() {
    if (subject.trim().isEmpty ||
        description.trim().isEmpty ||
        contactMethod.trim().isEmpty) {
      setState(() {
        isFormSuccess = false;
        formMessage = 'Please fill all required fields.';
      });
      return;
    }
    final newTicket = Ticket(
      id: 'TKT${Random().nextInt(900000) + 100000}',
      subject: subject.trim(),
      type: type.trim(),
      date: DateTime.now(),
      status: TicketStatus.pending,
      priority: parsePriority(priority),
    );
    setState(() {
      tickets.insert(0, newTicket);
      isFormSuccess = true;
      formMessage = 'Your ticket has been submitted successfully!';
      resetForm();
    });
  }

  TicketPriority parsePriority(String p) {
    switch (p.toLowerCase()) {
      case 'high':
        return TicketPriority.high;
      case 'medium':
        return TicketPriority.medium;
      default:
        return TicketPriority.low;
    }
  }

  TicketStatus getStatusFromString(String s) {
    switch (s.toLowerCase()) {
      case 'pending':
        return TicketStatus.pending;
      case 'resolved':
        return TicketStatus.resolved;
      case 'in progress':
        return TicketStatus.inProgress;
      default:
        return TicketStatus.pending;
    }
  }

  void handleViewDetails(Ticket ticket) {
    setState(() {
      selectedTicket = ticket;
      showDetailsModal = true;
    });
  }

  Widget buildTicketBadgeStatus(Ticket ticket) {
    switch (ticket.status) {
      case TicketStatus.pending:
        return Badge(
          text: 'Pending',
          bgColor: const Color(0xFFfee2e2),
          textColor: redB91C1C,
          icon: Icons.warning_amber_outlined,
        );
      case TicketStatus.resolved:
        return Badge(
          text: 'Resolved',
          bgColor: const Color(0xFFd1fae5),
          textColor: green065F46,
          icon: Icons.check_circle_outline,
        );
      case TicketStatus.inProgress:
        return Badge(
          text: 'In Progress',
          bgColor: const Color(0xFFfef3c7),
          textColor: amber92400E,
          icon: Icons.loop,
        );
    }
  }

  Widget buildTicketBadgePriority(Ticket ticket) {
    switch (ticket.priority) {
      case TicketPriority.high:
        return Badge(
          text: 'High Priority',
          bgColor: const Color(0xFFfef3c7),
          textColor: amber92400E,
          icon: Icons.arrow_upward,
        );
      case TicketPriority.medium:
        return Badge(
          text: 'Medium Priority',
          bgColor: grayF3F4F6,
          textColor: gray6B7280,
          icon: Icons.circle_outlined,
        );
      case TicketPriority.low:
        return Badge(
          text: 'Low Priority',
          bgColor: const Color(0xFFd1fae5),
          textColor: green065F46,
          icon: Icons.remove_circle_outline,
        );
    }
  }

  // Hardcoded tickets equivalent from React example
  List<Ticket> get hardcodedTickets => [
        Ticket(
          id: 'TKT001234',
          subject: 'Transaction failed but amount debited',
          type: 'Complaint',
          date: DateTime.parse('2025-01-08'),
          status: TicketStatus.inProgress,
          priority: TicketPriority.high,
        ),
        Ticket(
          id: 'TKT001235',
          subject: 'Suggestion for mobile app improvement',
          type: 'Feedback',
          date: DateTime.parse('2025-01-05'),
          status: TicketStatus.resolved,
          priority: TicketPriority.low,
        ),
        Ticket(
          id: 'TKT001236',
          subject: 'Card blocked without notification',
          type: 'Complaint',
          date: DateTime.parse('2025-01-03'),
          status: TicketStatus.pending,
          priority: TicketPriority.medium,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    // Combine user tickets + hardcoded tickets from original
    final allTickets = [...tickets, ...hardcodedTickets];

    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final isMobile = maxWidth < 768;

      return Container(
        color: grayF3F4F6,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
                  color: red900603,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complaint & Feedback',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: isMobile ? double.infinity : 640,
                        child: const Text(
                          "Fill in the details and we'll get back to you within the stipulated business hours",
                          style: TextStyle(
                            color: Color(0xFFF0F0F0),
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Area
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: isMobile
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildFormSection(),
                                const SizedBox(height: 24),
                                buildSidebarSection(allTickets),
                                const SizedBox(height: 24),
                                buildFaqSection(),
                              ],
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 6, child: buildFormSection()),
                              const SizedBox(width: 24),
                              Expanded(flex: 4, child: buildSidebarSection(allTickets)),
                            ],
                          ),
                  ),
                ),

                // FAQ at bottom only for wider screens
                if (!isMobile)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: buildFaqSection(),
                  ),

                // Modals and Chat
                if (isChatOpen) LiveChatModal(onClose: () => setState(() => isChatOpen = false)),
                if (showDetailsModal && selectedTicket != null)
                  DetailsModal(
                    ticket: selectedTicket!,
                    onClose: () => setState(() => showDetailsModal = false),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Form widget section
  Widget buildFormSection() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            decoration: BoxDecoration(
              color: red900603,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Submit Your Concern',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Fill out the form below and we'll get back to you as soon as possible.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // Card Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (formMessage.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: isFormSuccess ? const Color(0xFFD1FAE5) : const Color(0xFFfee2e2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      formMessage,
                      style: TextStyle(
                        color: isFormSuccess ? green065F46 : red900603,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDropdownFormField(
                        labelText: 'Type',
                        value: type,
                        mandatory: true,
                        items: const [
                          DropdownMenuItem(value: '', child: Text('Select type')),
                          DropdownMenuItem(value: 'Complaint', child: Text('Complaint')),
                          DropdownMenuItem(value: 'Feedback', child: Text('Feedback')),
                          DropdownMenuItem(value: 'Suggestion', child: Text('Suggestion')),
                        ],
                        onChanged: (val) => setState(() => type = val ?? ''),
                      ),
                      buildDropdownFormField(
                        labelText: 'Category',
                        value: category,
                        mandatory: true,
                        items: const [
                          DropdownMenuItem(value: '', child: Text('Select category')),
                          DropdownMenuItem(value: 'Account Issues', child: Text('Account Issues')),
                          DropdownMenuItem(value: 'Transaction Problems', child: Text('Transaction Problems')),
                          DropdownMenuItem(value: 'Card Related', child: Text('Card Related')),
                          DropdownMenuItem(value: 'Loan Services', child: Text('Loan Services')),
                          DropdownMenuItem(value: 'Investment Issues', child: Text('Investment Issues')),
                          DropdownMenuItem(value: 'Mobile/Internet Banking', child: Text('Mobile/Internet Banking')),
                          DropdownMenuItem(value: 'Customer Service', child: Text('Customer Service')),
                          DropdownMenuItem(value: 'Other', child: Text('Other')),
                        ],
                        onChanged: (val) => setState(() => category = val ?? ''),
                      ),
                      buildDropdownFormField(
                        labelText: 'Priority',
                        value: priority,
                        mandatory: true,
                        items: const [
                          DropdownMenuItem(value: 'Low', child: Text('Low')),
                          DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                          DropdownMenuItem(value: 'High', child: Text('High')),
                        ],
                        onChanged: (val) => setState(() => priority = val ?? 'Low'),
                      ),
                      buildTextFormField(
                        labelText: 'Subject',
                        controller: subjectController,
                        onChanged: (val) => setState(() => subject = val),
                        hintText: 'Enter subject',
                        mandatory: true,
                      ),
                      buildTextFormField(
                        labelText: 'Description',
                        controller: descriptionController,
                        onChanged: (val) => setState(() => description = val),
                        hintText: 'Describe the issue or feedback',
                        mandatory: true,
                        minLines: 4,
                        maxLines: 6,
                      ),
                      buildDropdownFormField(
                        labelText: 'Preferred Contact Method',
                        value: contactMethod,
                        mandatory: true,
                        items: const [
                          DropdownMenuItem(value: '', child: Text('Select preferred contact method')),
                          DropdownMenuItem(value: 'Email', child: Text('Email')),
                          DropdownMenuItem(value: 'Phone', child: Text('Phone')),
                        ],
                        onChanged: (val) => setState(() => contactMethod = val ?? ''),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: red900603,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Sidebar section
  Widget buildSidebarSection(List<Ticket> allTickets) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Recent tickets card
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Recent Tickets',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: gray111827),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Track the status of your submitted concerns',
                  style: TextStyle(fontSize: 14, color: gray6B7280),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allTickets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final ticket = allTickets[index];
                    return TicketCard(
                      ticket: ticket,
                      statusBadge: buildTicketBadgeStatus(ticket),
                      priorityBadge: buildTicketBadgePriority(ticket),
                      onViewDetails: () => handleViewDetails(ticket),
                    );
                  },
                )
              ],
            ),
          ),

          // Contact buttons
          const SizedBox(height: 24),
          ContactButtons(
            onChatTap: () => setState(() => isChatOpen = true),
          ),
        ],
      ),
    );
  }

  // FAQ section widget
  Widget buildFaqSection() {
    final faqCards = [
      FaqCard(
        question: 'How long does it take to resolve a complaint?',
        answer:
            'Most complaints are resolved within 7 working days. For complex issues, it may take up to 15 business days.',
      ),
      FaqCard(
        question: 'Can I track my complaint status?',
        answer:
            'Yes, you can track your complaint status using your ticket ID provided when you submitted your complaint.',
      ),
      FaqCard(
        question: 'What information should I include in my complaint?',
        answer:
            'Please include relevant details, dates, amounts, and any relevant screenshots or documents.',
      ),
      FaqCard(
        question: 'Is there a fee for filing a complaint?',
        answer:
            'No, filing a complaint or providing feedback is completely free of charge.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: red900603,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Get answers to common questions',
          style: TextStyle(
            fontSize: 15,
            color: gray6B7280,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (context, constraints) {
          int crossAxisCount = 1;
          final width = constraints.maxWidth;
          if (width > 900) crossAxisCount = 4;
          else if (width > 600) crossAxisCount = 2;
          return GridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: faqCards,
          );
        }),
      ],
    );
  }

  // Build single-form dropdown field
  Widget buildDropdownFormField({
    required String labelText,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    bool mandatory = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mandatory ? '$labelText *' : labelText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: grayD1D5DB),
              boxShadow: [
                if (value.isNotEmpty)
                  const BoxShadow(
                    color: Color(0x90120404),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
              ],
            ),
            child: DropdownButtonFormField<String>(
              value: value.isEmpty ? null : value,
              items: items,
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                isDense: true,
              ),
              dropdownColor: whiteColor,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // Build single-form text or textarea field
  Widget buildTextFormField({
    required String labelText,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    String? hintText,
    bool mandatory = false,
    int minLines = 1,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mandatory ? '$labelText *' : labelText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: grayD1D5DB),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: red900603, width: 2),
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// Badge widget with icon and text
class Badge extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final IconData icon;

  const Badge({
    Key? key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Ticket model and enums
enum TicketStatus { pending, resolved, inProgress }

enum TicketPriority { low, medium, high }

class Ticket {
  final String id;
  final String subject;
  final String type;
  final DateTime date;
  final TicketStatus status;
  final TicketPriority priority;

  Ticket({
    required this.id,
    required this.subject,
    required this.type,
    required this.date,
    required this.status,
    required this.priority,
  });
}

// Ticket card widget
class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final Widget statusBadge;
  final Widget priorityBadge;
  final VoidCallback onViewDetails;

  const TicketCard({
    Key? key,
    required this.ticket,
    required this.statusBadge,
    required this.priorityBadge,
    required this.onViewDetails,
  }) : super(key: key);

  String formatDate(DateTime d) {
    final y = d.year.toString();
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: grayF9FAFB,
        border: Border.all(color: grayE5E7EB),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row subject, meta, status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ticket.subject,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 2),
                    Text(
                      '${ticket.id} • ${ticket.type} • ${formatDate(ticket.date)}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: gray6B7280,
                      ),
                    ),
                  ],
                ),
              ),
              statusBadge,
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              priorityBadge,
              const Spacer(),
              TextButton(
                onPressed: onViewDetails,
                style: TextButton.styleFrom(
                  backgroundColor: whiteColor,
                  side: const BorderSide(color: red900603),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  foregroundColor: red900603,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text('View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Details modal
class DetailsModal extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback onClose;

  const DetailsModal({Key? key, required this.ticket, required this.onClose})
      : super(key: key);

  String formatDate(DateTime d) {
    final y = d.year.toString();
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  String ticketStatusText(TicketStatus s) {
    switch (s) {
      case TicketStatus.pending:
        return 'Pending';
      case TicketStatus.resolved:
        return 'Resolved';
      case TicketStatus.inProgress:
        return 'In Progress';
    }
  }

  String ticketPriorityText(TicketPriority p) {
    switch (p) {
      case TicketPriority.low:
        return 'Low';
      case TicketPriority.medium:
        return 'Medium';
      case TicketPriority.high:
        return 'High';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalOverlay(
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Ticket Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20)),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, size: 24),
                    onPressed: onClose,
                    splashRadius: 18,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabelText('Ticket ID:'),
                  Text(ticket.id, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  buildLabelText('Subject:'),
                  Text(ticket.subject, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  buildLabelText('Type:'),
                  Text(ticket.type, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  buildLabelText('Status:'),
                  Text(ticketStatusText(ticket.status),
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  buildLabelText('Priority:'),
                  Text(ticketPriorityText(ticket.priority),
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),

            // Footer with button
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red900603,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                onPressed: onClose,
                child: const Text(
                  'Close',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLabelText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
    );
  }
}

// Modal overlay background
class ModalOverlay extends StatelessWidget {
  final Widget child;

  const ModalOverlay({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: child,
        ),
      ),
    );
  }
}

// Chat modal widget including chat state
class LiveChatModal extends StatefulWidget {
  final VoidCallback onClose;

  const LiveChatModal({Key? key, required this.onClose}) : super(key: key);

  @override
  LiveChatModalState createState() => LiveChatModalState();
}

class LiveChatModalState extends State<LiveChatModal> {
  final List<ChatMessage> messages = [
    ChatMessage(text: 'Hello! How can I help you today?', sender: Sender.bot)
  ];

  final TextEditingController inputController = TextEditingController();
  String? selectedImagePath;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to bottom each time messages updates after frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 60,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void addMessage(ChatMessage msg) {
    setState(() {
      messages.add(msg);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  void handleSend() {
    final text = inputController.text.trim();

    if (text.isEmpty && selectedImagePath == null) return;

    if (selectedImagePath != null) {
      addMessage(ChatMessage(imagePath: selectedImagePath, sender: Sender.user));
      selectedImagePath = null;
    } else {
      addMessage(ChatMessage(text: text, sender: Sender.user));
      inputController.clear();
    }

    // Simulate bot response after delay
    Timer(const Duration(seconds: 1), () {
      addMessage(ChatMessage(
          text: 'Thank you! An agent will be with you shortly.',
          sender: Sender.bot));
    });
  }

  void pickImage() async {
    // Since no third-party packages allowed, simulate by placeholder image
    // In real app you would use image_picker package
    // For now, we simulate picking an image by setting a placeholder image url
    // This matches the React code functionality as closely as possible
    setState(() {
      selectedImagePath =
          'https://via.placeholder.com/150.png?text=Selected+Image'; // Simulated
      inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalOverlay(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: red900603,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Live Chat Neo Bank',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 24),
                    splashRadius: 20,
                    onPressed: widget.onClose,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Body messages
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: grayF3F4F6,
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: messages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return Align(
                      alignment: msg.sender == Sender.user
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.of(context).size.width * 0.75),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(
                                msg.sender == Sender.bot ? 0 : 16),
                            bottomRight: Radius.circular(
                                msg.sender == Sender.user ? 0 : 16),
                          ),
                          color: msg.sender == Sender.user
                              ? const Color(0xFF780606)
                              : const Color(0xFFD1D5DB),
                        ),
                        child: msg.messageWidget(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Input area
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Row(
                    children: [
                      // Attach image button
                      IconButton(
                        icon: const Icon(Icons.attach_file),
                        color: gray6B7280,
                        onPressed: pickImage,
                        tooltip: 'Attach image',
                      ),

                      // Text input
                      Expanded(
                        child: TextField(
                          controller: inputController,
                          enabled: selectedImagePath == null,
                          decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: grayD1D5DB, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: grayD1D5DB, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: red900603, width: 2),
                            ),
                            isDense: true,
                            isCollapsed: false,
                          ),
                          onSubmitted: (_) => handleSend(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),

                      // Send button
                      IconButton(
                        icon: const Icon(Icons.send),
                        color: red900603,
                        onPressed: (inputController.text.trim().isEmpty &&
                                selectedImagePath == null)
                            ? null
                            : handleSend,
                        tooltip: 'Send message',
                      ),
                    ],
                  ),

                  // Selected image preview
                  if (selectedImagePath != null)
                    Positioned(
                      bottom: 56,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: grayF3F4F6,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.image, color: gray6B7280),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Image ready to send.',
                                style:
                                    TextStyle(fontSize: 12, color: gray6B7280),
                              ),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.close, color: Colors.redAccent),
                              onPressed: () {
                                setState(() => selectedImagePath = null);
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashRadius: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Chat message model
enum Sender { user, bot }

class ChatMessage {
  final String? text;
  final String? imagePath; // Base64 or URL path simulation
  final Sender sender;

  ChatMessage({this.text, this.imagePath, required this.sender});

  Widget messageWidget() {
    if (imagePath != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text != null && text!.isNotEmpty)
            Text(text!, style: TextStyle(color: sender == Sender.user ? whiteColor : gray111827)),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imagePath!,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    }
    return Text(
      text ?? '',
      style: TextStyle(
        color: sender == Sender.user ? whiteColor : gray111827,
        fontSize: 14,
        height: 1.3,
      ),
    );
  }
}

// Contact buttons on sidebar bottom
class ContactButtons extends StatelessWidget {
  final VoidCallback onChatTap;

  const ContactButtons({Key? key, required this.onChatTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle =
        const TextStyle(fontWeight: FontWeight.w600, color: gray111827);
    TextStyle subtitleStyle =
        const TextStyle(fontSize: 14, color: gray6B7280, height: 1.2);

    return Column(
      children: [
        ElevatedButton(
          onPressed: onChatTap,
          style: ElevatedButton.styleFrom(
            foregroundColor: green065F46,
            backgroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            side: const BorderSide(color: grayE5E7EB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: red900603,
                child: const Icon(Icons.message, size: 24, color: whiteColor),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Live Chat Neo Bank', style: titleStyle),
                    Text('Available 24x7 • Avg wait 2 mins', style: subtitleStyle),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFdcfce7),
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: green065F46,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            // No navigation package; simulating navigation button disabled
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Navigate to /Client/email-support not implemented'),
            ));
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFF1E3A8A),
            backgroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            side: const BorderSide(color: grayE5E7EB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: red900603,
                child: const Icon(Icons.mail_outline, size: 24, color: whiteColor),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Support', style: titleStyle.copyWith(color: const Color(0xFF1E3A8A))),
                    Text('Response within 4-6 hours', style: subtitleStyle.copyWith(color: const Color(0xFF1E3A8A))),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFdbeafe),
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'Send Email',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Phone contact block
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: grayE5E7EB),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 1),
              )
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: red900603,
                child: const Icon(Icons.phone, color: whiteColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer Care', style: titleStyle),
                    Text('1860-419-5555 • Mon-Sun 8AM-8PM', style: subtitleStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// FAQ card widget
class FaqCard extends StatefulWidget {
  final String question;
  final String answer;

  const FaqCard({Key? key, required this.question, required this.answer})
      : super(key: key);

  @override
  _FaqCardState createState() => _FaqCardState();
}

class _FaqCardState extends State<FaqCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F1F1)),
          boxShadow: isHover
              ? [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 14,
                    offset: Offset(0, 4),
                  )
                ]
              : [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  )
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question,
                style: const TextStyle(
                    color: red900603,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 1.3)),
            const SizedBox(height: 12),
            Text(widget.answer,
                style: const TextStyle(
                    fontSize: 14, color: gray111827, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
