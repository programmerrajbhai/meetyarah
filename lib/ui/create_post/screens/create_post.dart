import 'dart:io'; // === NEW: File ব্যবহারের জন্য এটি import করুন ===
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meetyarah/assetsPath/textColors.dart'; // আপনার কাস্টম কালার ফাইল

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isPostButtonEnabled = false;

  String _selectedPrivacy = 'Public';
  IconData _privacyIcon = Icons.public;

  // === FIX: null getter-এর বদলে সত্যিকারের ভেরিয়েবল ব্যবহার করা ===
  final List<XFile> _mediaFiles = [];
  final ImagePicker _picker = ImagePicker();
  // ==========================================================

  @override
  void initState() {
    super.initState();
    // টেক্সট ফিল্ড এবং মিডিয়া লিস্ট শোনার জন্য লিসেনার
    _textController.addListener(_updatePostButtonState);
  }

  // === NEW: পোস্ট বাটন এনাবল/ডিজেবল করার জন্য ফাংশন ===
  void _updatePostButtonState() {
    setState(() {
      // টেক্সট অথবা মিডিয়া ফাইল থাকলেই বাটন এনাবল হবে
      _isPostButtonEnabled =
          _textController.text.isNotEmpty || _mediaFiles.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_updatePostButtonState);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(), // AppBar টি বন্ধ রাখা হয়েছে আপনার ডিজাইন অনুযায়ী
      body: SafeArea( // === NEW: UI কে সিস্টেম নোটিফিকেশন বার থেকে নিচে রাখা ===
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildUserInfoRow(),
                    const SizedBox(height: 16),
                    _buildTextField(),
                    const SizedBox(height: 16),
                    // ছবি বা ভিডিওর প্রিভিউ
                    _buildMediaPreview(),
                  ],
                ),
              ),
            ),
            // এই বারটি সব সময় নিচে থাকবে
            _buildAttachmentToolbar(),
          ],
        ),
      ),
    );
  }

  /// 2. ইউজার ইনফো এবং প্রাইভেসি সিলেক্টর
  Widget _buildUserInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
              'https://scontent.fdac179-1.fna.fbcdn.net/v/t39.30808-6/567677708_788823450696325_5639549844313816125_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHH_0pUcly0NO-JWLs3TN4RRpilTbjywadGmKVNuPLBp3KC177Yr7gvJqHvML4mSvd9Tin2vJkLJ71pLr5JysTs&_nc_ohc=0WcSrHaCjPgQ7kNvwFqm4a_&_nc_oc=AdkHOqa2oPZQ1cUVh5SPp25vr6JYq6GfNGecGSrMi0Kk1LA6__cXocL_eEqmHg0yeBk&_nc_zt=23&_nc_ht=scontent.fdac179-1.fna&_nc_gid=YgzxjqSoJiRyR8gWHyktMA&oh=00_AffLG1W_SD6jkyrNCpOg1_OwO_aHtYNf5QL93dXHm6S6WQ&oe=690803AF'),
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shahadat Hossain',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextButton.icon(
              onPressed: _showPrivacySelector,
              icon: Icon(_privacyIcon, size: 16, color: Colors.black54),
              label: Text(
                _selectedPrivacy,
                style: const TextStyle(color: Colors.black54),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[200],
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        // === FIX: "POST" বাটনটিকে ক্লিকযোগ্য এবং লজিকযুক্ত করা ===
        GestureDetector(
          onTap: _isPostButtonEnabled ? _submitPost : null,
          child: Opacity(
            opacity: _isPostButtonEnabled ? 1.0 : 0.5, // ডিজেবল হলে হালকা দেখাবে
            child: Container(
              decoration: BoxDecoration(
                  color: ColorPath.deepBlue,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "POST",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        )
        // ====================================================
      ],
    );
  }

  /// 3. টেক্সট লেখার ফিল্ড
  Widget _buildTextField() {
    return Container(
      child: TextField(
        controller: _textController,
        maxLines: null,
        minLines: 5,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          hintText: "What's on your mind?",
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  /// === NEW: ছবি/ভিডিও প্রিভিউ দেখানোর উইজেট ===
  Widget _buildMediaPreview() {
    if (_mediaFiles.isEmpty) {
      // কোনো ফাইল সিলেক্ট না করা থাকলে খালি জায়গা দেখাবে
      return const SizedBox.shrink();
    }

    return Container(
      height: 120, // প্রিভিউ গ্রিড-এর উচ্চতা
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // এক সারিতে ৩টি আইটেম
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _mediaFiles.length,
        itemBuilder: (context, index) {
          final file = _mediaFiles[index];
          // ফাইল পাথ দেখে ভিডিও কিনা চেক করা
          final isVideo =
              file.path.endsWith('.mp4') || file.path.endsWith('.mov');

          return Stack(
            alignment: Alignment.topRight,
            children: [
              // মূল ছবি বা ভিডিও আইকন
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  image: isVideo
                      ? null // ভিডিও হলে কোনো ছবি দেখাবে না
                      : DecorationImage(
                    image: FileImage(File(file.path)), // dart:io থেকে File
                    fit: BoxFit.cover,
                  ),
                ),
                child: isVideo
                    ? const Center(
                  child: Icon(Icons.videocam_rounded,
                      color: Colors.white, size: 40),
                )
                    : null,
              ),
              // ডিলিট বাটন
              GestureDetector(
                onTap: () {
                  setState(() {
                    _mediaFiles.removeAt(index);
                    _updatePostButtonState(); // বাটন স্টেট আপডেট
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 4. ছবি/ভিডিও যোগ করার টুলবার
  Widget _buildAttachmentToolbar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildToolbarButton(
              icon: Icons.photo_library,
              label: 'Photo',
              color: Colors.green,
              onPressed: _pickImage,
            ),
            _buildToolbarButton(
              icon: Icons.videocam,
              label: 'Video',
              color: Colors.red,
              onPressed: _pickVideo,
            ),
            _buildToolbarButton(
              icon: Icons.person_pin_circle,
              label: 'Location',
              color: Colors.orange,
              onPressed: () {},
            ),
            _buildToolbarButton(
              icon: Icons.tag_faces,
              label: 'Feeling',
              color: Colors.blue,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: Colors.black87,
      ),
    );
  }

  /// 5. প্রাইভেসি সিলেক্ট করার Bottom Sheet
  void _showPrivacySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Public'),
              subtitle: const Text('Anyone can see this post'),
              onTap: () {
                setState(() {
                  _selectedPrivacy = 'Public';
                  _privacyIcon = Icons.public;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Friends'),
              subtitle: const Text('Only your friends can see this post'),
              onTap: () {
                setState(() {
                  _selectedPrivacy = 'Friends';
                  _privacyIcon = Icons.group;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Only Me'),
              onTap: () {
                setState(() {
                  _selectedPrivacy = 'Only Me';
                  _privacyIcon = Icons.lock;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// --- লজিক ফাংশন (Logic Functions) ---

  // === FIX: ফাংশনগুলো ইমপ্লিমেন্ট করা ===

  void _pickImage() async {
    // একবারে একাধিক ছবি সিলেক্ট করার সুবিধা
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _mediaFiles.addAll(images);
        _updatePostButtonState(); // বাটন স্টেট আপডেট
      });
    }
    print('Images picked: ${images.length}');
  }

  void _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _mediaFiles.add(video);
        _updatePostButtonState(); // বাটন স্টেট আপডেট
      });
    }
    print('Video picked: ${video?.path}');
  }

  void _submitPost() {
    if (!_isPostButtonEnabled) return; // বাটন ডিজেবল থাকলে সাবমিট হবে না

    print('Submitting post:');
    print('Text: ${_textController.text}');
    print('Privacy: $_selectedPrivacy');
    print('Media Files: ${_mediaFiles.length}');

    // এখানে আপনার Firebase বা API তে ডেটা পাঠানোর লজিক থাকবে

    // সফলভাবে পোস্ট করার পর এই স্ক্রিনটি বন্ধ করে দিন
    Navigator.of(context).pop();
  }
}