## ItemTouchHelper 用法

```java
// COMPLETED (3) Create a new ItemTouchHelper with a SimpleCallback that handles both LEFT and RIGHT swipe directions
// Create an item touch helper to handle swiping items off the list
new ItemTouchHelper(new ItemTouchHelper.SimpleCallback(0, ItemTouchHelper.LEFT | ItemTouchHelper.RIGHT) {

    // COMPLETED (4) Override onMove and simply return false inside
    @Override
    public boolean onMove(RecyclerView recyclerView, RecyclerView.ViewHolder viewHolder, RecyclerView.ViewHolder target) {
        //do nothing, we only care about swiping
        return false;
    }

    // COMPLETED (5) Override onSwiped
    @Override
    public void onSwiped(RecyclerView.ViewHolder viewHolder, int swipeDir) {
        // COMPLETED (8) Inside, get the viewHolder's itemView's tag and store in a long variable id
        //get the id of the item being swiped
        long id = (long) viewHolder.itemView.getTag();
        // COMPLETED (9) call removeGuest and pass through that id
        //remove from DB
        removeGuest(id);
        // COMPLETED (10) call swapCursor on mAdapter passing in getAllGuests() as the argument
        //update the list
        mAdapter.swapCursor(getAllGuests());
    }

    //COMPLETED (11) attach the ItemTouchHelper to the waitlistRecyclerView
}).attachToRecyclerView(waitlistRecyclerView);
```
