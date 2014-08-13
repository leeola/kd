

<!-- Start /Users/leeolayvar/projects/kdf/src/components/loader/loaderview.coffee -->

## exports

KDLoaderView is a view to display a spinning loading symbol. Built into
some Views, such as KDButtonView.

## Usage

```coffee
view = new KDLoaderView
  showLoader: true
  loaderOptions:
    color: '#ff0000'
    shape: 'spiral'

appView.addSubView view
```

Creates a red spiral loader, that shows once it's added to another view.

## KDLoaderView(options, data)

Options supports the following keys.
- **options.tagName**: The type of html element to house this
  loader spinner. tagName defaults to `<span>`.
- **options.showLoader**: Whether or not to show the loader. Defaults to
  false.
- **options.size**: An `Object` with the dimensions of this loader.
  Supports the following keys.
  - **width**: The width of the loader, in pixels. Default `24`
  - **height**: The height of the loader, in pixels. Default `24`
- **loaderOptions**: Options for the loader. Supports the following keys.
  - **color**: The color of the loader, in 6 digit hex form. Defaults to
    `#000000`
  - **shape**: The shape of this loader. Supports the following strings
    `"spiral", "oval", "square", "rect", "roundRect"`. Defaults to `"rect"`
  - **diameter**: The diameter of the loader. Supports a range between
    `10` and `200`. Defaults to `20`.
  - **density**: The number of visual objects within the loader. Such as dots
    within the spinner. Supports a range between `5` and `160`. Defaults to
    `12`
  - **range**: The amount of the loader that the animation covers. Such as
    the "tail" on the spiral spinner. Supports a range between `0.1` and
    `2`. Defaults to `1`
  - **speed**: The speed of the spinner. Supports a range between `1` and
    `10`. Defaults to `1`
  - **FPS**: The Frames Per Second of the loading animation. Supports a
    range between `1` and `60`. Defaults to `24`

### Params: 

* **Object** *options* 
* **Object** *data* 

## show()

Show the loader

## hide()

Hide the loader

<!-- End /Users/leeolayvar/projects/kdf/src/components/loader/loaderview.coffee -->

