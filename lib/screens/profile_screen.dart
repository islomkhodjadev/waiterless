import "package:flutter/material.dart";
import "package:waiterless/widgets/appbar.dart";

class ProfileScreen extends StatefulWidget {
  String username;
  ProfileScreen({super.key, required this.username});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen> {
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: "Profile"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Аватар с тенью и кнопкой редактирования
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              "assets/images/product.jpg",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                icon: Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  // Логика для редактирования профиля
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Имя пользователя
                    Text(
                      username,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8.0),

                    // Приветствие
                    Text(
                      "Welcome back!",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 16.0),

                    // Адрес
                    Text(
                      "123 Main St, Springfield",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 8.0),

                    // Email
                    Text(
                      "email@example.com",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
                // Плавающие кнопки "Message" и "Call"
                Positioned(
                  bottom: 32,
                  left: 32,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Логика для вызова
                    },
                    child: Icon(Icons.call),
                    backgroundColor: Colors.green,
                  ),
                ),
                Positioned(
                  bottom: 32,
                  right: 32,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Логика для отправки сообщения
                    },
                    child: Icon(Icons.message),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
