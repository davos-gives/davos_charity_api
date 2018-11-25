export function formatPrice(cents) {
  return (cents / 100).toLocaleString("en-CA", {
    style: "currency",
    currency: "CAD",
  });
}

export function shortenCreditCard(cc) {
  let shortenedCc = cc.toString().slice(-4);
  return shortenedCc;
}

export function shortenYear(year) {
  let shortenedYear = year.toString().slice(-2);
  return shortenedYear;
}
