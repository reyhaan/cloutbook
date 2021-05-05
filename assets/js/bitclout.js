var exchangeRate = await fetch("https://api.bitclout.com/get-exchange-rate", {
  credentials: "include",
});
var x = await exchangeRate.json();
return x;
