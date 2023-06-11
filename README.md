# Ricmorty

Earnipay mobile developer application test.

## Getting Started

To run the application 

```sh
$ flutter pub get
$ flutter run 

```

### Running Tests

To run all unit tests

```sh
$ flutter test 
```

### Performance Optimization

- Lazy loading and image cache was implemented to improve Image loading and reduce image network request

```sh

  @override

  Widget build(BuildContext context) {

    return CachedNetworkImage(

      imageUrl: image,

      height: height,

      width: width,

      fit: fit,

      progressIndicatorBuilder: (_, url, downloadProgress) => Padding(

        padding: EdgeInsets.symmetric(

            horizontal: SizeConfig.xMargin(_, 15),

            vertical: SizeConfig.yMargin(_, 15)),

        child: CircularProgressIndicator(

          value: downloadProgress.progress,

          color: Colors.brown,

        ),

      ),

      errorWidget: (context, url, error) => const Icon(Icons.error),

    );

  }


```

- cacheExtent property of the GridView.builder allows to control how many offscreen items are retained in the cache.

```sh

cacheExtent: double.maxFinite

```
- pagination and lazy loading. Instead of loading all items at once, load them in smaller batches as the user scrolls. This approach reduces the initial load time and improves performance by only rendering the visible items.
- shouldRebuildSemantics callback. This callback determines whether the semantics information for an item needs to be rebuilt when the widget is updated






