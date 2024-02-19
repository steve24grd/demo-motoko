import { dbank_backend } from '../../declarations/dbank_backend';

window.addEventListener("load", async () => {
  //console.log("finished loading");
  await update();
});

document.querySelector("form").addEventListener("submit", async (e) => {
  // override the default form submission behavior
  e.preventDefault();
  //console.log("Submitted");

  const button = e.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);

  button.setAttribute("disabled", true);

  if (document.getElementById("input-amount").value.length != 0) {
    await dbank_backend.topUp(inputAmount);
  }
  
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);
  
  if (document.getElementById("withdrawal-amount").value.length != 0) {
    await dbank_backend.withdraw(outputAmount);
  }

  await update();

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";
  button.removeAttribute("disabled");

  // const result = await dbank.deposit(amount);
  // console.log("deposit result", result);
  // window.location.reload();
} );

async function update() {
  const currentAmount = await dbank_backend.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100; // round to 2 decimal places
}