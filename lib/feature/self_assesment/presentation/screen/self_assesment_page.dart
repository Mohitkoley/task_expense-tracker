import 'package:bloc_test/feature/self_assesment/data/model/category_model.dart';
import 'package:bloc_test/feature/self_assesment/presentation/bloc/assesment_bloc.dart';
import 'package:context_extension/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfAssessmentsPage extends StatefulWidget {
  const SelfAssessmentsPage({super.key});

  @override
  _SelfAssessmentsPageState createState() => _SelfAssessmentsPageState();
}

class _SelfAssessmentsPageState extends State<SelfAssessmentsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AssesmentBloc>().add(GetCategory());
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: BlocConsumer<AssesmentBloc, AssesmentState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AssesmentBloc) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AssesmentLoaded) {
            if (state.categoryList.isEmpty) {
              return const Center(child: Text('No category list available'));
            }

            return Stack(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(state.categoryList[0].categoryIcon)
                _buildBackground(screenWidth, screenHeight),
                _buildMainContent(
                    screenWidth, screenHeight, state.categoryList),
                _buildRecentTestCard(screenWidth),
              ],
            );
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }

  // AppBar widget
  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: const Icon(Icons.arrow_back, color: Colors.black),
      title: const Text(
        "Self Assessments",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      actions: const [
        Icon(Icons.help_outline, color: Colors.black),
        SizedBox(width: 10),
        Icon(Icons.settings, color: Colors.black),
        SizedBox(width: 10),
      ],
    );
  }

  // Background section widget
  Widget _buildBackground(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: const Color.fromARGB(255, 223, 223, 223),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Good Morning Reuben!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Welcome to our free self-assessments! Take charge of your mental health and well-being by exploring these insightful evaluations.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // Main content section widget (categories, top picks, etc.)
  Widget _buildMainContent(
      double width, double height, List<CategoryModel> categoryList) {
    return Positioned(
      top: 190,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildCategorySection(),
            const SizedBox(height: 20),
            _buildTopPicksSection(),
            const SizedBox(height: 20),
            _buildRecentlyTakenSection(categoryList),
          ],
        ),
      ),
    );
  }

  // Categories section widget
  Widget _buildCategorySection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryItem(Icons.sentiment_very_dissatisfied, "Anxiety"),
              _buildCategoryItem(Icons.sentiment_dissatisfied, "Depression"),
              _buildCategoryItem(Icons.flash_on, "ADHD"),
              _buildCategoryItem(Icons.self_improvement, "Autism"),
            ],
          ),
        ],
      ),
    );
  }

  // Top Picks section widget
  Widget _buildTopPicksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Top Picks",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Image.network(
                "https://toppng.com/uploads/preview/happy-person-11545691815zqxsps8ccr.png",
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Personality Test",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Discover your unique \ncharacteristics",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Recently Taken section widget
  Widget _buildRecentlyTakenSection(List<CategoryModel> categoryList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recently Taken",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // _buildRecentTestItem("Social\n Anxiety Test"),
              // _buildRecentTestItem("Psychopathy\n Test"),
              // _buildRecentTestItem("Postpartum Depression\n Quiz"),
              for (var category in categoryList)
                _buildRecentTestItem(
                    category.categoryName, category.totalQuizees),
            ],
          ),
        ),
      ],
    );
  }

  // Widget to build category items (Anxiety, Depression, etc.)
  Widget _buildCategoryItem(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }

  // Widget to build recent test items (Social Anxiety Test, etc.)
  Widget _buildRecentTestItem(String title, body) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: const NetworkImage(
              "https://img.lovepik.com/free-png/20210928/lovepik-girl-working-from-home-png-image_401691433_wh1200.png",
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(body, style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  // Widget for the recent test card
  Widget _buildRecentTestCard(double width) {
    return Positioned(
      top: context.h * 0.15,
      left: (context.w - width * 0.7) / 2,
      child: Container(
        alignment: Alignment.topCenter,
        width: context.w * 0.7,
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 18, 120, 205),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Recent Test",
                    style: TextStyle(fontSize: 21, color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.light_mode_rounded,
                          color: Colors.white, size: 14),
                      Text(
                        "Self-Discovery Assessments",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircularProgressIndicator(
                value: 0.65,
                color: Colors.white,
                backgroundColor: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
