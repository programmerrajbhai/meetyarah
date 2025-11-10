import 'package:flutter/material.dart';

// আপনার কালার ফাইলটি import করতে পারেন, অথবা নিচের Colors.blue ব্যবহার করতে পারেন
// import 'package:meetyarah/assetsPath/textColors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ফেসবুকের মতো হালকা ধূসর ব্যাকগ্রাউন্ড
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          // --- সেকশন ১: প্রোফাইল কার্ড ---
          _buildProfileCard(
            context,
            'Shahadat Hossain', // আপনার নাম
            'See your profile', // সাবটাইটেল
            'https://scontent.fdac179-1.fna.fbcdn.net/v/t39.30808-6/567677708_788823450696325_5639549844313816125_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHH_0pUcly0NO-JWLs3TN4RRpilTbjywadGmKVNuPLBp3KC177Yr7gvJqHvML4mSvd9Tin2vJkLJ71pLr5JysTs&_nc_ohc=0WcSrHaCjPgQ7kNvwFqm4a_&_nc_oc=AdkHOqa2oPZQ1cUVh5SPp25vr6JYq6GfNGecGSrMi0Kk1LA6__cXocL_eEqmHg0yeBk&_nc_zt=23&_nc_ht=scontent.fdac179-1.fna&_nc_gid=YgzxjqSoJiRyR8gWHyktMA&oh=00_AffLG1W_SD6jkyrNCpOg1_OwO_aHtYNf5QL93dXHm6S6WQ&oe=690803AF',
          ),
          const SizedBox(height: 12),

          // --- সেকশন ২: শর্টকাট গ্রিড ---
          _buildShortcutGrid(context),
          const SizedBox(height: 12),

          // --- সেকশন ৩: সেটিংস মেনু লিস্ট ---
          _buildMenuList(context),
          const SizedBox(height: 12),

          // --- সেকশন ৪: লগআউট বাটন ---
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  /// 1. প্রোফাইল কার্ড উইজেট
  Widget _buildProfileCard(
      BuildContext context, String name, String subtitle, String imageUrl) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: প্রোফাইল পেজে নেভিগেট করুন
        },
      ),
    );
  }

  /// 2. শর্টকাট গ্রিড উইজেট
  Widget _buildShortcutGrid(BuildContext context) {
    // ডেমো শর্টকাট আইটেম
    final List<Map<String, dynamic>> shortcuts = [
      {'icon': Icons.group, 'label': 'Groups', 'color': Colors.blue},
      {'icon': Icons.storefront, 'label': 'Marketplace', 'color': Colors.green},
      {'icon': Icons.ondemand_video, 'label': 'Watch', 'color': Colors.red},
      {'icon': Icons.people, 'label': 'Friends', 'color': Colors.lightBlue},
      {'icon': Icons.history, 'label': 'Memories', 'color': Colors.purple},
      {'icon': Icons.bookmark, 'label': 'Saved', 'color': Colors.deepOrange},
    ];

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // প্রতি সারিতে ২টি
            childAspectRatio: 2.5, // আইটেমগুলোর উচ্চতা
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: shortcuts.length,
          shrinkWrap: true, // ListView-এর ভিতরে GridView ব্যবহারের জন্য
          physics: const NeverScrollableScrollPhysics(), // ListView-এর স্ক্রল ব্যবহার করবে
          itemBuilder: (context, index) {
            final item = shortcuts[index];
            return _buildShortcutItem(item['icon'], item['label'], item['color']);
          },
        ),
      ),
    );
  }

  // একটি শর্টকাট আইটেমের ডিজাইন
  Widget _buildShortcutItem(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  /// 3. সেটিংস মেনু লিস্ট উইজেট
  Widget _buildMenuList(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias, // ListTile এর কোনাগুলো কার্ডের সাথে মেলানোর জন্য
      child: Column(
        children: [
          _buildMenuListItem(
            context,
            icon: Icons.settings,
            text: 'Settings & Privacy',
            onTap: () {},
          ),
          _buildMenuListItem(
            context,
            icon: Icons.help_outline,
            text: 'Help & Support',
            onTap: () {},
          ),
          _buildMenuListItem(
            context,
            icon: Icons.info_outline,
            text: 'About',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // একটি মেনু লিস্ট আইটেমের ডিজাইন
  Widget _buildMenuListItem(BuildContext context,
      {required IconData icon,
        required String text,
        required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  /// 4. লগআউট বাটন উইজেট
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // TODO: লগআউট লজিক ইমপ্লিমেন্ট করুন
        },
        child: const Text(
          'Log Out',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}