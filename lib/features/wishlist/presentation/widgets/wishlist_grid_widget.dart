import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


Widget _buildShimmerEffect() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 15,
        crossAxisCount: 2,
        mainAxisSpacing: 15,
      ),
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      itemCount: 6, // Adjust the count as per your preference
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: 40,
                color: Colors.grey[300],
              ),
            ],
          ),
        );
      },
    );
  }