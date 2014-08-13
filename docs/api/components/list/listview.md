

<!-- Start /Users/leeolayvar/projects/kdf/src/components/list/listview.coffee -->

## exports

KDListView is a View that implements a List. By default, this List is not a
`<ul>` or `<ol>`, but rather a series of nested `<divs>`. KDListView takes care
of the ordering and arrangement.

## Usage

Like any other view, we create the instance and add it to another view. In this
case, `appView`. The key here is that after adding our ListView, we have to add
items to our list. We do this with the addItemView method. Lets
see what that looks like.

```coffee
view = new KDListView()

view.addItemView new KDView partial: 'Item 1'
view.addItemView (new KDView partial: 'Item 0'), 0

appView.addSubView header
```

Pretty simple eh? We just called the `addItemView` method and gave it an
instance of a KDView.

Additionally, to demonstrate the index adding, we added the `"Item 0"` view
second, with an index of `0`.

## KDListView(options, data)

### Params: 

* **Object** *options* 
* **Object** *data* 

<!-- End /Users/leeolayvar/projects/kdf/src/components/list/listview.coffee -->

