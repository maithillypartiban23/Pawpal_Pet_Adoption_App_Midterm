import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pawpal_pet_adoption/models/user.dart';
import 'package:pawpal_pet_adoption/myconfig.dart';

class SubmitPetScreen extends StatefulWidget {
  final User? user;

  const SubmitPetScreen({super.key, required this.user});

  @override
  State<SubmitPetScreen> createState() => _SubmitPetScreenState();
}

class _SubmitPetScreenState extends State<SubmitPetScreen> {
  List<String> petType = [
    'Dog',
    'Cat',
    'Rabbit',
    'Other',
  ];

  List<String> category = [
    'Adoption',
    'Donation Request',
    'Help/Rescue',
  ];
  
  TextEditingController petNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  String selectedPetType = 'Dog';
  String selectedCategory = 'Adoption';
  
  // For images - following the same structure as reference
  List<File?> images = [null, null, null];
  List<Uint8List?> webImages = [null, null, null];
  
  // For location
  late Position myposition;
  late double height, width;
  bool isLoading = false;
  int maxImg = 3;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    if (width > 600) {
      width = 600;
    } else {
      width = width;
    }
    
    return Scaffold(
    appBar: AppBar(
    title: const Text('My New Pet Page'),
    backgroundColor: const Color(0xFFA66A46), // Green color for AppBar
   
  ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  
                 //3 Images
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image 1
                      GestureDetector(
                        onTap: () {
                          if (kIsWeb) {
                            openGallery(0);
                          } else {
                            pickimagedialog(0);
                          }
                        },
                        child: Container(
                          width: width / 3.3,
                          height: width / 3.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade400),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            image: (images[0] != null && !kIsWeb)
                                ? DecorationImage(
                                    image: FileImage(images[0]!),
                                    fit: BoxFit.cover,
                                  )
                                : (webImages[0] != null)
                                ? DecorationImage(
                                    image: MemoryImage(webImages[0]!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: (images[0] == null && webImages[0] == null)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Tap to add Image 1",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      ),
                      
                      // Image 2
                      GestureDetector(
                        onTap: () {
                          if (kIsWeb) {
                            openGallery(1);
                          } else {
                            pickimagedialog(1);
                          }
                        },
                        child: Container(
                          width: width / 3.3,
                          height: width / 3.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade400),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            image: (images[1] != null && !kIsWeb)
                                ? DecorationImage(
                                    image: FileImage(images[1]!),
                                    fit: BoxFit.cover,
                                  )
                                : (webImages[1] != null)
                                ? DecorationImage(
                                    image: MemoryImage(webImages[1]!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: (images[1] == null && webImages[1] == null)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Tap to add Image 2",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      ),
                      
                      // Image 3
                      GestureDetector(
                        onTap: () {
                          if (kIsWeb) {
                            openGallery(2);
                          } else {
                            pickimagedialog(2);
                          }
                        },
                        child: Container(
                          width: width / 3.3,
                          height: width / 3.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade400),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            image: (images[2] != null && !kIsWeb)
                                ? DecorationImage(
                                    image: FileImage(images[2]!),
                                    fit: BoxFit.cover,
                                  )
                                : (webImages[2] != null)
                                ? DecorationImage(
                                    image: MemoryImage(webImages[2]!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: (images[2] == null && webImages[2] == null)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Tap to add Image 3",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 10),
                  
                  TextField(
                    controller: petNameController,
                    decoration: InputDecoration(
                      labelText: 'Pet Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  
                  DropdownButtonFormField<String>(
  value: selectedPetType, 
  decoration: InputDecoration(
    labelText: 'Select Pet Type',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  items: petType.map((String selecttype) {
    return DropdownMenuItem<String>(
      value: selecttype,
      child: Text(selecttype),
    );
  }).toList(),
  onChanged: (String? newValue) {
    setState(() {
      selectedPetType = newValue!;
    });
  },
),

                  SizedBox(height: 10),

                 DropdownButtonFormField<String>(
  value: selectedCategory, // ✅ ADD THIS
  decoration: InputDecoration(
    labelText: 'Select Category',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  items: category.map((String cat) {
    return DropdownMenuItem<String>(
      value: cat,
      child: Text(cat),
    );
  }).toList(),
  onChanged: (String? newValue) {
    setState(() {
      selectedCategory = newValue!;
    });
  },
),

                  SizedBox(height: 10),
                  
                  TextField(
                  controller: latitudeController,
                  decoration: InputDecoration(
                    labelText: 'latitude',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: getLocation,
                      icon: Icon(Icons.location_on_sharp),
                    ),
                  ),
                  readOnly: true,
                ),

                SizedBox(height: 10),

                TextField(
                  controller: longitudeController,
                  decoration: InputDecoration(
                    labelText: 'longitude',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: getLocation,
                      icon: Icon(Icons.location_on_sharp),
                    ),
                  ),
                  readOnly: true,
                ),
                
                SizedBox(height: 5),
                  
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  
                SizedBox(height: 10),
                  
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      minimumSize: Size(width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      showSubmitDialog();
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pickimagedialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  openCamera(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  openGallery(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> openCamera(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      if (kIsWeb) {
        webImages[index] = await pickedFile.readAsBytes();
        setState(() {});
      } else {
        images[index] = File(pickedFile.path);
      }
    }
  }

  Future<void> openGallery(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        webImages[index] = await pickedFile.readAsBytes();
        setState(() {});
      } else {
        images[index] = File(pickedFile.path);
      }
    }
  }

 Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getLocation() async {
    isLoading = true;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Loading...'),
          ],
        ),
      ),
    );
    myposition = await _determinePosition();

    latitudeController.text = myposition.latitude.toString();
    longitudeController.text = myposition.longitude.toString();

    if (isLoading) {
      Navigator.pop(context);
      isLoading = false;
    }
    setState(() {});
  }

  void showSubmitDialog() {
     if (petNameController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please enter the pet's name"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
// ✅ Pet Type validation
if (selectedPetType.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please select the pet type"),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

if (selectedCategory.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please select the category"),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

   
    if (latitudeController.text.trim().isEmpty ||
        longitudeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Use the location icon to get your current latitude and longitude.”",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the description"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (descriptionController.text.trim().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("The description entered is too short"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (webImages[0] == null && images[0] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide at least one image"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Submit Pet'),
          content: const Text('Are you sure you want to submit this pet details?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                submitPet();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void submitPet() {
    String petName = petNameController.text.trim();
    String petType = selectedPetType.trim();
    String category = selectedCategory.trim();
    String latitude = latitudeController.text.trim();
    String longitude = longitudeController.text.trim();
    String desc = descriptionController.text.trim();
    List<String> base64Images = [];

    if (kIsWeb) {
      for (int i = 0; i < maxImg && webImages[i] != null; i++) {
        base64Images.add(base64Encode(webImages[i]!));
      }
    } else {
      for (int i = 0; i < maxImg && images[i] != null; i++) {
        base64Images.add(base64Encode(images[i]!.readAsBytesSync()));
      }
    }

    http
        .post(
          Uri.parse('${MyConfig.baseUrl}/pawpal_pet_adoption/api/submit_pet.php'),

          body: {
          "user_id": widget.user!.userId,
          "pet_name": petName,
          "pet_type": petType,
          "category": category,
          "lat": latitude,
          "lng": longitude,
          "description": desc,
          "images": jsonEncode(base64Images),
          },
        )
       .then((response) {
          print(response.body);
          if (response.statusCode == 200) {
            var jsonResponse = response.body;
            var resarray = jsonDecode(jsonResponse);
            if (resarray['status'] == 'success') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Pet submitted successfully"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(resarray['message']),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        });
  }
}
