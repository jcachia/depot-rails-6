import consumer from "./consumer"

consumer.subscriptions.create("ProductsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const storeElement = document.querySelector("main.store") // selecting main element in the store class.
    if (storeElement) {
      storeElement.innerHTML = data.html
    }
  }
});
