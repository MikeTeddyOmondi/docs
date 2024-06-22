# 8 Best JavaScript One-Liners

[Shivam Singh](https://dev.to/shivamblog)

Posted on Sep 15, 2023

[#javascript](https://dev.to/t/javascript) [#webdev](https://dev.to/t/webdev) [#react](https://dev.to/t/react) [#typescript](https://dev.to/t/typescript)

Hey everyone! If you're new to coding, you're probably excited but maybe a little overwhelmed, right? Don't sweat it! 😅 Today, we're going to look at some really simple but super cool one-liners in JavaScript. These are short lines of code that do something awesome, and they'll save you time and impress your friends. So, grab your favorite snack and let's jump into the magical world of easy-peasy JavaScript tricks!

---

## 1️⃣ Picking a Random Element from an Array

How about some unpredictability in your life? Let's get a random element from an array:  

```
// Input: [1, 2, 3, 4]
const randomElement = arr => arr[Math.floor(Math.random() * arr.length)];
// Output: Something like 2, or 4, or 1...you get it.
```

In the coding world, this is like asking your bartender for a "surprise me" and hoping you don't get Tabasco sauce in your martini. 🍸 You never know what you're gonna get, kinda like life!

---

## 2️⃣ Getting Rid of Duplicate Array Elements

If your array sparks no joy because it’s cluttered with duplicates, clean it up with:  

```
// Input: [1, 2, 2, 3]
const uniqueArray = [...new Set([1, 2, 2, 3])];
// Output: [1, 2, 3]
```

Look at that! Your array is now tidier than a hipster's beard on a Saturday night. ✂️ Goodbye, duplicates! Sayonara, clutter!

---

## 3️⃣ Sorting Array Objects by a Specific Property

Ever wished your objects knew their place? Teach 'em some manners:  

```
// Input: 'name', [{name:'Bob', age:25}, {name:'Alice', age:22}]
const sortBy = (arr, key) => arr.sort((a, b) => a[key] > b[key] ? 1 : -1);
// Output: [{name:'Alice', age:22}, {name:'Bob', age:25}]
```

Voilà! Your objects are now in a straight line, behaving better than kids on a sugar rush. 🍭 Priorities, people!

---

## 4️⃣ Checking if Two Arrays or Objects Are Equal

Are these two things really the same? Time for some self-reflection:  

```
// Input: [1, 2], [1, 2]
const arraysEqual = JSON.stringify([1, 2]) === JSON.stringify([1, 2]);
// Output: true
```

There you have it. As identical as two peas in a pod or the Kardashians before they discovered contouring. 💄

---

## 5️⃣ Make Your Code Wait for a Specific Time

Sometimes we all need to take a breather. Make your code chill out for a sec:  

```
const chill = ms => new Promise(resolve => setTimeout(resolve, ms));
(async () => {
  console.log("Before waiting");
  await chill(2000);
  console.log("After waiting for 2 seconds");
})();
```

It’s like your code took a short vacation. Now it's back, refreshed and ready to rock! 🏖️

---

## 6️⃣ Extract a Property from an Array of Objects

Need to grab a specific property from an array of objects? Cherry-pick it!  

```
const pluck = (arr, key) => arr.map(obj => obj[key]);
console.log(pluck([{x: 1}, {x: 2}], 'x')); // Output: [1, 2]
```

Your code is now as selective as a toddler deciding which vegetable to fling across the room. 🥦

---

## 7️⃣ Inserting an Element at a Specific Position

Why wait your turn? Insert an element wherever you like:  

```
// Input: [1, 2, 4]
const insert = (arr, index, newItem, a=[...arr]) => (a.splice(index, 0, newItem),a);
// Output: [1, 2, 3, 4]
```

Smooth! That element snuck into the array like a teenager sneaking into an R-rated movie. 🎬

---

## 8️⃣ Generate a Random Hexadecimal Color Code

Need a random color? Say no more:  

```
// Input: No input needed
const randomColor = "#" + (~~(Math.random() * 8**8)).toString(16).padStart(6,0);
// Output: Something like #f5a623
```

Tada! Your screen now looks like a unicorn sneezed on it. Beautiful! 🌈

---

## Conclusion: Over to You, Superstar! 🌟

Wow, what a ride! 🎢 We just covered 8 simple but handy shortcuts in JavaScript. These one-liners are like little toolkits 🛠️ that help you do awesome stuff without breaking a sweat. Got any cool shortcuts or tricks you’ve learned and want to share? We're all ears! Drop them in the comments section below. Happy coding, and remember, the best code is the one that makes you smile! 😊

Happy coding, and remember, always keep it sassy and classy! 🍸🎉
