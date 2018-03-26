function calculate() {
	var amtCard = document.rcal.amountleft.value;
	var nRides = document.rcal.numrides.value;

	var x = (50 * nRides - 20 * amtCard) / 21;
	var discount = true;

	if ( x < 5 ) {
		x = nRides * 2.50 - amtCard;
		discount = false;
	}

	if ( x < 0 ) {
		x = 0.00 ;
	}

	if ((x.toFixed(2) * 20) % 1) {
		x = roundUpToNickel(x);
	}

	var refill = document.getElementById("refill");

	refill.innerHTML = x.toFixed(2);

	var totalBalance = document.getElementById("total");
	var totalBal = 0.00;

	if ( discount ) {
		totalBal = (amtCard*1.0 + x + x/20);
	} else {
		totalBal = (amtCard*1.0 + x );
	}

	totalBalance.innerHTML = totalBal.toFixed(2);
}

function roundUpToNickel(x) {
	return Math.ceil(x*20) / 20;
}