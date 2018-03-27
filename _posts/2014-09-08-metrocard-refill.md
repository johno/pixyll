---
layout: post
title:  Metrocard Refill Calculator
date:   2014-09-08 19:07:14 -0800
categories: metrocard math
---

Last week I ran accross this post [How Memorizing “$19.05” Can Help You Outsmart the MTA][tumblr-link] and shared it on Facebook. A good friend of mine from my college days, [Steven Su][zz-fb], saw it and worked out the math for those who already own the card and have some remaining balance. He wrote on his facebook status:
> I started thinking, what if you've already bought a card with a leftover balance and you want to know how much to refill your card so that it'll come out even? ... 


<form name="rcal">
	<table>
		<tr>
			<td>Remaining balance on card:</td>
			<td>$ <input type="text" name="amountleft" value="2.45" onchange="calculate();"></td>
		</tr>
		<tr>
			<td>Desired number of rides:</td>
			<td>
				<select name="numrides" onchange="calculate();">
				  <option value="1">1</option>
				  <option value="2" selected="selected">2</option>
				  <option value="3">3</option>
				  <option value="4">4</option>
				  <option value="5">5</option>
				  <option value="6">6</option>
				  <option value="7">7</option>
				  <option value="8">8</option>
				  <option value="9">9</option>
				  <option value="10">10</option>
				  <option value="11">11</option>
				  <option value="12">12</option>
				  <option value="13">13</option>
				  <option value="14">14</option>
				  <option value="15">15</option>
				  <option value="16">16</option>
				  <option value="17">17</option>
				  <option value="18">18</option>
				  <option value="19">19</option>
				  <option value="20">20</option>
				  <option value="21">21</option>
				  <option value="22">22</option>
				  <option value="23">23</option>
				  <option value="24">24</option>
				  <option value="25">25</option>
				  <option value="26">26</option>
				  <option value="27">27</option>
				  <option value="28">28</option>
				  <option value="29">29</option>
				  <option value="30">30</option>
				  <option value="31">31</option>
				  <option value="32">32</option>
				  <option value="33">33</option>
				  <option value="34">34</option>
				  <option value="35">35</option>
				  <option value="36">36</option>
				  <option value="37">37</option>
				  <option value="38">38</option>
				  <option value="39">39</option>
				  <option value="40">40</option>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="button" value="Calculate" onclick="calculate();"></td>
		</tr>
		<tr>
			<td><b>Refill Amount:</b></td>
			<td><b>$<span class="result" id="refill">2.55</span></b><br><span> (add $1 for a new card)</span></td>
		</tr>
		<tr>
			<td>Total balance after refill:</td>
			<td>$<span class="result" id="total">5.00</span></td>
		</tr>
	</table>
</form>


Credits to [Steven Su][zz-fb] for working out the math.

[tumblr-link]: http://iquantny.tumblr.com/post/96700509489/how-memorizing-19-05-can-help-you-outsmart-the-mta
[zz-fb]: https://www.facebook.com/steven.su.716

<script src="/js/refill.js"></script>


