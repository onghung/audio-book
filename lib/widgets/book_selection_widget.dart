import 'package:flutter/material.dart';

import '../controllers/books_controller.dart';
import '../models/model_book.dart';
import '../views/books_details.dart';

class BookSection extends StatelessWidget {
  final Controller _controller = Controller();
  final String heading;
  BookSection({required this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              child: FutureBuilder<List<Book>>(
                future: _controller.fetchBooks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Book book = snapshot.data![index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => BooksDetails(
                                book: book,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 10,
                                      left: 5,
                                    ),
                                    height: MediaQuery.of(context).size.height * 0.27,
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.4),
                                                blurRadius: 5,
                                                offset: Offset(8, 8),
                                                spreadRadius: 1,
                                              )
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              book.url,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.27,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.4),
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.4),
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    book.name,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    book.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              )
          )
        ],
      ),
    );
  }
}
