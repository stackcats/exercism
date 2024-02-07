"""Functions to manage a users shopping cart items."""


def add_item(current_cart, items_to_add):
    for item in items_to_add:
        current_cart[item] = current_cart.get(item, 0) + 1
    return current_cart


def read_notes(notes):
    return dict.fromkeys(notes, 1)


def update_recipes(ideas, recipe_updates):
    ideas |= recipe_updates
    return ideas


def sort_entries(cart):
    sorted_card = dict(sorted(cart.items()))
    return sorted_card


def send_to_store(cart, aisle_mapping):
    fulfillment_cart = {}
    for (k, v) in cart.items():
        fulfillment_cart[k] = [v, *aisle_mapping[k]]
    return dict(sorted(fulfillment_cart.items(), reverse=True))


def update_store_inventory(fulfillment_cart, store_inventory):
    for k in store_inventory:
        if k not in fulfillment_cart:
            continue
        
        count = store_inventory[k][0] - fulfillment_cart[k][0]
        store_inventory[k][0] = count > 0 and count or "Out of Stock"

    return store_inventory

