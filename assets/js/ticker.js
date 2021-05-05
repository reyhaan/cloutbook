var ticker = await fetch("https://blockchain.info/ticker", {
  credentials: "include",
});
var y = await ticker.json();
return y;
