import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:medigo/core/theme/spacing.dart';

class DoctorChatScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const DoctorChatScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorChatScreenState createState() => _DoctorChatScreenState();
}

class _DoctorChatScreenState extends State<DoctorChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showRatingDialog = false;
  double _userRating = 0;

  List<Map<String, dynamic>> _messages = [
    {
      'text': 'Bonjour ! Comment puis-je vous aider aujourd\'hui ?',
      'isFromDoctor': true,
      'timestamp': '10:15',
    },
    {
      'text': 'Bonjour docteur, j\'ai des douleurs dentaires depuis quelques jours.',
      'isFromDoctor': false,
      'timestamp': '10:16',
    },
    {
      'text': 'Je comprends votre préoccupation. Pouvez-vous me décrire la nature de la douleur ? Est-ce constant ou par épisodes ?',
      'isFromDoctor': true,
      'timestamp': '10:17',
    },
    {
      'text': 'C\'est plutôt par épisodes, surtout quand je mange quelque chose de froid ou de sucré.',
      'isFromDoctor': false,
      'timestamp': '10:18',
    },
    {
      'text': 'Cela ressemble à une sensibilité dentaire. Je recommande d\'éviter les aliments très chauds ou froids pour le moment. Pouvez-vous prendre rendez-vous pour un examen ?',
      'isFromDoctor': true,
      'timestamp': '10:19',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Custom header
                _buildCustomHeader(),

                // Messages area
                Expanded(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return _buildMessageBubble(message, index);
                      },
                    ),
                  ),
                ),

                // Message input area
                _buildMessageInput(),
              ],
            ),

            // Rating dialog overlay
            if (_showRatingDialog) _buildRatingDialog(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(200),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, size: 24),
          ),
          SizedBox(width: AppSpacing.space16(context)),

          // Doctor avatar
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: ClipOval(
                  child: Image.asset(
                    widget.doctor['avatar'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(
                          Icons.person,
                          size: 25,
                          color: Colors.grey[600],
                        ),
                  ),
                ),
              ),
              if (widget.doctor['isOnline'])
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(width: AppSpacing.space16(context)),

          // Doctor info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctor['name'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.doctor['specialty'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  widget.doctor['location'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Row(
            children: [
              // Call button
              GestureDetector(
                onTap: _makeCall,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.phone,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 20,
                  ),
                ),
              ),

              SizedBox(width: AppSpacing.space8(context)),

              // Menu button
              GestureDetector(
                onTap: _showMenuOptions,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, int index) {
    final isFromDoctor = message['isFromDoctor'];
    final isLastMessage = index == _messages.length - 1;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          if (isFromDoctor)
            BubbleSpecialThree(
              text: message['text'],
              color: Theme.of(context).colorScheme.secondary,
              tail: true,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          else
            BubbleSpecialThree(
              text: message['text'],
              color: Colors.grey[200]!,
              tail: true,
              isSender: false,
              textStyle: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),

          // Timestamp
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              message['timestamp'],
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Tapez votre message...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                onSubmitted: (text) => _sendMessage(text),
                maxLines: null,
              ),
            ),
          ),
          SizedBox(width: AppSpacing.space8(context)),

          // Voice message button
          GestureDetector(
            onTap: _recordVoiceMessage,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mic,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ),

          SizedBox(width: AppSpacing.space8(context)),

          // Send button
          GestureDetector(
            onTap: () => _sendMessage(_messageController.text),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingDialog() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Doctor avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      widget.doctor['avatar'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                    ),
                  ),
                ),

                SizedBox(height: AppSpacing.space16(context)),

                Text(
                  "Evaluez ${widget.doctor['name']}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: AppSpacing.space16(context)),

                // Star rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _userRating = index + 1.0;
                        });
                      },
                      child: Icon(
                        index < _userRating ? Icons.star : Icons.star_border,
                        color:  Theme.of(context).colorScheme.onSurface,
                        size: 40,
                      ),
                    );
                  }),
                ),

                SizedBox(height: AppSpacing.space32(context)),

                // Finish button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitRating,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text("Finir"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': text.trim(),
        'isFromDoctor': false,
        'timestamp': _getCurrentTime(),
      });
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate doctor response after a delay
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': _generateDoctorResponse(text),
            'isFromDoctor': true,
            'timestamp': _getCurrentTime(),
          });
        });
        _scrollToBottom();
      }
    });
  }

  String _generateDoctorResponse(String userMessage) {
    final responses = [
      "Merci pour cette information. Pouvez-vous me donner plus de détails ?",
      "Je comprends votre préoccupation. Avez-vous déjà eu ce type de symptômes ?",
      "D'après ce que vous me décrivez, je recommande de prendre rendez-vous pour un examen.",
      "C'est important de surveiller ces symptômes. Y a-t-il autre chose qui vous inquiète ?",
      "Je vais noter ces informations. Prenez-vous actuellement des médicaments ?",
      "Pouvez-vous me dire depuis quand vous ressentez ces symptômes ?",
      "Avez-vous pris des médicaments pour soulager la douleur ?",
    ];

    return responses[DateTime.now().millisecond % responses.length];
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }

  void _makeCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Appel vers ${widget.doctor['name']}..."),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _recordVoiceMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Fonctionnalité d'enregistrement vocal bientôt disponible"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _showMenuOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.star, color: Theme.of(context).colorScheme.onSurface),
              title: Text("Évaluer le médecin"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _showRatingDialog = true;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.block, color: Colors.red),
              title: Text("Terminer la consultation"),
              onTap: () {
                Navigator.pop(context);
                _endConsultation();
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text("Informations du médecin"),
              onTap: () {
                Navigator.pop(context);
                _showDoctorInfo();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _endConsultation() {
    setState(() {
      _showRatingDialog = true;
    });
  }

  void _showDoctorInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.doctor['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Spécialité: ${widget.doctor['specialty']}"),
            Text("Lieu: ${widget.doctor['location']}"),
            Text("Note: ${widget.doctor['rating']} ⭐"),
            Text("Statut: ${widget.doctor['isOnline'] ? 'En ligne' : 'Hors ligne'}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fermer"),
          ),
        ],
      ),
    );
  }

  void _submitRating() {
    setState(() {
      _showRatingDialog = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Merci pour votre évaluation de ${_userRating.toInt()} étoiles !"),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back to consultation screen
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}