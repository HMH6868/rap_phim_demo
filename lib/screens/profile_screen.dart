import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
        backgroundColor: Colors.red,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 16),
            _buildMenuSection(),
            const SizedBox(height: 16),
            _buildAccountSection(context, themeProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.red,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/31.jpg',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nguyễn Văn A',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'nguyenvana@example.com',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Text(
                  'Thành viên Vàng',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    final menuItems = [
      {
        'icon': Icons.confirmation_number_outlined,
        'title': 'Vé của tôi',
        'subtitle': 'Xem vé đã đặt và lịch sử đặt vé',
      },
      {
        'icon': Icons.favorite_border,
        'title': 'Phim yêu thích',
        'subtitle': 'Danh sách phim đã lưu',
      },
      {
        'icon': Icons.notifications_none,
        'title': 'Thông báo',
        'subtitle': 'Cập nhật phim mới và khuyến mãi',
      },
      {
        'icon': Icons.payment,
        'title': 'Phương thức thanh toán',
        'subtitle': 'Quản lý thẻ và tài khoản',
      },
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            leading: Icon(item['icon'] as IconData, color: Colors.red),
            title: Text(item['title'] as String),
            subtitle: Text(item['subtitle'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to respective screen
            },
          );
        },
      ),
    );
  }

  Widget _buildAccountSection(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final accountItems = [
      {'icon': Icons.person_outline, 'title': 'Chỉnh sửa hồ sơ'},
      {'icon': Icons.location_on_outlined, 'title': 'Địa chỉ'},
      {'icon': Icons.lock_outline, 'title': 'Đổi mật khẩu'},
      {'icon': Icons.help_outline, 'title': 'Trợ giúp & Hỗ trợ'},
      {'icon': Icons.info_outline, 'title': 'Điều khoản và chính sách'},
      {'icon': Icons.logout, 'title': 'Đăng xuất', 'color': Colors.red},
    ];

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SwitchListTile(
            title: const Text('Chế độ tối'),
            secondary: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.red,
            ),
            value: themeProvider.isDarkMode,
            onChanged: (_) {
              themeProvider.toggleTheme();
            },
          ),
        ),
        const SizedBox(height: 16),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: accountItems.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = accountItems[index];
              return ListTile(
                leading: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color? ?? Colors.grey[700],
                ),
                title: Text(
                  item['title'] as String,
                  style: TextStyle(
                    color: item['color'] as Color? ?? Colors.black,
                    fontWeight:
                        item['color'] != null
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Handle action based on index
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
