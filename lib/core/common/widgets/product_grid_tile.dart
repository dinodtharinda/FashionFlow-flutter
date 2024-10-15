import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/common/widgets/network_image.dart';
import 'package:flutter/material.dart';

class ProductGridTile extends StatefulWidget {
  const ProductGridTile(
      {super.key,
      required this.product,
      this.onFavoritePress,
      this.onPress,
      this.isFavotire = false});

  final Product product;
  final VoidCallback? onFavoritePress;
  final VoidCallback? onPress;
  final bool isFavotire;

  @override
  State<ProductGridTile> createState() => _ProductGridTileState();
}

class _ProductGridTileState extends State<ProductGridTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: widget.onPress,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.05),
                    child: CustomNetworkImage(
                      imageUrl: widget.product.images.first,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              widget.product.rating.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text('|'),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Stock ${widget.product.stock}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${widget.product.price}",
                          style: const TextStyle(
                            fontSize: 15,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration:  BoxDecoration(
                  shape: BoxShape.circle, color: Theme.of(context).primaryColorDark.withOpacity(0.3)),
              child: IconButton(
                onPressed: widget.onFavoritePress,
                icon: Icon(
                  widget.isFavotire ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
