import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/book_selection_widget.dart';
import 'books_profile.dart';
import 'package:http/http.dart' as http;

class BooksHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Home2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 70,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BooksProfile(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.no_accounts,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      // Make a request to your API endpoint
                      // Assuming you are using the http package for making HTTP requests
                      // Replace 'http://localhost:8080/pay' with your actual API endpoint
                      http.get(Uri.parse('http://10.0.2.2:8080/pay'))
                          .then((response) {
                        // Handle successful response
                        if (response.statusCode == 200) {
                          // Assuming the response contains the URL to redirect to
                          String url = response.body;
                          // Open the URL in a web browser
                          launch(url);
                        } else {
                          // Handle other status codes
                          print('Failed to get URL: ${response.body}');
                        }
                      })
                          .catchError((error) {
                        // Handle errors
                        print('Error fetching URL: $error');
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 30,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xfffff8ee),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Alice",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 15,
                          bottom: 30,
                        ),
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffc44536),
                        ),
                      ),
                      BookSection(
                        heading: "Continue Reading",
                      ),
                      BookSection(
                        heading: "Discover More",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
