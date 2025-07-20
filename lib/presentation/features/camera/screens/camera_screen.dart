// File: lib/presentation/features/prescription/screens/camera_screen.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:medigo/presentation/features/camera/screens/prescription_result_screen.dart';
import 'dart:io';

import '../../../../service/camera_service.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isCapturing = false;
  bool _isProcessing = false;
  String? _capturedImagePath;
  bool _flashEnabled = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      print('Initializing camera...');

      // Get available cameras
      _cameras = await availableCameras();
      print('Found ${_cameras?.length ?? 0} cameras');

      if (_cameras != null && _cameras!.isNotEmpty) {
        // Initialize the first camera (usually back camera)
        _controller = CameraController(
          _cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg, // Ensure JPEG format
        );

        await _controller!.initialize();
        print('Camera initialized successfully');

        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      } else {
        throw Exception('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
      _showCameraError();
    }
  }

  void _showCameraError() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur d\'accès à la caméra: ${_getCameraErrorMessage()}'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Réessayer',
            onPressed: _initializeCamera,
          ),
        ),
      );
    }
  }

  String _getCameraErrorMessage() {
    if (_cameras == null || _cameras!.isEmpty) {
      return 'Aucune caméra disponible';
    }
    return 'Impossible d\'initialiser la caméra';
  }

  @override
  void dispose() {
    print('Disposing camera controller');
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen while camera initializes
    if (!_isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Initialisation de la caméra...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera preview or captured image
            Positioned.fill(
              child: _capturedImagePath == null
                  ? (_controller != null ? CameraPreview(_controller!) : Container())
                  : _buildImagePreview(),
            ),

            // Processing overlay
            if (_isProcessing) _buildProcessingOverlay(),

            // Camera frame overlay (only when not captured and not processing)
            if (_capturedImagePath == null && !_isProcessing) _buildCameraFrame(),

            // Guidance text overlay
            if (_capturedImagePath == null && !_isProcessing) _buildGuidanceText(),

            // Top bar
            if (!_isProcessing) _buildTopBar(),

            // Bottom controls
            if (!_isProcessing) _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Image.file(
      File(_capturedImagePath!),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Error loading image: $error');
        return Container(
          color: Colors.grey[800],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white, size: 48),
                SizedBox(height: 16),
                Text(
                  'Erreur de chargement de l\'image',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProcessingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 4,
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Analyse en cours...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Identification des médicaments',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraFrame() {
    return Center(
      child: Container(
        width: 320,
        height: 420,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildGuidanceText() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.15,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "Placez votre ordonnance dans le cadre",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Title
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Scanner Ordonnance",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Flash button
          GestureDetector(
            onTap: _toggleFlash,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _flashEnabled ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: _capturedImagePath == null
            ? _buildCaptureButton()
            : _buildActionButtons(),
      ),
    );
  }

  Widget _buildCaptureButton() {
    return Center(
      child: GestureDetector(
        onTap: _isCapturing ? null : _captureImage,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: _isCapturing ? Colors.grey : Colors.green,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
          ),
          child: _isCapturing
              ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Retake button
        GestureDetector(
          onTap: _retakeImage,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              "Reprendre",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // Camera button (for another shot)
        GestureDetector(
          onTap: _captureImage,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),

        // Validate button
        GestureDetector(
          onTap: _validateImage,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              "Valider",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print('Camera controller not initialized');
      return;
    }

    setState(() {
      _isCapturing = true;
    });

    try {
      print('Capturing image...');

      // Take the picture
      final XFile image = await _controller!.takePicture();
      print('Image captured at: ${image.path}');

      // Verify file exists and has content
      final file = File(image.path);
      if (await file.exists()) {
        final fileSize = await file.length();
        print('Captured image size: $fileSize bytes');

        if (fileSize > 0) {
          setState(() {
            _capturedImagePath = image.path;
            _isCapturing = false;
          });

          // Show success feedback
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Photo capturée avec succès !"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              ),
            );
          }
        } else {
          throw Exception('Captured image file is empty');
        }
      } else {
        throw Exception('Captured image file does not exist');
      }
    } catch (e) {
      print('Error capturing image: $e');
      setState(() {
        _isCapturing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors de la capture: ${e.toString()}"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _retakeImage() {
    print('Retaking image');
    setState(() {
      _capturedImagePath = null;
    });
  }

  Future<void> _validateImage() async {
    if (_capturedImagePath == null) {
      print('No image to validate');
      return;
    }

    print('Starting image validation and upload');
    setState(() {
      _isProcessing = true;
    });

    try {
      // Verify file still exists before upload
      final file = File(_capturedImagePath!);
      if (!await file.exists()) {
        throw Exception('Image file no longer exists');
      }

      print('Uploading image to API...');
      final response = await PrescriptionApiService.uploadPrescription(_capturedImagePath!);
      print('API response received successfully');

      setState(() {
        _isProcessing = false;
      });

      // Navigate to results screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PrescriptionResultsScreen(
              imagePath: _capturedImagePath!,
              medications: response.medicamentsList,
            ),
          ),
        );
      }

    } catch (e) {
      print('Error in _validateImage: $e');
      setState(() {
        _isProcessing = false;
      });

      // Show error message with detailed information
      if (mounted) {
        String errorMessage = _getErrorMessage(e);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Réessayer',
              textColor: Colors.white,
              onPressed: _validateImage,
            ),
          ),
        );
      }
    }
  }

  String _getErrorMessage(dynamic error) {
    String errorString = error.toString().toLowerCase();

    if (errorString.contains('socketexception') || errorString.contains('connection refused')) {
      return "Impossible de se connecter au serveur. Vérifiez votre connexion et l'adresse IP.";
    } else if (errorString.contains('timeout')) {
      return "La requête a expiré. Le serveur met trop de temps à répondre.";
    } else if (errorString.contains('format')) {
      return "Erreur de format dans la réponse du serveur.";
    } else if (errorString.contains('file')) {
      return "Erreur avec le fichier image. Veuillez reprendre la photo.";
    } else {
      return "Erreur: ${error.toString()}";
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      setState(() {
        _flashEnabled = !_flashEnabled;
      });

      await _controller!.setFlashMode(
        _flashEnabled ? FlashMode.torch : FlashMode.off,
      );

      print('Flash ${_flashEnabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      print('Error toggling flash: $e');
      // Reset flash state if there's an error
      setState(() {
        _flashEnabled = false;
      });
    }
  }
}